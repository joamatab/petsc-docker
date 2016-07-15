FROM phusion/baseimage

MAINTAINER Marco Zocca, zocca.marco gmail

# # build-related env.variables
# ENV BUILDTYPE ""


# PETSc and SLEPc versions

ENV PETSC_VERSION 3.7.2
ENV SLEPC_VERSION 3.7.1
ENV ARCH=arch-linux2-c-debug
ENV SWDIR=/opt



RUN ./setup.sh ${PETSC_VERSION} ${SLEPC_VERSION} ${ARCH} ${SWDIR}


VOLUME $PETSC_DIR

WORKDIR /home