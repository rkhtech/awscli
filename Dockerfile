FROM alpine:latest

MAINTAINER Randy Hommel

RUN apk update && apk upgrade
RUN apk add curl python jq php7-cli
RUN curl -O https://bootstrap.pypa.io/get-pip.py

RUN python get-pip.py
RUN pip install awscli

ADD loop /usr/local/bin/loop
