#!/bin/bash
echo " AWS CLI installation ==========================================="
which aws
var=$?
if [ $var -ne 0 ]
  then
   echo " install aws cli "
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install
else
 echo "AWS CLI OK"
 fi
echo #########################################################################
which docker
var=$?
if [ $var -ne 0 ]
  then
   echo " install docker "
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
else
 echo "Docker OK"
 fi
echo #############################################################################################
which terraform
var=$?
if [ $var -ne 0 ]
  then
   echo " install terraform "
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform -y
else
 echo "terraform OK"
 fi
echo ###############################################################
which ansible
var=$?
if [ $var -ne 0 ]
  then
   echo " install ansible "
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
 else
  echo "ansible install ok"
  fi
echo ####################################################################
which psql
var=$?
if [ $var -ne 0 ]
  then
   echo " install psql "
   sudo apt install postgresql postgresql-contrib -y
   sudo systemctl start postgresql.service
   else
    echo "psql install ok"
  fi
  
   
