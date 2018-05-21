#!/bin/bash
declare -a programs=("skypeforlinux"
                     "google-chrome-stable"
                     "compiz"
                     "compizconfig-settings-manager"
                     "slack"
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

currprogram=skypeforlinux
if [ "${installations[$currprogram]}" = "1" ]; then
  sudo apt install apt-transport-https
  curl https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -
  echo "deb https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skypeforlinux.list
  sudo apt update
  sudo apt install skypeforlinux
fi

currprogram="google-chrome-stable"
if [ "${installations[$currprogram]}" = "1" ]; then
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -curl https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -
  echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
  sudo apt-get update 
  sudo apt-get install google-chrome-stable
fi

currprogram="compizconfig-settings-manager"
if [ "${installations[$currprogram]}" = "1" ]; then
  sudo apt-get install compizconfig-settings-manager compiz-plugins-extra
fi

currprogram="slack"
if [ "${installations[$currprogram]}" = "1" ]; then
  snap install slack --classic
fi
