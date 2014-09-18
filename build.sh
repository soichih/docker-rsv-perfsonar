#!/bin/bash
#auto built on https://registry.hub.docker.com/u/opensciencegrid/rsv

#create some self-signed host cert to satisfy osg-configure
openssl genrsa -out rsvkey.pem 2048 
openssl req -x509 -nodes -days 3650 \
    -subj '/C=US/ST=Indiana/L=Bloomington/CN=localhost' \
    -newkey rsa:2048 -keyout rsvkey.pem -out rsvcert.pem

docker build -t rsv .
