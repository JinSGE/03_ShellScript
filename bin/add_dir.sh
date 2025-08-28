#!/bin/bash

BASEDIR=/test
mkdir -p $BASEDIR && cd $BASEDIR && rm -rf $BASEDIR/*

for i in $(seq 1 5)
do
    mkdir -p $BASEDIR/$i
    for j in $(seq 1 5)
    do
        mkdir -p $BASEDIR/$i/$j
    done
done

tree $BASEDIR
