#!/usr/bin/env bash

# Pull latest
sudo apt-get update
sudo apt-get -y upgrade

# Set up ubuntu 14 properly scaling in virtualbox
sudo apt-get -y remove libcheese-gtk23
sudo apt-get -y install xserver-xorg-core
sudo apt-get -y install -f virtualbox-guest-x11

# Setup ubuntu 14 to display system settings
sudo apt-get install unity-control-center

# Install linux tools
sudo apt-get -y install vim tree tmux curl

# Install emacs/spacemacs
mkdir ~/Downloads
pushd ~/Downloads
wget ftp://ftp.gnu.org/pub/gnu/emacs/emacs-24.5.tar.gz
tar -xzvf emacs-24.5.tar.gz
cd emacs-24.5
./configure --without-x
make && sudo make install
popd

# Install development software
sudo apt-get -y install exuberant-ctags cmake ninja-build git

# Install Pathogen for vim (should be in git)
#mkdir -p ~/.vim/autoload ~/.vim/bundle && \
#curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
pushd vim/.vim/bundle
git clone https://github.com/guns/vim-clojure-static.git
git clone https://github.com/kien/rainbow_parentheses.vim.git
git clone https://github.com/tpope/vim-fireplace.git
git clone https://github.com/guns/vim-clojure-highlight.git
popd

# Install Python
sudo apt-get -y install python python-notebook python-pip
sudo apt-get -y install python3-pyside
pip install colorama

# Install C++ Libraries
sudo apt-get -y install ncurses-dev

# TODO: Install qt5

# TODO: Install doxygen

# Install etcd
#   - Requires that we set $CONFIG_DIR in .bashrc
# http://blog.scottlowe.org/2015/04/15/running-etcd-20-cluster/
mkdir -p ~/Downloads/etcd
sudo mkdir /var/etcd
pushd ~/Downloads/etcd
curl -L  https://github.com/coreos/etcd/releases/download/v2.2.5/etcd-v2.2.5-linux-amd64.tar.gz -o etcd-v2.2.5-linux-amd64.tar.gz
tar xzvf etcd-v2.2.5-linux-amd64.tar.gz
cd etcd-v2.2.5-linux-amd64
sudo mv etcd etcdctl /usr/local/bin
sudo cp $CONFIG_DIR/conf/etcd.conf /etc/init
popd

# Install Leiningen (clojure)
sudo wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O /usr/local/bin/lein
sudo chmod 775 /usr/local/bin/lein
bash /usr/local/bin/lein


# Install docker and containers
# http://www.tekhead.org/blog/2014/09/docker-part-1-introduction-and-howto-install-docker-on-ubuntu-14-04-lts/
sudo apt-get -y install apt-transport-https
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
sudo sh -c "echo deb https://get.docker.io/ubuntu docker main\ > /etc/apt/sources.list.d/docker.list"
sudo apt-get -y install lxc-docker apparmor
sudo usermod -aG  docker $USER
docker pull jenkins


