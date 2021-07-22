#!/bin/bash

IP_ADDRESS="";
IP_VALUE="";
IP_NUM="";
MAX_IP="";
IP_INC="";
RESULT="";
IP="";

PORT="";
PORT_START="";
PORT_END="";

MASK="";

TEMP="";

SERVER_STATUS="";
PORT_STATUS="";




IP_ADDRESS=$(echo $1 | cut -d/ -f1); # the ip address without the mask
IP_VALUE=0;

for ((i=1; i<=4; i++))
do
    TEMP=$(echo $IP_ADDRESS | cut -d. -f$i); #the four parts of the ip
    let "IP_VALUE *= 256";
    let "IP_VALUE += TEMP";
done;

MASK=$(echo $1 | cut -d/ -f2); # the mask

if [ "$MASK" == "$IP_ADDRESS" ] #then the input dosn't have a mask (third condition)
then
	let "IP_VALUE -= 1";
	IP_NUM=1;

else
	let "IP_NUM = 32 - MASK";
	let "IP_NUM = 2**IP_NUM";
	let "MAX_IP -= 2";
fi

PORT_START=$(echo $2 | cut -d: -f1);
PORT_END=$(echo $2 | cut -d: -f2);

if [ -z "$PORT_START" ] # without a port start
then
	PORT_START=1;
fi

if [ -z "$PORT_END" ] # without a port end
then
	PORT_END=1024;
fi

for ((IP_INC=1; IP_INC<=MAX_IP; IP_INC++))
do
	IP=IP_VALUE;
	let "IP += IP_INC";
	
	for ((i=1; i<=4; i++))
	do
			let "TEMP = IP%256";
			let "IP -= TEMP";
			let "IP /= 256";
		
			if [ "$i" -eq 1 ]
			then
				RESULT="$TEMP"
		else
			RESULT="$TEMP.$RESULT"
		fi
	done
	IP=$RESULT; #the full ip
	
	echo -n -e "server: $IP is \t" >> finalResult.txt;
	
	ping -c1 $IP &>/dev/null
	
	SERVER_STATUS=$?; # the output of the ping operation

	if [ "$SERVER_STATUS" -eq 0 ]
	then
		echo "On" >> finalResult.txt;
	else
		echo "Off" >> finalResult.txt;
		continue;
	fi
	
	for ((PORT=PORT_START; PORT<=PORT_END; PORT++))
	do
		echo -n -e "\t Port: $PORT is \t" >> finalResult.txt;
		&>/dev/null </dev/tcp/$IP/$PORT
		
		PORT_STATUS=$?; # the output of the ping operation
		
		if [ "$PORT_STATUS" -eq 0 ]
		then
			echo "On" >> finalResult.txt;
		else
			echo "Off" >> finalResult.txt;
		fi
	done
done

exit 0;








