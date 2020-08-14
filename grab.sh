#!/bin/bash

BUCKET=purplebirdman

# AWS S3 likes to take a prefix without wildcards
[[ -z "$1" ]] && echo "Need file prefix" && exit 1

# For the first item that matches the prefix and ends with .jpg or .png,
# copy it down locally from the bucket
aws s3 ls "s3://${BUCKET}/$1" |
	awk '/.jpg$/ || /.png$/ {print $NF; exit}' |
	xargs -I {} aws s3 cp s3://${BUCKET}/{} .
