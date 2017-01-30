FROM ubuntu:latest

MAINTAINER Randy Hommel

RUN apt-get update && apt-get upgrade -y
RUN apt-get install python curl -y
RUN curl -O https://bootstrap.pypa.io/get-pip.py

RUN python get-pip.py
RUN pip install awscli

#RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "/opt/awscli-bundle.zip"
#RUN cd /opt && unzip awscli-bundle.zip
#RUN /opt/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws