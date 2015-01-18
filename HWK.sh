#!/bin/bash
function mytree {
if [ -n "$1" ]
	then cd "$1"
fi

if [ -n "$2" ]
	then STR="$2"
	else STR="*.jpg$|*.jpeg$"
fi

printf "\n"
pwd

ls -R | egrep ":$|$STR" | \
sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'

if [ `ls -F -1 | grep "/" | wc -l` = 0 ] 
	then echo " No sub-directories!"
fi

printf "\n"


ls -R -l | egrep "$STR" | awk 'BEGIN { x = 0 } { x += $5 } END { print "Total bytes: " x }'

}

if [ -z "$1" ]
	then
	
	mytree
	printf "\n"
	printf "Or in case we want to be fancy:\n"
	tree $(pwd) -h -P '*.jpg|*.jpeg'

	else

	V=$1
	if [ "$1" == "." ]
		then V=$(pwd)
	fi	
	if [ -z "$2" ]
		then
		
		mytree $V
		printf "\n"
		printf "Or in case we want to be fancy:\n"
		tree $V -h -P '*.jpg|*.jpeg'
		else

		VAL=""
		for i; do
			if [ $i != $1 ]
				then VAL+="*$i$|"
			fi
		done
		VAL=${VAL::-1}
		mytree $V $VAL
		VAL=""
		for i; do
			if [ $i != $1 ]
				then VAL+="*$i|"
			fi
		done
		VAL=${VAL::-1}
		printf "\n"
		printf "Or in case we want to be fancy:\n"
		tree $V -h -P $VAL
fi
fi
