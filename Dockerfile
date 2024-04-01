# fortran-s2i
FROM ubi8/s2i-core:latest

LABEL maintainer="Nick Lawrence <ntl@us.ibm.com>"
LABEL io.openshift.s2i.scripts-url=" /usr/libexec/s2i"

ENV BUILDER_VERSION 1.0

LABEL io.k8s.description="Platform for building Fortran" \
      io.k8s.display-name="builder ${BUILDER_VERSION}" \
      io.openshift.tags="builder,fortran"

RUN dnf -y install gcc-gfortran make \
    && dnf clean all && rm -rf /var/cache/dnf/* && rm -rf /var/cache/yum 

# Copy the S2I scripts to /usr/libexec/s2i, since image
# sets io.openshift.s2i.scripts-url label that way
COPY ./s2i/bin/ /usr/libexec/s2i

RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001


CMD ["/usr/libexec/s2i/usage"]
