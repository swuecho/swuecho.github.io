---
layout: post
title:  ssh publickey set up
date:   2014-08-08 10:20 
categories: tech 
---
# ssh publickey set up

## Ubuntu to Centos

### Generating RSA Keys

    mkdir ~/.ssh
    chmod 700 ~/.ssh
    ssh-keygen -t rsa

### Transfer Client Key to Host

    ssh-copy-id <username>@<host>

or

    cp authorized_keys authorized_keys_Backup
    cat id_rsa.pub >> authorized_keys


### troubleshooting

#### configure /etc/ssh/sshd_config 
On the host computer, ensure that the /etc/ssh/sshd_config contains the following lines, and that they are uncommented;

    PubkeyAuthentication yes
    RSAAuthentication yes

#### Centos specific

SELinux permissions prevented the SSH service from accessing the authorized_keys.

Use 

    restorecon -r /root/.ssh 
    
to restore permissions, or turn off SELinux completely.

source: 

https://help.ubuntu.com/community/SSH/OpenSSH/Keys

http://serverfault.com/questions/147859/cant-ssh-from-ubuntu-to-rhel-or-centos

## random thought

It cost me several hours to get it works.

1. I do not know the ssh programe do not give me any debug information or it is my fault failing to find them?
2. I really need to have an general idea (read the document) and then try. To try and error directly is really not good.  


