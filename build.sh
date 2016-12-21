#!/bin/bash

password=$(cat /home/randy/.docker/loginpass.txt)

cd /home/randy/Dropbox/Docker/awstools/awscli

docker build --no-cache --pull -t rkhtech/awscli:latest .

version=$(docker run -it rkhtech/awscli aws --version)
oldversion=$(cat VERSION)
echo -e '# AWSCLI Version:'"\n"'```'"\n$version\n"'```'"\n### I used the following AWS documentation to deploy the awscli toolset:\n[Installing the AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)" > README.md
echo "$version" > VERSION

if [ "$version" != "$oldversion" ]; then
	git add *
	git commit -m "$version"
	git push
	docker login -u rkhtech -p $password
	docker push rkhtech/awscli:latest
fi
