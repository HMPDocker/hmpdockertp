#!/bin/bash

# Script de surcharge qui consomme beaucoup de CPU
while true; do
    dd if=/dev/zero of=/dev/null &
done
