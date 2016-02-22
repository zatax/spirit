#!/bin/bash



test2 () {

filename="serv.txt"
  while read -r line
  do
       serv=$line
       echo "$serv"
  done < "$filename"



}




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
done
}

test2
