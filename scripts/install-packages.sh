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
install_package dmenu
install_package rxvt-unicode
install_package docker
install_package visual-studio-code-bin
install_package openssh
install_package mpv # vlc like
install_package unzip
install_package pulsemixer pamixer
install_package qbittorrent
install_package reflector
install_package ttf-iosevka-nerd
install_package nitrogen
install_package nordic-theme
install_package notepadqq
install_package numlockx
# NVIDIA legacy 470xx driver (DKMS for kernel compatibility). Run fix-nvidia.sh after install.
# This legacy branch is required for older GPUs not supported by latest drivers.
# If you upgrade your GPU, change to: nvidia-dkms nvidia-utils (or nvidia nvidia-utils)
install_package nvidia-470xx-dkms nvidia-470xx-utils
install_package lxappearance
install_package github-cli
install_package google-chrome
install_package starship
install_package xclip

# Install obs-studio and obs-teleport together
install_package obs-studio obs-teleport

# echo 'Install ngrok'
# yay -S ngrok --noconfirm

# echo 'Install discord'
# yay -S discord --noconfirm
