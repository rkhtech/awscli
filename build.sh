#!/bin/bash

password=$(cat /home/randy/.docker/loginpass.txt)

cd /home/randy/Dropbox/Docker/awstools/awscli

docker build --no-cache --pull -t rkhtech/awscli .

version=$(docker run -it rkhtech/awscli aws --version)
oldversion=$(cat VERSION)
echo -e '```'"\n$version\n"'```' > README.md

if [ "$version" != "$oldversion" ]; then
	git add *
	git commit -m "$version"
	git push
	docker login -u rkhtech -p $password
	docker push
fi
