#!/bin/bash
 
verm="\033[1;31m"
verd="\033[1;32m"
resc="\e[0m"
 
users_num=$(who | grep pts | wc -l)
 
readarray -t users < <(who | awk '{print $1}' | uniq -d)
for ((i=0;i<${#users[*]};i++)); do
    if [[ ${users[$i]} != 'root' ]]; then
        echo -e "Usuário: $verd${users[$i]}$resc conectado: $verm$(who | grep -c ${users[$i]}) vezes $resc"
    fi
done
 
echo -e "\nTotal: $verm$users_num$resc"
