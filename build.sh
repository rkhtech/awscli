#!/bin/bash

docker build --no-cache --pull -t rkhtech/awscli:latest .

version=$(docker run --rm -it rkhtech/awscli aws --version)
if [ -z "$version" ]; then
	echo "Docker build failed to produce a version number"
	exit
fi
oldversion=$(cat VERSION)

if [ "$version" == "$oldversion" ]; then
	echo "Version matched, skipping"
	if [ "$1" == "-f" ]; then
		echo "Actually, since you want to force me into it I'll build anyways.";
	else
		exit
	fi
fi

cat > README.md << EOF
# AWSCLI Version:
\`\`\`
$version
\`\`\`
### I used the following AWS documentation to install the awscli into the container:
[Installing the AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)

### Docker Hub Location
[rkhtech/awscli](https://hub.docker.com/r/rkhtech/awscli/)

## Installation

\`\`\`
docker pull rkhtech/awscli
\`\`\`

## Usage

### Basic example
\`\`\`
$ docker run -i --rm rkhtech/awscli aws --version
$version
\`\`\`
*OR*
\`\`\`
$ alias aws='docker run -i rkhtech/awscli aws'
$ aws --version
$version
\`\`\`
*Note:* If the container is installed on an EC2 instance, credentials are granted by way of a Role assigned to the Instance the container runs on.  One gotcha is that you will still need to provide the default region to your commands (see below).

### Example using environment variables to pass credentials into container
\`\`\`
docker run -i --rm \\
    -e AWS_DEFAULT_REGION=us-west-2 \\
    -e AWS_ACCESS_KEY_ID=AKIAI67VIZ62T5I76Z6Q \\
    -e AWS_SECRET_ACCESS_KEY=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 \\
    rkhtech/awscli \\
    aws ec2 describe-instances
\`\`\`
*Note:* These credentials have been removed and are no longer valid credentials.

### Passing default region to container
#### Passing as an environment variable to the container:
\`\`\`
docker run -i --rm -e AWS_DEFAULT_REGION=us-west-2 rkhtech/awscli aws ec2 describe-instances
\`\`\`
#### Passing as an option to the aws cli:
\`\`\`
docker run -i --rm rkhtech/awscli aws ec2 describe-instances --region=us-west-2
\`\`\`
EOF

echo "$version" > VERSION

git add *
git commit -m "Automated Build"
git push

cat VERSION
echo
