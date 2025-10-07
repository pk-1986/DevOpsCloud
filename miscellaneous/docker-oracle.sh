https://gist.github.com/dehsilvadeveloper/c3bdf0f4cdcc5c177e2fe9be671820c7


sudo apt update && sudo apt upgrade -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER
sudo service docker start

===============================================

docker pull gvenzl/oracle-free:slim-faststart

Run a new database container (data is removed when the container is removed, but kept throughout container restarts):

docker run -d -p 1521:1521 -e ORACLE_PASSWORD=<your password> gvenzl/oracle-free
Run a new persistent database container (data is kept throughout container lifecycles):

docker run -d -p 1521:1521 -e ORACLE_PASSWORD=<your password> -v oracle-volume:/opt/oracle/oradata gvenzl/oracle-free
Reset database SYS and SYSTEM passwords:

docker exec <container name|id> resetPassword <your password>

===================================================

sudo docker ps

sudo docker exec -it 1d54dc5861b4 bash

sudo docker exec -it 1d54dc5861b4 bash










