#!/bin/bash 
chown root:docker /var/run/docker.sock
service ssh start
apache2-foreground
