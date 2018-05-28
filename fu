echo -e "\033[1;31m ============================================================= \033[0m"
echo -e "\033[1;34m Usuario          Senha        Limite       Uso      Tempo"
echo -e "\033[1;31m ============================================================= \033[0m"
_cont="0"
if [ ! -e $tempousers ]; then
touch $tempousers
fi
for namer in `awk -F : '$3 > 900 { print $1 }' /etc/passwd |grep -v "nobody" |grep -vi polkitd |grep -vi system-`; do
if [ "$namer" = "" ]; then
break
fi
if [ -e $dir_user/$namer ]; then
_sen=$(cat $dir_user/$namer | grep "senha" | awk '{print $2}')
_limit=$(cat $dir_user/$namer | grep "limite" | awk '{print $2}')
else
_limit="?????"
_sen="?????"
fi
 if [ -z "$_limit" ]; then
_limit="?????"
 fi
 if [ -z "$_sen" ]; then
_sen="?????"
 fi
data_sec=$(date +%s)
data_user=$(chage -l "$namer" |grep -i co |awk -F ":" '{print $2}')
if [ "$data_user" = " never" ]; then
dias_user="\033[1;37mIlimitado"
 else
data_user_sec=$(date +%s --date="$data_user")
 if [ "$data_sec" -gt "$data_user_sec" ]; then
dias_user="\033[1;31mExpirou"
else
variavel_soma=$(($data_user_sec - $data_sec))
dias_use=$(($variavel_soma / 86400))
dias_user="\033[1;32m$dias_use Dias"
 fi
fi
unset SEC
unset MIN
unset HOR
SEC=$(cat $tempousers | grep "$namer" | awk '{print $2}')
number_var $SEC
if [ "$var_number" = "" ]; then
SEC="0"
 else
SEC="$var_number"
fi
hour_var=$(echo "horas" | cut -b 1)
min_var=$(echo "minutos" | cut -b 1)
MIN=$(($SEC / 60))
SEC=$(($SEC - $MIN * 60))
HOR=$(($MIN / 60))
MIN=$(($MIN - $HOR * 60))
txto[1]=$(printf '%-14s' "$namer")
txto[2]=$(printf '%-12s' "$_sen")
txto[3]=$(printf '%-11s' "$_limit")
txto[4]=$(printf '%-9s' "${HOR}${hour_var}${MIN}${min_var}")
txto[5]=$(printf '%-1s' "$dias_user")
unset open_vpn
echo "$(cat /etc/passwd | grep -v ovpn | awk -F : '$3 > 900 { print $1 }' |grep -v "nobody" | grep -vi polkitd |grep -vi system-)" > $_tmp
open_vpn=$(cat $_tmp | grep "$namer")
rm $_tmp
if [ "$open_vpn" != "" ]; then
#user ssh
echo -e " ${txto[1]} ${txto[2]} ${txto[3]} ${txto[4]} ${txto[5]}"
 else
#user openvpn
echo -e " ${txto[1]} ${txto[2]} ${txto[3]} ${txto[4]} ${txto[5]}"
fi
_cont=$(($_cont + 1))
done
echo -e "\033[1;31m ============================================================= \033[0m"
echo -e " ∆ Você Tem: $_cont Usuarios Em Seu Servidor"
echo -e "\033[1;31m ============================================================= \033[0m"
exit
