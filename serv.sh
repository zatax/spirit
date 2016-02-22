#!/bin/bash


menu1 () {
menu="serv.txt"
while read line
do
	echo $line
	done < $menu
}

menu2 () {  
        f=$(cat serv.txt)
	read -p "Choix:" c
        case $c in
                *) if grep -q $c <<< $f; 
                then
                        echo "choix $c";     
                else
                        echo "choix invalid";
                fi  
       esac    
}



menu3 () {
serv=$(cat serv.txt)
tableau=( ${serv//./ } )
echo ${tableau[@]}
echo ${tableau[2]}
}

menu3
menu2
