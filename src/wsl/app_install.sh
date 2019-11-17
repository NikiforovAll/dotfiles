export DEBIAN_FRONTEND=noninteractive
apt update
apt upgrade -y

# Essential package
# apt -y install build-essential # This one is so big
#  Git
apt -y install git
# nodejs
#------------------------------------------------
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
apt install nodejs
# unzip
#------------------------------------------------
apt install unzip zip
# curl
#------------------------------------------------
apt install curl
# tree
# ------------------------------------------------
apt install tree
# jq
# ------------------------------------------------
apt install jq
# mdcat
# ------------------------------------------------
# apt install mdcat

#jira cli
# ------------------------------------------------
npm install -g cmd-jira
# exa
# ------------------------------------------------
EXA_BUILD="exa-linux-x86_64"
EXA_FILENAME="exa-linux-x86_64-0.9.0.zip"
EXA_URL="https://github.com/ogham/exa/releases/download/v0.9.0/$EXA_FILENAME"
curl -sL $EXA_URL -o "/tmp/$EXA_FILENAME"
unzip "/tmp/$EXA_FILENAME" -d /tmp
mv "/tmp/$EXA_BUILD" /usr/local/bin/exa

# dotnet-sdk
# ------------------------------------------------
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS
# TODO: install dotnet sdk tools in wsl
# TODO: check - https://github.com/dotnet/cli/blob/master/scripts/register-completions.zsh

# docker
# TODO:
