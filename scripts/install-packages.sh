#!/bin/bash

# Function to prompt the user for installation of multiple packages
install_package() {
    packages=("$@")
    read -p "Do you want to install ${packages[*]}? [Y/n] " choice
    case "$choice" in
        y|Y|'') yay -S "${packages[@]}" --noconfirm;;
        n|N ) echo "Skipping ${packages[*]} installation..";;
        * ) echo "Invalid choice, skipping ${packages[*]} installation";;
    esac
}

install_package nvm
install_package rxvt-unicode
install_package docker docker-compose
install_package visual-studio-code-bin
install_package openssh
install_package mpv # vlc
install_package unzip
install_package pulsemixer pamixer
install_package qbittorrent
install_package reflector
install_package ttf-iosevka # ttf-iosevka-nerd
install_package nitrogen
install_package nordic-theme
install_package notepadqq
install_package numlockx
install_package nvidia nvidia-utils
install_package lxappearance
install_package github-cli
install_package google-chrome
install_package starship

# Install obs-studio and obs-teleport together
install_package obs-studio obs-teleport

# echo 'Install ngrok'
# yay -S ngrok --noconfirm

# echo 'Install discord'
# yay -S discord --noconfirm