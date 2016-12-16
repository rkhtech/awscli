MAINTAINER randy@hommel.name
FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y
RUN apt-get install python curl jq -y
RUN curl -O https://bootstrap.pypa.io/get-pip.py

RUN python get-pip.py
RUN pip install awscli

