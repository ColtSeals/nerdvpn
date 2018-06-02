#!/bin/bash

clear
while true; do
echo -e "\033[1;37m •••••••••••••••••••••••••••••••••••••••••••••••••••••••\033[0m"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' " MONITOR MenuVPS " ; tput sgr0
echo -e "\033[1;37m •••••••••••••••••••••••••••••••••••••••••••••••••••••••\033[0m"
echo -e "\033[1;37m •••••••••••••••••••••••••••••••••••••••••••••••••••••••\033[0m"
echo -e " \033[47;30m    Usuario  Concectados  Limite  Status \033[0m"
echo -e "\033[1;37m •••••••••••••••••••••••••••••••••••••••••••••••••••••••\033[0m"
for _user in $(awk -F: '$3>=1000 {print $1}' /etc/passwd); do
if [[ ! -z $(cat /etc/openvpn/*.log|grep ,${_user},) ]]; then
_conn=$(cat /etc/openvpn/*.log|grep ,${_user},| wc -l)
cnx=$(printf '%-10s' "$on")
on="0"
else 
on="1"
echo -e "\033[1;33m    $(printf '%-41s%s' $_user $_conn $limite $status \033[0m"
echo -e "\033[1;37m ------------------------------------------------------\033[0m"
  done
  echo ""
  echo -e "\033[01;36m APERTE CTRL+C PARA SAIR DO MONITOR..."
  sleep 6s
done
