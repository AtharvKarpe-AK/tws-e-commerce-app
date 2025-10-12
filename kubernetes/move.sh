#!/bin/bash

<<help

This script is for move files

help

read -p "Enter file which needs to be moved to /home/ubuntu/files/", file

sudo mv ./"$file" /home/ubuntu/files/"$file"

echo "File is moved to /home/ubuntu/files"
ls -ltr /home/ubuntu/files/"$file"
