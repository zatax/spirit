#!/bin/bash 


#---------------------------------------#
#					#
#	    CREATION COMPTE		#
#	      ENGINE FRAME		#
#		  TOTAL			#
#					#
#---------------------------------------#

#########################################
#					#
#-------|    variables  |---------------#
#					#
#					#
#       Serveur : $opt			# 
#	NOM	: $NOM			#
#       PRENOM	: $PRENOM		#
#       HOME	: $HOME			#
#       INC	: $INC			#
#	GID	: $gid			#
#	IGG	: $IGG			#
#	UID	: $UID2			#
#					#
#---------------------------------------#
#########################################

#########################################
#					#
#--------|    Fonction   |--------------#
#					#
#					#
#       ROOT	: Check ROOT		#
#	MENU1	: Choix serveur 	#
#       name	: NOM et PRENOM		#
#       home	: HOME 			#
#       INC	: INC			#
#       GID     : création GROUPE	#
#	IGG	: IGG			#
#					#
#---------------------------------------#
#########################################




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

SelectServeurDistant () {

PS3="Choix du serveur"
select serveur in `cat serv.txt`
  do echo $serveur
  break
  done
}


###################################
#------- NOM - PRENOM-------------#
###################################

NomPrenomUser () {
        echo
        NOM=""
        PRENOM=""
        while [[ -z $NOM  ]] || [[ -z $PRENOM ]]; do
                read -p "NOM : " NOM
                read -p "PRENOM : " PRENOM
        done
        echo $NOM $PRENOM
        }

#################################
#------ creation HOME -----------#
#################################



selectRepHome () {
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



IncidentItsm () {
        echo "INC compte Total"
        INC=""
        while [[ -z $INC ]]; do
                read -p "Numéro INC: " INC
        done
        echo $INC

        }



#################################
#------ creation GID -----------#
#################################


IdentifiantUniqueGroupe () {
        echo "Identifiant unique de compte (GID)"
        gid=""
        while [[ -z $gid ]]; do
                read -p "GID : " gid 
        done
        echo $gid

	if grep "^$gid" /etc/group > /dev/null; then
                echo "Le groupe n'existe pas, réaffectez l’incident à EP.UNIX-LINUX-EP" 
        	exit
		else
                echo "Groupe OK"
        fi

        }   


#############################################
#---------- création IGG - UID  ------------#
#                                           #
#       UID = IGG du compte moins les       # 
#             les deux premièrs caractères  #
#                                           #
#############################################


CompteUtilisateurTotal () {
        IGG=""
        while [[ -z $IGG ]]; do
                read -p "IGG Total : " IGG
        done
        echo $IGG

        UID2=${IGG:2} 

        }

#########################################
#---------        SCRIPT        --------#
#					#
#########################################

main () {
	root
	menu1
	sudo ssh $opt
	INC
	name
	home	
	gid
	IGG
	/usr/sbin/useradd -c "$inc $NOM $PRENOM" -d $home -s /bin/bash -g $GID -u $UID2 $IGG
	/usr/bin/passwd $IGG 	
}

main
