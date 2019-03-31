#!/usr/bin/env bash

set -eo pipefail

# Install rvm for managing different ruby versions.
sudo apt-get update
sudo apt-get install -y --no-install-recommends software-properties-common
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install -y rvm wget
sudo apt-get remove -y software-properties-common

# Make rvm completions available
cat - >> ~/.bashrc <<BASHRC
[[ -r \$rvm_path/scripts/completion ]] && . \$rvm_path/scripts/completion
BASHRC

sudo apt-get update

# Install terraform
TERRAFORM_VERSION=0.11.13
TERRAFORM_SHA256SUM=5925cd4d81e7d8f42a0054df2aafd66e2ab7408dbed2bd748f0022cfe592f8d2
sudo apt-get install -y curl
curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sudo sha256sum -c --strict terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sudo unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    sudo rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    sudo rm -Rf terraform_0.11.13_SHA256SUMS

# Install chef development kit
wget https://packages.chef.io/files/stable/chefdk/3.2.30/ubuntu/18.04/chefdk_3.2.30-1_amd64.deb
sudo dpkg -i chefdk_3.2.30-1_amd64.deb
sudo rm -Rf chefdk_3.2.30-1_amd64.deb

# base ruby distribution
sudo apt-get install -y ruby ruby-dev

# Install stuff that rvm will install itself if not already present...
sudo apt-get install -y gawk zlib1g-dev libyaml-dev libsqlite3-dev sqlite3 \
	autoconf libgmp-dev libgdbm-dev automake libtool bison pkg-config libffi-dev \
	libgmp-dev libreadline6-dev libssl-dev libmysqlclient-dev

# Install pry (improved repl) globally
sudo gem install pry

# semantic completion engine
sudo gem install solargraph

# proper debugger
sudo gem install byebug

# install mysql2
sudo gem install mysql2

# install bundler
sudo gem install bundler

# Plugins
cat /tmp/plugin.vim >> ~/.config/nvim/plugin.vim
cat /tmp/post-plugin.vim >> ~/.config/nvim/post-plugin.vim

# Install plugins ^^
nvim +PlugInstall +qall

# Cleanup
sudo apt-get clean -y
sudo rm -rf /var/lib/apt/lists/*
sudo rm /tmp/plugin.vim
sudo rm /tmp/post-plugin.vim
