#!/bin/bash
payload="/etc/squid3/payload.txt"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-10s\n' "Adicionar Host ao Squid3" ; tput sgr0
if [ ! -f "$payload" ]
then
	tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Arquivo $payload nÃ£o encontrado" ; tput sgr0
	exit 1
else
	tput setaf 2 ; tput bold ; echo ""; echo "DomÃ­nios atuais no arquivo $payload:" ; tput sgr0
	tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
	read -p "Digite o domÃ­nio que deseja adicionar a lista: " host
	if [[ -z $host ]]
	then
		tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "VocÃª digitou um domÃ­nio vazio ou nÃ£o existente!" ; echo "" ; tput sgr0
		exit 1
	else
		if [[ `grep -c "^$host" $payload` -eq 1 ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "O domÃ­nio $host jÃ¡ existe no arquivo $payload" ; echo "" ; tput sgr0
			exit 1
		else
			if [[ $host != \.* ]]
			then
				tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "VocÃª deve adicionar um domÃ­nio iniciando-o com um ponto!" ; echo "Por exemplo: .phreaker56.xyz" ; echo "NÃ£o Ã© necessÃ¡rio adicionar subdomÃ­nios para domÃ­nios que jÃ¡ estÃ£o no arquivo" ; echo "Ou seja, nÃ£o Ã© necessÃ¡rio adicionar recargawap.claro.com.br" ; echo "se o domÃ­nio .claro.com.br jÃ¡ estiver no arquivo." ; echo ""; tput sgr0
				exit 1
			else
				echo "$host" >> $payload && grep -v "^$" $payload > /tmp/a && mv /tmp/a $payload
				tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Arquivo $payload atualizado, o domÃ­nio foi adicionado com sucesso:" ; tput sgr0
				tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
				if [ ! -f "/etc/init.d/squid3" ]
				then
					service squid3 reload
				else
					/etc/init.d/squid3 reload
				fi	
				tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "O Proxy Squid3 foi recarregado com sucesso!" ; echo "" ; tput sgr0
				exit 1
			fi
		fi
	fi
fi
