#!/bin/bash

# if [ $# -ge 1 ]
# then

# fi

#VARIABLES
couleur_fond=black
couleur_text=white
largeur=640
hauteur=600
# WidthxHeight.    WxH
font_size=none 
FILE=$1
FORCE=NO

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -b)
    $couleur_fond="$2"
    shift # past argument
    shift # past value
    ;;
    -c)
    $couleur_text="$2"
    shift # past argument
    shift # past value
    ;;
    -s)
    font_size="$2"
    shift # past argument
    shift # past value
    ;;
    -f)
    FORCE=YES
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

echo FILE EXTENSION  = "${EXTENSION}"
echo SEARCH PATH     = "${SEARCHPATH}"
echo couleur text = "$couleur_text"
echo couleur_fond    = "$couleur_fond"
echo FORCE         = "${FORCE}"
echo POSITIONAL      = "${POSITIONAL[0]}"
echo "Number files in SEARCH PATH with EXTENSION:" $(ls -1 "${SEARCHPATH}"/*."${EXTENSION}" | wc -l)
if [[ -n $1 ]]; then
    echo "Last line of file specified as non-opt/last argument:"
    tail -1 "$1"
fi

if [ $FORCE == 'YES' ]; then
    echo "OVERWRITE ENABLED"
else 
    read -p "Souahitez vous lancer l'exectution du programme ? (o/n)   " -n 1 confirmationExecution
fi 

if [ $confirmationExecution == 'n' ]; then
    echo -e "\nAnnulé."
elif [ $confirmationExecution == "o" ]; then
    echo -e "\nConfirmé."
else
    echo -e "\nReponse inconnue.\nExecution annulé."
fi

if [ -f "$FILE" ]; then
    echo "File $1 exists"
else 
    echo "File $1 does not exist"
fi 



# if [ $font_size = 'none' ]; then
    #convert -background $couleur_fond -fill $couleur_text label:yo image.png
# else
    #convert -background $couleur_fond -pointsize $font_size -fill $couleur_text label:yo image.png
# fi
