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

# 2. Write the commands to do the following filesystem operations (150
#    points)

# a. Create two users : alice and bob and add them to a group called
#    test_users
#    After executing the commands, use sudo command to print the
#    groups of alice and bob. (Remember to create each user with thier respective
#    home directory)(20 points)

sudo groupadd test_users

sudo useradd -m -g test_users alice
sudo useradd -m -g test_users bob

sudo groups alice
sudo groups bob 

echo ""

# b. Create the following three empty files and one directory inside /home/alice/
#    alice.txt bob.txt both.txt
#    docker_test/
#    List the created files using list command (30 points)

sudo touch /home/alice/{alice.txt,bob.txt,both.txt}

sudo mkdir -p /home/alice/docker_test

sudo ls -ld /home/alice/{alice.txt,bob.txt,both.txt,docker_test} 

echo ""

# c. Make alice the owner of the files alice.txt and both.txt
#    Make bob the owner of bob.txt
#    Change the effective groups of the directory to
#    test_users (30 points)

sudo chown alice:test_users /home/alice/{alice.txt,both.txt}

sudo chown bob:test_users /home/alice/bob.txt

sudo chgrp test_users /home/alice/docker_test

ls -ld /home/alice/{alice.txt,bob.txt,both.txt,docker_test}

echo ""

# d. Write a sample line of text in alice.txt from alice's profile and using
#    access control list, give bob permission to read and write the contents of alice.txt
#    Print the current ACL for alice.txt and run cat on alice.txt from bob's
#    profile (70 points)

sudo apt update
sudo apt install acl -y

echo ""

sudo -u alice bash -c "echo 'alice to bob. I repeat, alice to bob.' >> /home/alice/alice.txt"

sudo setfacl -m u:bob:rw /home/alice/alice.txt

getfacl /home/alice/alice.txt

sudo -u bob cat /home/alice/alice.txt

echo ""

# 3. Initialize /home/alice/docker_test as a git repository and do the following
#    (50 points)

sudo apt install git -y

echo ""

sudo chown -R alice:test_users /home/alice/docker_test

sudo -u alice bash << 'EOF'
cd /home/alice/docker_test

git init

touch Dockerfile

echo 'FROM ubuntu:latest' > Dockerfile
echo 'RUN apt-get update && apt-get install -y nginx' >> Dockerfile

touch app.sh

echo '#!/usr/bin/env bash' > app.sh
echo 'linenum=$(($(cat /var/www/html/*.html -n | tail -1 | awk "{print \$1}") - 2))' >> app.sh

echo 'sed -i "${linenum}i <p> This is the final exam submission of Robert Gallegos on May 13th </p>" /var/www/html/*.html' \
>> app.sh

echo 'sudo service ngninx restart' >> app.sh
chmod +x app.sh
EOF

sudo chown -R alice:test_users /home/alice/docker_test

sudo -u alice bash << 'EOF'
cd /home/alice/docker_test

git config user.name "Alice"
git config user.email "alice1@madeupemail.com"
git add Dockerfile app.sh
git commit -m "New additions: Creation and manipulation of Dockerfile and app.sh"

git log
EOF













