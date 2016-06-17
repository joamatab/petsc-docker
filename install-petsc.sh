#!/bin/bash

BUILDTYPE=$1


if [${BUILDTYPE} == "batch"]; then 
    echo "=== Configuring in batch mode"
    ./configure --with-cc=gcc --with-cxx=g++ --with-fc=gfortran --download-fblaslapack --download-mpich --with-batch 
else
    echo "=== Configuring without batch mode"
    ./configure --with-cc=gcc --with-cxx=g++ --with-fc=gfortran --download-fblaslapack --download-mpich
fi

RUN make all && make test
