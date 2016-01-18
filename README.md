PETSc Docker Image
==================

[Docker][docker] image for [PETSc][petsc] and [SLEPc][slepc].

Travis CI: [![Build Status](https://travis-ci.org/ocramz/petsc-docker.svg?branch=master)](https://travis-ci.org/ocramz/petsc-docker)


Build
-----

To visualize options for building the Docker image, run:

    make

Usage
-----

Once the image is built and uploaded to the Docker Hub, you can derive a customized one from it, by using e.g. the following Dockerfile:

    FROM rlincoln/petsc

    ADD petsc1.c /root/petsc1.c
    WORKDIR /root
    RUN gcc -g -v \
      -I/usr/lib/openmpi/include -I/usr/lib/openmpi/include/openmpi \
      -I$PETSC_DIR/include -I$PETSC_DIR/$PETSC_ARCH/include \
      -L/usr/lib -L$PETSC_DIR/$PETSC_ARCH/lib \
      petsc1.c -lpetsc -lmpi

    RUN mpirun -np 2 ./a.out

[docker]: https://www.docker.com/
[petsc]: http://www.mcs.anl.gov/petsc/
[slepc]: http://slepc.upv.es/


Credits
-------

based on https://github.com/rlincoln/petsc

