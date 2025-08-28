#!/bin/bash

for i in $(seq 1 5)
do
    for j in $(seq 1 $i)
    do
        echo -n '*'
    done
    echo 
done
