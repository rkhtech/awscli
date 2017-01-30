#!/bin/bash

password=$(cat /home/randy/.docker/loginpass.txt)

### You should replace this line with the directory where the script is installed  (This is for cron simplicity)
cd /home/randy/Dropbox/git/awscli

docker build --no-cache --pull -t rkhtech/awscli:latest .

version=$(docker run -it rkhtech/awscli aws --version)
oldversion=$(cat VERSION)
echo -e '# AWSCLI Version:'"\n"'```'"\n$version\n"'```'"\n### I used the following AWS documentation to install the awscli into the container:\n[Installing the AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)\n### Docker Hub Location\n[rkhtech/awscli](https://hub.docker.com/r/rkhtech/awscli/)" > README.md
echo "$version" > VERSION

if [ "$version" != "$oldversion" ]; then
	git add *
	git commit -m "$version"
	git push
	docker login -u rkhtech -p $password
	docker push rkhtech/awscli:latest
else
	echo "Version still the same.  Not updating repo."
fi
