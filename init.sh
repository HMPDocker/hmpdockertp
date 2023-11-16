#!/bin/bash 
chown root:docker /var/run/docker.sock
apache2-foreground
