#!/bin/bash
source ~/.vars.sh

# Setting up the log file
LOG_FILE=~/install_progress_log.txt

if [[ ! -f LOG_FILE ]]; then
    touch $LOG_FILE
fi

function custom_install {
    {
        sudo pacman -S --noconfirm $1
        echo "$1 Installed" >> $LOG_FILE
    } || {
        echo "$1 FAILED TO INSTALL!!!" >> $LOG_FILE
    }
}

# # terminal stuff
custom_install zsh

custom_install tmux
custom_install neovim
custom_install xclip

custom_install git
custom_install gh

custom_install python
custom_install npm

custom_install github-cli

# commonly used non usefull stuff
custom_install noto-fonts-emoji
custom_install tree
custom_install neofetch
custom_install cmatrix
custom_install fzf

# keyboard related stuff
custom_install xorg-xmodmap
custom_install xorg-xev
custom_install xorg-setkbmap
custom_install xorg-xset

# # custom_installing yay
{
    git clone https://aur.archlinux.org/yay-git.git
    cd yay-git
    makepkg -si

    echo "yay Installed" >> $LOG_FILE
} || {
    echo "yay FAILED TO INSTALL!!!" >> $LOG_FILE
}

# custom_installing google

{
    sudo pacman -S --needed --noconfirm base-devel
    yay -S google-chrome
    echo "google chrome Installed" >> $LOG_FILE
} || {
    echo "google chrome FAILED TO INSTALL!!!" >> $LOG_FILE
}

# insalling gotop
{
    yay -S gotop
    echo "gotop chrome Installed" >> $LOG_FILE
} || {
    echo "gotop chrome FAILED TO INSTALL!!!" >> $LOG_FILE
}

# # custom_installing discord

{
    sudo pacman -s --noconfirm discord
    git clone https://github.com/betterdiscord/betterdiscord.git
    cd betterdiscord
    npm install
    npm run build
    npm run inject
    echo "discord Installed" >> $LOG_FILE
} || {
    echo "discord FAILED TO INSTALL!!!" >> $LOG_FILE
}

# # =======================================

# setup git
{
    gh auth login
    echo "github auth done" >> $LOG_FILE
} || {
    echo "github FAILED TO AUTH!!!" >> $LOG_FILE
}

# Make the code directory
if [ $BASE ]; then
    mkdir -p $BASE/Codes
    mkdir -p $BASE/Codes/scripts
fi

# set zsh to be default shell
if [ ! -r /usr/bin/zsh ]; then
    {
        sudo pacman -S --noconfirm zsh
        chsh -s /usr/bin/zsh
        echo "zsh set as default shell" >> $LOG_FILE
    } || {
        echo "zsh FAILED TO SET TO DEFAULT SHELL!!!" >> $LOG_FILE
    }
fi

{
    sudo pacman -S --noconfirm python-pip
    echo "python-pip Installed" >> $LOG_FILE
} || {
    echo "python-pip FAILED TO INSTALL!!!" >> $LOG_FILE
}

# custom_installing poetry
{
    curl -sSL https://custom_install.python-poetry.org | python3 -
    pip install  pipenv
    echo "pipenv and poetry Installed" >> $LOG_FILE
} || {
    echo "pipenv and poetry FAILED TO INSTALL!!!" >> $LOG_FILE
}

#==============
# https://github.com/mattjmorrison/dotfiles
# Give the user a summary of what has been installed
#==============
clear
echo -e "\n====== Summary ======\n"
cat $LOG_FILE
echo
echo "Enjoy -LrnzDC3696"
# rm $log_file
