# AWSCLI Version:
```
aws-cli/1.11.44 Python/2.7.13 Linux/4.4.0-59-generic botocore/1.5.7
```
### I used the following AWS documentation to install the awscli into the container:
[Installing the AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)

### Docker Hub Location
[rkhtech/awscli](https://hub.docker.com/r/rkhtech/awscli/)

## Installation

```
docker pull rkhtech/awscli
```

## Usage

### Basic example
```
run -i rkhtech/awscli aws --version
```
*OR*
```
$ alias aws='run -i rkhtech/awscli aws'
$ aws --version
```

