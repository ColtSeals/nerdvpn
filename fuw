#!/bin/bash
to="coltpfa@gmail.com"
from="remetente@a.com.br"
subject="URGENTE - Login realizado no SERVER"
IGNIP="IP_IGNORE.txt"

w|awk '/([0-9]{1,3}\.){3}[0-9]{1,3}/{print $1,$3,$4}' > CONECTADOS.txt
if [ -s CONECTADOS.txt ];then
    while IFS=" " read -r user ip hora ;do
       if ! grep -qx "^$user $ip $hora$" $IGNIP;then
       mensagem="Usuario: $user realizou o login a partir do IP: $ip as: $hora"
       #TESTANDO
       echo -e " To:$to\n From:from\n Assunto:$subject\n MENSAGEM:mensagem"
       #Notifica via e-mail
#       cat <<EOF | sendmail -t
#       From:$from
#       To:$to
#       Subject:$subject
#       $mensagem
#      EOF
       echo "$user $ip $hora" >> $IGNIP
       fi
       done<CONECTADOS.txt
fi
