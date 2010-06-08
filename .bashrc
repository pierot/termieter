# EDITOR
######################################################################################################

export EDITOR='mate -w'

# SPECIAL FUNCTIONS
######################################################################################################

netinfo ()
{
echo "--------------- Network Information ---------------"
/sbin/ifconfig | awk /'inet addr/ {print $2}'
echo ""
/sbin/ifconfig | awk /'Bcast/ {print $3}'
echo ""
/sbin/ifconfig | awk /'inet addr/ {print $4}'
# /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
echo "---------------------------------------------------"
}

spin ()
{
echo -ne "${RED}-"
echo -ne "${WHITE}\b|"    
echo -ne "${BLUE}\bx"
sleep .02
echo -ne "${RED}\b+${NC}"
}