#!/bin/bash

# Set up known hosts
ssh-keyscan -H target1 target2 >> /home/ansible/.ssh/known_hosts

# Copy the public key to the targets
sshpass -p "1234" ssh-copy-id -i /home/ansible/.ssh/id_rsa.pub root@target1
sshpass -p "1234" ssh-copy-id -i /home/ansible/.ssh/id_rsa.pub root@target2

# Run the /bin/bash command
/bin/bash