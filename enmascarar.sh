#!/bin/bash

inicio=`pwd` 

printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Herramienta mejorada por "@AnibalTlgram"\e[0m\n"
printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Grupo: "https://t.me/TheRealHacking"\e[0m\n"

url_checker() {
    if [ ! "${1//:*}" = http ]; then
        if [ ! "${1//:*}" = https ]; then
            echo -e "\e[31m [!] Url invalida. Por favor usa http o https.\e[0m"
            cd $inicio
            bash enmascarar.sh
        fi
    fi
}

printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Pega tu url de phishing aqui (con http o https):\e[0m\n"
printf " \e[36;1m =>\e[0m\e[1;96m\en "
read phish
url_checker $phish
sleep 1
printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Procesando y modificando la url de phishing...\e[0m\n" 
echo ""
short=$(curl -s https://is.gd/create.php\?format\=simple\&url\=${phish})
shorter=${short#https://}
printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Dominio para la url de Phishing (con http o https), ej: https://google.com, http://youtube.com) :\e[0m\n"
printf " \e[36;1m =>\e[0m\e[1;96m\en "
read mask
url_checker $mask
printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Escriba las palabras de ingeniería social:(Como dinero-gratis, trucos-pubg)\e[0m\n"
printf " \e\e[0m\e[0m\e[0m\e[1;93m.:. No utilice espacio, sólo utilice '-' entre las palabras  .:.\e[0m\n"
printf " \e[36;1m =>\e[0m\e[1;96m\en "
read words
printf "\e[0m\n"
final=$mask-$words@$shorter
printf " \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;96m Esta es la URL enmascarada:\e[32m ${final} \e[0m\n"
sleep 100