echo -e "\033[1;33m"
touch /tmp/ovpn
touch /tmp/ovpn2
usuario=$(printf '%-18s' "USUARIO")
conexao=$(printf '%-10s' "ONLINE")
echo -e "\033[01;32m-------------------------"
echo -e "\033[01;31m$usuario $conexao\033[00;37m"
echo -e "\033[01;32m-------------------------"
cat /etc/passwd |grep ovpn > /tmp/ovpn
awk -F: '{print $1}' /tmp/ovpn > /tmp/ovpn2
for us1 in $(cat /tmp/ovpn2)
do
us=$(cat /etc/openvpn/openvpn-status.log |grep $us1 |wc -l)
if [ "$us" = "0" ]; then
on="Online"
else 
on="Offline"
fi
usr=$(printf '%-18s' "$us1")
cnx=$(printf '%-10s' "$on")
echo -e "\033[01;33m$usr $cnx\033[0m"
echo -e "\033[01;32m-------------------------"
