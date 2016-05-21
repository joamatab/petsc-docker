# FROM debian:7.7
# FROM ubuntu:14.04
FROM phusion/baseimage

MAINTAINER Marco Zocca, zocca.marco gmail

# PETSc and SLEPc versions

ENV PETSC_VERSION 3.6.2
ENV SLEPC_VERSION 3.6.1

# # env. variables

ENV PETSC_DIR /opt/petsc-$PETSC_VERSION
ENV SLEPC_DIR /opt/slepc-$SLEPC_VERSION
ENV PETSC_ARCH arch-linux2-c-debug
ENV SLEPC_ARCH arch-linux2-c-debug

# # Update APT
RUN apt-get update && apt-get upgrade -y

# # Install compiler tools.
RUN apt-get install -y make gcc gfortran wget curl python pkg-config build-essential

# # Install Valgrind
RUN apt-get install -y valgrind


# # SSH 
# RUN apt-get install -y openssh-client


# # Download and extract PETSc.
WORKDIR /opt
RUN wget --no-verbose http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-$PETSC_VERSION.tar.gz && \
    gunzip -c petsc-lite-$PETSC_VERSION.tar.gz | tar -xof -

WORKDIR $PETSC_DIR

# # Configure and build PETSc.
RUN ./configure --with-cc=gcc --with-fc=gfortran --download-fblaslapack --download-mpich
#  --with-cxx=g++ 

RUN make all && make test




# # Download and extract SLEPc.
WORKDIR /opt
RUN wget --no-verbose http://www.grycap.upv.es/slepc/download/distrib/slepc-$SLEPC_VERSION.tar.gz
RUN gunzip -c slepc-$SLEPC_VERSION.tar.gz | tar -xof -



WORKDIR $SLEPC_DIR



# # Configure and build SLEPc.
RUN ./configure && \
    make all && \
    make test

# # remove .tar.gz
WORKDIR /opt
RUN rm *.tar.gz



# # Add the newly compiled libraries to the environment.
ENV LD_LIBRARY_PATH $PETSC_DIR/$PETSC_ARCH/lib:$SLEPC_DIR/$PETSC_ARCH/lib
ENV PKG_CONFIG_PATH $PETSC_DIR/$PETSC_ARCH/lib/pkgconfig:$SLEPC_DIR/$PETSC_ARCH/lib/pkgconfig



# # # clean temp data
RUN sudo apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


WORKDIR /home