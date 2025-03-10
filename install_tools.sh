#!/bin/bash
sudo apt update
sudo apt install curl

#install google-chrome
if which google-chrome; then
	echo "Google chrome has been installed, skipping installation"
else
	cd ~/Downloads
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	cd ~
	echo "Download google chrome successfully"
fi 


#install nodejs using nvm
if command -v node &>/dev/null; then
	echo "Node.js is already installed, skipping installation"
else
	cd ~
	curl -sL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh
	sudo bash nodesource_setup.sh
	sudo apt install nodejs
fi
echo "node version $(node -v)"
echo "npm version $(npm -v)"

#install git
if command -v git; then
	echo "Git is already installed, skipping installation"
else
	cd ~
	sudo apt install git
	read -p "Enter your name for git: " git_name
	read -p "Enter your email for git: " git_email
	git config --global user.name "$git_name"
	git config --global user.email "$git_email"
fi
echo "git version: $(git --version)"
git config --global --list

#install vscode
if command -v code; then
	echo "Visual Studio Code is already installed, skipping installation"
else
	sudo snap install --classic code
fi
echo "VSC version: $(code --version)"

#install docker
if command -v docker; then
	echo "Docker has been installed, skipping docker installation"
else
	for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
		sudo apt-get remove $pkg
	done
	# install docker using apt
	# Add Docker's official GPG key:
	sudo apt-get update
	sudo apt-get install ca-certificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

	# Add the repository to Apt sources:
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
	$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |
		sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
	sudo apt-get update

	#install docker lastest version
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi
echo "Docker version $(docker --version)"
echo "Docker compose version $(docker compose version)"

#install anyDesk
if which anydesk;then
	echo "anyDesk is already installed, skipping installation"
else
	wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | gpg --dearmor | sudo tee /etc/apt/keyrings/anydesk.gpg
	echo "deb [signed-by=/etc/apt/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
	sudo apt update
	sudo apt install anydesk
	echo "anyDesk is installed successfully"
fi

# Create SSH key for your local machine
cd ~/.ssh
ssh-keygen
echo "Check the public ssh key in ~/.ssh/ folder and copy to the remote server"
cat $(ls ~/.ssh/*.pub | tail -n 1)
cd ~

#python installation
## install anaconda
if which conda;then 
	echo "Anaconda has been installed. skipping install anaconda"
else
	cd ~/Downloads
	wget https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh
	bash ./Anaconda3-2024.10-1-Linux-x86_64.sh
	source ~/.bashrc
	export PATH="$HOME/anaconda3/bin:$PATH"
fi 
conda --version
cd ~

