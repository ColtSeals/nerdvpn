#!/bin/bash

function setup1 (){
clear
echo -e "\033[1;30m•••••> Script Edited ColtSeals TecnologY (NERD's)\033[0m"
echo -e "\033[1;30m•••••> A Internet aproxima quem está longe e afasta quem está perto!\033[0m"
echo -e "\033[01;35m -------------------------------------------------"
echo -e "\033[01;35m|                  \033[01;33m    NERDS VPN\033[01;35m                   |"
echo -e "\033[01;35m -------------------------------------------------"
echo ""
echo -e "\033[01;35m  •\033[01;33mEste script irá:"
echo ""
echo -e "\033[01;35m  •\033[01;32mCONFIGURAR O OPENSSH PARA RODAR NAS PORTAS:\033[01;31m 22\033[01;32m e\033[01;31m 443."
echo -e "\033[01;35m  •\033[01;32mINSTALAR E CONFIGURAR O PROXY SQUID PARA RODAR NAS PORTAS:\033[01;31m 80,\033[01;31m 3128\033[01;32m e\033[01;31m 8080."
echo -e "\033[01;35m  •\033[01;32mINSTALAR UM CONJUNTO DE SCRIPT\033[01;31m (ADM VPS)."
echo ""
echo -ne "\033[01;37m   Aperte a tecla ENTER para prosseguir..."; read ENTER
clear
}

function setup2 (){
cd /root
wget -O ADMVPS.zip https://www.dropbox.com/s/sto4jn6ff9x7sc3/ADMVPS.zip?dl=0 -o /dev/null
sleep 1s
setup4
}
function setup3 (){
clear
echo -e "\033[1;30m•••••> Script Edited ColtSeals TecnologY (NERD's)\033[0m"
echo -e "\033[1;30m•••••> A Internet aproxima quem está longe e afasta quem está perto!\033[0m"
echo -e "\033[01;35m -------------------------------------------------"
echo -e "\033[01;35m|                  \033[01;33m    NERDS VPN\033[01;35m                   |"
echo -e "\033[01;35m -------------------------------------------------"
echo ""
echo -e "\033[01;33m•\033[01;31m Você já possui o NERDS VPN instalado neste servidor!"
echo ""
echo -e "\033[01;33m O banco de dados (\033[01;31m/home/DATABASE\033[01;33m) do NERDS VPN foi localizado,"
echo -e "\033[01;33m deseja mantê-lo ou restaurá-lo durante a instalação?"
echo ""
echo -e "\033[01;31m1 \033[01;33m•\033[01;32m Criar um novo banco de dados."
echo -e "\033[01;31m2 \033[01;33m•\033[01;37m Manter banco de dados atual."
echo ""
read -p " OPÇÃO [1-2]: " -e -i 2 NUMBERS
case $NUMBERS in
  1) rm -rf /home/DATABASE; mkdir /home/DATABASE; mkdir /home/DATABASE/Backups; touch /home/DATABASE/bannerssh.txt; touch /home/DATABASE/messages.txt; touch /home/DATABASE/users.db; awk -F : '$3 >= 500 { print $1 " **** 1" }' /etc/passwd | grep -v "nobody" | sort > /home/DATABASE/users.db;;
  2) echo "ADM VPS " > /dev/null;;
  *) setup3;;
esac
}

