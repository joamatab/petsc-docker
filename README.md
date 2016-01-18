PETSc Docker Image
==================

[Docker][docker] image for [PETSc][petsc] and [SLEPc][slepc].

Travis CI: [![Build Status](https://travis-ci.org/ocramz/petsc-docker.svg?branch=master)](https://travis-ci.org/ocramz/petsc-docker)


Options
-------

Use `make <target> [ACCOUNTNAME=<accountname>]` where `<accountname>` is
your docker account name and `<target>` is one of

    help     to display this help message

    build    to build the docker image

    login    to login to your docker account

    push     to push the image to the docker registry


Usage
-----

Once the image is built and uploaded ("pushed") to the Docker Hub, you can derive a customized one from it, by using e.g. the following Dockerfile:

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

