echo -e "\033[1;33m"
NUMBEROFCLIENTS=$(tail -n +2 /etc/usuarios | grep -c "^V")
if [[ "$NUMBEROFCLIENTS" = '0' ]]; then
echo ""
echo "NAO HA USUARIOS AINDA"
echo -e "\033[0m"
vpspack
exit