function setup4 (){
echo ""
IP=$(wget -qO- ipv4.icanhazip.com)
echo -e "\033[1;33m   PARA A INSTALAÇÃO SER CORRETA É PRECISO O IP.\033[0m"
read -p "   CONFIRME SEU IP:" -e -i $IP ip
if [ -z $IP ]; then
  setup4
  exit
fi
if [ -d "/home/DATABASE" ]; then
  setup3
fi
if [ ! -d "/home/DATABASE" ]; then
  mkdir /home/DATABASE; mkdir /home/DATABASE/Backups; touch /home/DATABASE/bannerssh.txt; touch /home/DATABASE/messages.txt; touch /home/DATABASE/users.db; awk -F : '$3 >= 500 { print $1 " **** 1" }' /etc/passwd | grep -v "nobody" | sort > /home/DATABASE/users.db
fi

PRETTY_NAME=$(cat /etc/os-release | grep "PRETTY_NAME" | sed 's/"//g' | cut -d "=" -f2-)
VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID" | sed 's/"//g' | cut -d "=" -f2-)
echo ""
echo ""
echo -e "\033[01;33m  •\033[01;32mSistema Operacional:\033[01;33m $PRETTY_NAME"
echo -e "\033[01;33m  •\033[01;32mIP:\033[01;33m $IP"
if [ "$VERSION_ID" = "16.04" -o "$VERSION_ID" = "16.10" ]; then
  echo ""
  echo -e "\033[01;33m  •\033[01;32m ATUALIZANDO REPOSITÓRIOS..."
  apt-get update 1> /dev/null 2> /dev/null
  echo -e "\033[01;33m  •\033[01;32m INSTALANDO RECURSOS..."
  apt-get install bc -y 1> /dev/null 2> /dev/null
  apt-get install nano -y 1> /dev/null 2> /dev/null
  apt-get install python -y 1> /dev/null 2> /dev/null
  apt-get install squid -y 1> /dev/null 2> /dev/null
  apt-get install unzip -y 1> /dev/null 2> /dev/null
  echo -e "\033[01;33m  •\033[01;32m INSTALANDO SQUID..."
  echo -e ".claro.com.br\n.vivo.com.br" > /etc/squid/domains.txt
  echo -e "acl url1 url_regex -i '/etc/squid/domains.txt'
acl url2 dstdomain -i 127.0.0.1
acl url3 dstdomain -i localhost
acl url4 dstdomain -i $IP
always_direct allow all

http_access allow url1
http_access allow url2
http_access allow url3
http_access allow url4
http_access deny all

http_port 80
http_port 3128
http_port 8080

visible_hostname ADM VPS

forwarded_for off
pipeline_prefetch on

# ATIVO" > /etc/squid/squid.conf
  service squid restart 1> /dev/null 2> /dev/null
  cat /etc/ssh/sshd_config | grep -v "Banner /home/DATABASE/bannerssh.txt" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config 
  cat /etc/ssh/sshd_config | grep -v "PasswordAuthentication yes" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config 
  cat /etc/ssh/sshd_config | grep -v "PermitEmptyPasswords yes" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config
  cat /etc/ssh/sshd_config | grep -v "Port 443" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config
  echo -e "Banner /home/DATABASE/bannerssh.txt\nPasswordAuthentication yes\nPermitEmptyPasswords yes\nPort 443" >> /etc/ssh/sshd_config
  service ssh restart 1> /dev/null 2> /dev/null
  echo -e "\033[01;33m  •\033[01;32m INSTALANDO SCRIPTS..."; echo "" 
  unzip /root/ADMVPS.zip 1> /dev/null 2> /dev/null
  cd /root/inst*
  bash scripts.sh
  
else
if [ "$VERSION_ID" = "8" -o "$VERSION_ID" = "14.04" ]; then
  echo ""
  echo -e "\033[01;33m  •\033[01;32m ATUALIZANDO REPOSITÓRIOS..."
  apt-get update 1> /dev/null 2> /dev/null
  echo -e "\033[01;33m  •\033[01;32m INSTALANDO RECURSOS..."
  apt-get install bc -y 1> /dev/null 2> /dev/null
  apt-get install nano -y 1> /dev/null 2> /dev/null
  apt-get install python -y 1> /dev/null 2> /dev/null
  apt-get install squid3 -y 1> /dev/null 2> /dev/null
  apt-get install unzip -y 1> /dev/null 2> /dev/null
  echo -e "\033[01;33m  •\033[01;32m INSTALANDO SQUID3..."
  echo -e ".claro.com.br\n.vivo.com.br" > /etc/squid3/domains.txt
  echo -e "acl url1 url_regex -i '/etc/squid3/domains.txt'
acl url2 dstdomain -i 127.0.0.1
acl url3 dstdomain -i localhost
acl url4 dstdomain -i $IP
always_direct allow all

http_access allow url1
http_access allow url2
http_access allow url3
http_access allow url4
http_access deny all

http_port 80
http_port 3128
http_port 8080

visible_hostname ADM VPS

forwarded_for off
pipeline_prefetch on

# ATIVO" > /etc/squid3/squid.conf
  service squid3 restart 1> /dev/null 2> /dev/null
  cat /etc/ssh/sshd_config | grep -v "Banner /home/DATABASE/bannerssh.txt" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config 
  cat /etc/ssh/sshd_config | grep -v "PasswordAuthentication yes" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config 
  cat /etc/ssh/sshd_config | grep -v "PermitEmptyPasswords yes" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config
  cat /etc/ssh/sshd_config | grep -v "Port 443" > ssh.txt
  mv ssh.txt /etc/ssh/sshd_config
  echo -e "Banner /home/DATABASE/bannerssh.txt\nPasswordAuthentication yes\nPermitEmptyPasswords yes\nPort 443" >> /etc/ssh/sshd_config
  service ssh restart 1> /dev/null 2> /dev/null
  echo -e "\033[01;33m  •\033[01;32m INSTALANDO SCRIPTS..."; echo "" 
  unzip /root/ADMVPS.zip 1> /dev/null 2> /dev/null
  cd /root/inst*
  bash scripts.sh
else
  echo ""
  echo -e "\033[01;33m Sistema Operacional incompatível! ;-;"
  rm -rf /root/ADMVPS.zip
  rm -rf /root/setup.sh
  echo -e "\033[01;37m"
  exit
fi
fi
clear
echo -e "\033[01;35m -------------------------------------------------"
echo -e "\033[01;35m|                  \033[01;33m    NERDS VPN\033[01;35m                   |"
echo -e "\033[01;35m -------------------------------------------------"
echo ""
echo -e "\033[01;32m ADM VPS foi instalado com sucesso!"
echo ""
echo -e "\033[01;36m INSTALADO NERD VPN! \033[01;31m[ AGUARDE ]"
sleep 3s
echo -e "\033[0m"
h
echo -e "$KEY" > /home/DATABASE/admvps.txt
echo "$IP" >/home/DATABASE/IP.txt
echo "$IP" >/home/DATABASE/IPMENU.txt
echo h >> ~/.bashrc 
rm /root/setup.sh
echo ""
service squid restart 1> /dev/null 2> /dev/null
service squid3 restart 1> /dev/null 2> /dev/null
exit
}

setup1
setup2

