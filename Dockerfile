#FROM debian:stable
FROM ubuntu:14.02

MAINTAINER Marco Zocca, zocca.marco gmail

# Select the latest stable releases of PETSc and SLEPc.

ENV PETSC_VERSION 3.6.2
ENV SLEPC_VERSION 3.6.1

# # Update APT
RUN apt-get update

# # Install compiler tools.
RUN apt-get install -y make gcc gfortran wget curl python pkg-config



# # PETSc requires BLAS, LAPACK and MPI.
# RUN apt-get install -y libblas-dev liblapack-dev libopenmpi-dev openmpi-bin openssh-client


# # Download and extract PETSc.
WORKDIR /opt
RUN wget --no-verbose http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-$PETSC_VERSION.tar.gz
RUN gunzip -c petsc-lite-$PETSC_VERSION.tar.gz | tar -xof -

ENV PETSC_DIR /opt/petsc-$PETSC_VERSION
ENV PETSC_ARCH arch-linux2-c-debug

WORKDIR $PETSC_DIR



# # Configure and build PETSc.
# RUN ./configure
#  --with-mpi=0 \
#  --with-debugging=0 \
#  --with-threadcomm --with-pthreadclasses \
#  --download-superlu \
#  --with-64-bit-indices
RUN ./configure --with-cc=gcc --with-cxx=g++ --with-fc=gfortran --download-fblaslapack --download-mpich
RUN make all
RUN make test




# # Download and extract SLEPc.
WORKDIR /opt
RUN wget --no-verbose http://www.grycap.upv.es/slepc/download/distrib/slepc-$SLEPC_VERSION.tar.gz
RUN gunzip -c slepc-$SLEPC_VERSION.tar.gz | tar -xof -

ENV SLEPC_DIR /opt/slepc-$SLEPC_VERSION

WORKDIR $SLEPC_DIR



# # Configure and build SLEPc.
RUN ./configure
RUN make all
RUN make test



# # Add the newly compiled libraries to the environment.
ENV LD_LIBRARY_PATH $PETSC_DIR/$PETSC_ARCH/lib:$SLEPC_DIR/$PETSC_ARCH/lib
ENV PKG_CONFIG_PATH $PETSC_DIR/$PETSC_ARCH/lib/pkgconfig:$SLEPC_DIR/$PETSC_ARCH/lib/pkgconfig

