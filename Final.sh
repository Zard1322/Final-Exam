#!/usr/bin/env bash

###################
# Copyright (c) Robert Gallegos May 13 2025
###################

# 1. Answer the following questions using Unix user commands (50 points)
#    Using sed and awk to trim the output of commands to provide the exact answer
#    will get 10%% extra points on each question\n\n"

# a. What is the current version of Linux kernel you are using?

echo ""

echo "The current version of Linux kernel I am using is: "

uname -r | awk -F- '{print $1}'

echo ""

# b. Print the linux distribution that you are using.

echo "The linux distribution that I am using is: "

lsb_release -d | awk -F':\t' '{print $2}'

echo ""

# c. What is the current version of bash you are using?

echo "The current version of bash I am using is: "

echo "$BASH_VERSION" | sed 's/-.*//'

echo ""

# d. What is the PID of the current bash process?

echo "The PID of the current bash process is: "

ps -p $$ -o pid= | awk '{print $1}'

echo ""

# e. Print the file permission string of this script.

echo "The file permission string of this script is: "

ls -l "$0" | awk '{print $1}'

echo "" 
