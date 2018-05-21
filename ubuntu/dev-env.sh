#!/bin/bash
declare -a programs=("code"
                     "tree"
                     "curl"
                     "xclip"
                     "git"
                     "nodejs"
                     "npm"
                     "default-jre"
                     "default-jdk"
                     "docker"
                     "dotnet"
                     "fish"
                    )
declare -A installations

for program in "${programs[@]}"
do
  echo "Program: $program"
  if [ -x "$(command -v $program)" ]; then
    echo "Info: $program is installed."
    installations["$program"]=0
  else
    echo "Info: $program is not installed." 
    installations["$program"]=1
  fi
done

currprogram="code"
if [ "${installations[$currprogram]}" = "1" ]; then
  sudo add-apt-repository -y "deb https://packages.microsoft.com/repos/vscode stable main"
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EB3E94ADBE1229CF
  sudo apt update
  sudo apt -y install code
  code --intall-extension Shan.code-settings-sync
fi


currprogram="curl"
echo "${installations[$currprogram]}"
if [ "${installations[$currprogram]}" = "1" ]; then
  sudo apt-get install curl 
fi

currprogram="xclip"
echo "${installations[$currprogram]}"
if [ "${installations[$currprogram]}" = "1" ]; then
  sudo apt-get install curl 
fi


currprogram="tree"
if [ "${installations[$currprogram]}" = "1" ]; then
  sudo apt install tree
fi

currprogram="git"
if [ "${installations[$currprogram]}" = "1" ]; then
  sudo apt install $currprogram
  git config --global user.name "NikiforovAll"
  git config --global user.email "nikiforovalekcey@gmail.com"
  git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
  git config --global alias.st status
  git config --global alias.ll "log --pretty=format:'%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate --numstat"
  git config --global alias.ls "log --pretty=format:'%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate"
fi

# Assets
currprogram="fonts-firacode"
if [ ! -f ~/.local/share/fonts/FiraCode-Medium.ttf ]; then
  # sudo add-apt-repository universe
  # sudo apt update
  # sudo apt install fonts-firacode
  mkdir -p ~/.local/share/fonts
  for type in Bold Light Medium Regular Retina; do
    wget -O ~/.local/share/fonts/FiraCode-${type}.ttf "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true";
    fc-cache -f
  done
fi

currprogram="nodejs"
if [ "${installations[$currprogram]}" = "1" ]; then
  sudo apt install $currprogram
fi

currprogram="npm"
if [ "${installations[$currprogram]}" = "1" ]; then
  sudo apt install $currprogram
fi

currprogram="default-jre"
if [ "${installations[$currprogram]}" = "1" ]; then
  sudo apt install $currprogram -y 
fi

currprogram="default-jdk"
if [ "${installations[$currprogram]}" = "1" ]; then
  sudo apt install $currprogram -y 
fi

currprogram="docker"
if [ "${installations[$currprogram]}" = "1" ]; then
  sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
  
  sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
  
  sudo apt-get update
  sudo apt-get install docker-ce -y
  sudo apt install docker.io
fi

currprogram="dotnet"
if [ "${installations[$currprogram]}" = "1" ]; then
  wget -q packages-microsoft-prod.deb https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  sudo apt-get install apt-transport-https
  sudo apt-get update
  #TODO: update version
  sudo apt-get install dotnet-sdk-2.1.200 -y
fi

currprogram="fish"
if [ "${installations[$currprogram]}" = "1" ]; then
  sudo apt install fish
  sudo chsh -s /usr/bin/fish
  sudo mkdir -p ~/.config/fish
fi

