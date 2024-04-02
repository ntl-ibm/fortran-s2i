# Copyright 2024 IBM All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Dockerfile for an image to BUILD a runtime image from fortran source
FROM ubi8/s2i-core:latest

LABEL maintainer="Nick Lawrence <ntl@us.ibm.com>"
LABEL io.openshift.s2i.scripts-url="file:///usr/libexec/s2i"

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

# This default user is created in the base image
USER 1001


CMD ["/usr/libexec/s2i/usage"]
