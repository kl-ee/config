# Install docker and containers
# http://www.tekhead.org/blog/2014/09/docker-part-1-introduction-and-howto-install-docker-on-ubuntu-14-04-lts/
sudo apt-get -y install apt-transport-https
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
sudo sh -c "echo deb https://get.docker.io/ubuntu docker main\ > /etc/apt/sources.list.d/docker.list"
sudo apt-get -y install lxc-docker apparmor
sudo apt-get -y install docker.io
sudo systemctl unmask docker.service
sudo systemctl unmask docker.socket
sudo systemctl start docker.service
sudo usermod -aG  docker $USER
docker pull jenkins

shutdown -r now

