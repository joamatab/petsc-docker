PETSc Docker Image
==================

[Docker][docker] image for [PETSc][petsc] and [SLEPc][slepc].

Travis CI: [![Build Status](https://travis-ci.org/ocramz/petsc-docker.svg?branch=master)](https://travis-ci.org/ocramz/petsc-docker)


Options
-------

Use `make <target>` where `<target>` is one of

    help     display this help message

    rbuild   build remotely (on Docker hub)

    build    build the docker image

    pull     fetch precompiled image from Docker hub

    rebuild  '', ignoring previous builds

    login    login to your docker account

    push     build and upload the image to Docker hub

    run      build and run the image on the local machine


Usage
-----

Once the image is uploaded to the Docker Hub, you can derive a customized one from it, by using e.g. the following Dockerfile:

    FROM ocramz/petsc-docker

    ADD petsc1.c /root/petsc1.c
    WORKDIR /root
    RUN gcc -g -v \
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

