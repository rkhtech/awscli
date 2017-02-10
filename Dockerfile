FROM alpine:latest

MAINTAINER Randy Hommel

RUN apk update && apk upgrade
RUN apk add curl python
RUN curl -O https://bootstrap.pypa.io/get-pip.py

RUN python get-pip.py
RUN pip install awscli
