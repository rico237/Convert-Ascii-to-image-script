#!/bin/bash

if [ -z $1 ]
then
    echo "Pas de paramètre"
elif [ $# -lt 2 ]; then
    echo "Pas assez d'argument"
else
    #VARIABLES
    couleur_fond=black
    couleur_text=white
    largeur=640
    hauteur=400
    FILE=""
    font_size="" 
    FORCE=NO
    separation='x'
    taille=$largeur$separation$hauteur
    name=""
    finalLines=""

    while [[ $# -gt 0 ]]
    do
        case $1 in
            -b)
            couleur_fond="$2"
            shift # past argument
            shift # past value
            ;;
            -c)
            couleur_text="$2"
            shift # past argument
            shift # past value
            ;;
            -s)
            font_size="$2"
            shift # past argument
            shift # past value
            ;;
            -L)
            largeur="$2"
            shift
            shift
            ;;
            -H)
            hauteur="$2"
            shift
            shift
            ;;
            -f)
            FORCE=YES
            shift # past argument
            ;;
            *)    # unknown option
            if echo "$1" | grep -q '\.png'; then
                echo "c'est un *.png"
                FILE="$1" 
            else
                finalLines+="$1\n"
            fi
            shift # past argument
            ;;
        esac
    done

    echo name             = "$name"
    echo couleur text     = "$couleur_text"
    echo couleur_fond     = "$couleur_fond"
    echo FORCE            = "$FORCE"
    echo File             = "$FILE"
    echo finalLines       = "$finalLines"


    if [ $FORCE == 'YES' ]; then
        echo "OVERWRITE ENABLED"
    # else 
    #     while [ -z $confirmationExecution ] || [ [ $confirmationExecution != 'o' ] && [ $confirmationExecution != 'n' ] ]
    #     do
    #             read -p "Souahitez vous lancer l'exectution du programme ? (o/n)   " -n 1 confirmationExecution
    #     done

    fi 

    # if [ -f "$FILE" ]; then
    #     while [ -z $confirmationExecution ] || [ [ $confirmationExecution != 'o' ] && [ $confirmationExecution != 'n' ] ]
    #     do
    #             read -p "Souahitez vous lancer l'exectution du programme ? (o/n)   " -n 1 confirmationExecution
    #     done

    #     if [ $confirmationExecution == 'n' ]; then
    #         echo -e "\nAnnulé."
    #     elif [ $confirmationExecution == "o" ]; then
    #         echo -e "\nConfirmé."

    #     else
    #         echo -e "\nReponse inconnue.\nExecution annulé."
    #     fi
    # else 
    #     echo "File $1 does not exist"
    # fi 

    if [ -z $font_size ]; then
        echo sans font size
        convert -background $couleur_fond -fill $couleur_text -size $taille -gravity center label:"$finalLines" $FILE
    else
        echo avec font size
        convert -background $couleur_fond -fill $couleur_text -size $taille -gravity center -pointsize $font_size label:"$finalLines" $FILE
    fi

    ls 

fi
