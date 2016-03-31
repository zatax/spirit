#!/bin/bash  



#---------------------------------------#
#					#
#	    CREATION COMPTE		#
#	      ENGIN FRAME		#
#		  TOTAL			#
#					#
#---------------------------------------#


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

AccesRoot () {
        if [ "$(id -u)" != "0" ]; then
                echo "Vous devez être root pour executer ce script"
                exit 1
        fi
        }




####################################
#------ choix serveur distant -----#
####################################

SelectServeurDistant () {

PS3="Choix du serveur"
select SERVEUR in `cat serv.txt`
  do echo $SERVEUR
  break
  done
}


###################################
#------- NOM - PRENOM-------------#
###################################

SelectNameUser () {
        echo
        NOM=""
        PRENOM=""
        while [[ -z $NOM  ]] || [[ -z $PRENOM ]]; do
                read -p "NOM : " | tr ‘[A-Z]’ ‘[a-z]’ NOM
                read -p "PRENOM : " PRENOM 
        
	done
        echo $NOM $PRENOM 
        }

#################################
#------ creation HOME -----------#
#################################



SelectRepHome () {
        echo "choix de la home"
        homedir=""
        while [[ -z $HOMEDIR ]]; do
                read -p "répertoire HOME : " HOMEDIR
        done
        echo $HOMEDIR

        }

#################################
#------ creation INC -----------#
#################################



IncidentItsm () {
        echo "INC compte Total"
        ITSM=""
        while [[ -z $ITSM ]]; do
                read -p "Numéro INC: " ITSM
        done
        echo $ITSM

        }



#################################
#------ creation GID -----------#
#################################


IdentifiantUniqueGroupe () {
        echo "Identifiant unique de compte (GID)"
        IDGroup=""
        while [[ -z $IDGROUP ]]; do
                read -p "GID : " IDGROUP 
        done
        echo $IDGROUP

	if grep "^$IDGROUP" /etc/group > /dev/null; then
                echo "Le groupe n'existe pas, réaffectez l’incident à EP.UNIX-LINUX-EP" 
        	exit
		else
                echo "Groupe OK"
        fi

        }   


#############################################
#---------- création IGG - UID  ------------#
#                                           #
#############################################


CompteUtilisateurTotal () {
        CompteTotal=""
        while [[ -z $COMPTETOTAL ]]; do
                read -p "IGG Total : " COMPTETOTAL
        done
        echo $COMPTETOTAL

        COMPTEUTILISATEUR=${COMPTETOTAL:2} 

        }

#########################################
#---------        SCRIPT        --------#
#					#
#########################################

main () {
#	AccesRoot
	SelectServeurDistant
	IncidentItsm
	IdentifiantUniqueGroupe	
	SelectNameUser
	SelectRepHome	
	CompteUtilisateurTotal
	ssh $SERVEUR  "
	/usr/sbin/useradd -c "$ITSM $NOM $PRENOM" -d $HOMEDIR -s /bin/bash -g $IDGROUP -u $COMPTUTILISATEUR $COMPTETOTAL;
	/usr/bin/passwd $COMPTETOTAL;" 	
}  	
main #>> "fichier1.log" 2 >> "fichier2.log" 
