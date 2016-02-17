#!/bin/bash

######################################
#-----------variable------------------
#
#
#       User    : $user
#       IGG     : $IGG
#       Groupe  : $groupe
#       Serveur : $srv
#
#------------------------------------
#####################################

#####################################
#---------Fonction------------------
#
#	serveur  : choix du serveur 
#	check    : validation fonction	
#	Root     : Check log root
#	confirm  : confirmation Y/N
#	IGG      : cration igg
#	usergroup: Creation user et groupe
#-----------------------------------
####################################

#################################
#------- Choix serveur ---------#
#################################


serveur () {
PS3='Choix du serveur:  '
options=("freppau-lpegf01" "freppau-lpegf02" "freppau-lpegf011" "Quit")
select opt in "${options[@]}"
do
	case $opt in
	"freppau-lpegf01")
            
                srv="freppau-lpegf01"
          echo "vous avez choisi $srv" 
	     break
            ;;
        "freppau-lpegf02")
            	 srv="reppau-lpegf02"
            echo "$srv" 
		break
            ;;
        "freppau-lpegf011")
            echo "choix 3"
                srv="reppau-lpegf011"
            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
}

#################################
#--------- création IGG---------#
#################################


igg () {
	IGG=""
	while [[ -z $IGG ]]; do
		read -p "IGG Total : " IGG
	done
	echo $IGG

}

####################################
#------ fonction check yes/no -----#
####################################

Check () {

	read -p "le choix $i? vous convient-il ?" choice

        	case "$choice" in
                	  y|Y ) echo "yes"
                  	break
                  	;;

                  	n|N ) echo "no"
                  
                  	;;
                  	* ) echo "invalid";;
        	esac
}


#############################################
#----- creation utilisateur et groupe -------#
#############################################


usergroup () {
	user=""
        while [[ -z $user ]]; do
                read -p "Compte Total utilisateur : " user
        done
 
if grep "^$user" /etc/passwd > /dev/null; then
    echo "Ok"
else
    echo "l'utilisateur existe déjà"
fi



	group=""
        while [[ -z $group ]]; do
                read -p "Groupe de l'utilisateur : " group
        done
}


#################################
#----- fonction confimation ----#
#################################

confirm () {

	printf " Le choix vous convient-il ? (y/n) ? " 
	read reponse
	if [ $reponse =  "Y" ] ;then return 0 ; else return 1 ; fi

}

#######################
#-----check Rool------#
#######################

root () {
	if [ "$(id -u)" != "0" ]; then
    		echo "Vous devez être root pour executer ce script"
    		exit 1
	fi
}

####################################
#------ choix serv TXT -------------
####################################


file="serv.txt"
i=1
for line in $(cat serv.txt); do
	echo "${i})${line}"
	((i++))
done  
