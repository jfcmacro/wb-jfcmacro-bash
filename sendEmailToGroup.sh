#!/usr/bin/bash

function usage {
    printf "\t$1 -h\n"
    printf "\t$1 [-e execName] [-g <group>]\n"
    printf "\t\tWhere -g (1|2)\n"
    exit $2
}

longprogname=$0
progname=$(basename $longprogname)

while getopts "g:s:h" opt; do
    case $opt in
	h)
	    usage $progname 0
	    ;;
	g)
	    groupFile=$OPTARG
	    ;;
	s)
	    subject=$OPTARG
	    ;;
	*)
	    usage $progname 1
    esac
done

for sendMail in $(awk -F '|' '{ print $3; }' $groupFile)
do
    echo -n "Enviar al usuario: $sendMail "
    read toSend
    if [ "${toSend}" == "s" ]
    then
	echo -n "Nota obtenida: "
	read nota
	echo "Nota: ${nota}" | mailx -v -r "fcardona@eafit.edu.co" -s "${subject}" -S smtp="smtp.office365.com:587" -S smtp-use-starttls -S smtp-auth=login -S smtp-auth-user="fcardona@eafit.edu.co" -S smtp-auth-password="" -S ssl-verify=ignore ${sendMail},fcardona@eafit.edu.co
    fi
done
