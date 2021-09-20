#!/bin/bash

echo "Actualizando repositorios"
sudo apt-get update
clear
echo "Instalando dependencias"
sudo apt-get install php ssh wget unzip gnome-terminal curl dbus-x11 -y
