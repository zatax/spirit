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




#############################################
#---------- création IGG - UID  ------------#
#    					    #
#	UID = IGG du compte moins les	    # 
#	      les deux premièrs caractères  #
#					    #
#############################################

IGG () {
	IGG=""
	while [[ -z $IGG ]]; do
		read -p "IGG Total : " IGG
	done
	echo $IGG
	
	UID2=${IGG:2}
	
	}



#################################
#------ creation GID -----------#
#################################



gid () {
        echo "Identifiant unique de compte (GID)"
	gid=""
        while [[ -z $gid ]]; do
                read -p "GID : " gid 
        done
        echo $gid

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
#-----check Root------#
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


menu1 () {
	echo "Choix du serveur"
	serv=$(cat serv.txt)
	tableau=( ${serv//./ } )

	eval set ${tableau[@]}
	select opt in "$@" 
	do
		echo $opt  
			if [ "$opt"="quit" ]; then
        		break
			fi
	done 
	} 



#################################
#------ creation HOME -----------#
#################################



home () {
        echo "choix de la home"
	home=""
        while [[ -z $home ]]; do
                read -p "répertoire HOME : " home 
        done
        echo $home

	}




#################################
#------ creation INC -----------#
#################################



INC () {
	echo "INC compte Total"
	INC=""
        while [[ -z $INC ]]; do
                read -p "Numéro INC: " INC 
        done
        echo $INC

	}





###################################
#------- NOM - PRENOM-------------#
###################################

name () {
	echo
	NOM=""
	PRENOM=""
	while [[ -z $NOM  ]] || [[ -z $PRENOM ]]; do 
                read -p "NOM : " NOM 
                read -p "PRENOM : " PRENOM
        done 
        echo $NOM $PRENOM
        }

   
###################################
#------- Verif User --------------#
###################################

#if [ -n "$(grep $user /etc/passwd)"] then
#...
#fi

name


while [[ -z $NOM  ]] || [[ -z $PRENOM ]]; do 
                read -p "NOM : " NOM 
                read -p "PRENOM : " PRENOM
        done 
        echo $NOM $PRENOM
        }   
