## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)

## General info
This project creates an arm webserver in AWS.
It is expecting two security groups to exist:
allow_web
allow_ssh


## Technologies
Project is created with:
* Terraform (no specific version)
* AWS - creates a t4ga.nano server
* Is expecting ENV vars for aws access and secretk keys:
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"

## Setup
To run this project, ensure your aws keys are exported and run:

```
$ terraform init
$ terraform plan
$ terraform apply
```
