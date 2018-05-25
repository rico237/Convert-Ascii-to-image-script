#!/bin/bash

if [ -z $1 ]
then
    echo -e "\n\tAucun paramètre fourni.\n\tVeuillez réessayer."
    exit 1

elif [ "$1" == "--help" ]; then
    echo -e "\n\tComment utiliser le script `basename $0` ?\n"
    echo -e "\tL'option  -b  permet de changer la couleur de fond.    (Défaut : black)"
    echo -e "\tL'option  -c  permet de changer la couleur du texte.   (Défaut : white)"
    echo -e "\tL'option  -L  permet de changer la largeur de l'image. (Défaut : 640px)"
    echo -e "\tL'option  -H  permet de changer la hauteur de l'image. (Défaut : 400px)"
    echo -e "\tL'option  -s  permet de changer la taille de fonte.    (Défaut : automatique)"
    echo -e "\tL'option  -f  permet de forcer l'ecrasement d'une image portant le même nom."
    echo -e "\tL'option  --help  permet d'afficher ce menu.\n"

elif [ $# -lt 2 ]; then
    echo -e "\n\tNombre de paramètre insuffisant. \n\tVotre commande doit comporter au minimum les paramètres suivant :"
    echo -e "\t\tLe nom de l'image souhaité ainsi que son extension (ex: image.png)"
    echo -e "\t\tLe texte à transformer en image sous la forme 'ligne 1' .. 'ligne n'"
    echo -e "\n\n\tVeuillez réessayer."
    exit 1
else
    #VARIABLES
    couleur_fond=black
    couleur_text=white
    largeur_image=640
    hauteur_image=400
    file_name=""
    font_size="" 
    force='NO'
    separation='x'
    finalLines=""
    confirmationExecution=''

    exeValide='NO'

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
            largeur_image="$2"
            shift
            shift
            ;;
            -H)
            hauteur_image="$2"
            shift
            shift
            ;;
            -f)
            force=YES
            shift # past argument
            ;;
            *.*)    # option restantes
            file_name="$1" 
            shift # past argument
            ;;
            *)    # option restantes
            finalLines+="$1\n"
            shift # past argument
            ;;
        esac
    done

    # Definit la variable une fois la lecture des arguments faite
    taille=$largeur_image$separation$hauteur_image

    # echo couleur text     = "$couleur_text"
    # echo couleur_fond     = "$couleur_fond"
    # echo FORCE            = "$force"
    # echo File             = "$file_name"
    # echo finalLines       = "$finalLines"

    # -e test si le fichier existe
    if [ -e "$file_name" ]; then 
        # fichier déja existant
        echo -e "\tFichier $file_name est déjà existant."
        if [ $force = 'YES' ]; then
            # lancer la commande sans message de confirmation
            exeValide='YES'
            echo -e "\tOption d'écrasement activé"
        else
            echo -e "\tOption d'écrasement désactivé"
            echo -e "\tSouahitez vous continuer et écraser l'image déjà existante ? (o/n)   "
            read -n 1 confirmationExecution
            
            if [[ ! $confirmationExecution =~ ^[Oo]$ ]]
            then
                echo -e "\tExecution du programme annulé.\n\tVeuillez réessayer."
                exit 1
            fi

            exeValide='YES'
        fi
    else 
        #fichier inexistant
        exeValide='YES'
    fi 

    if [ $exeValide = 'YES' ]; then
        
        if [ -z $font_size ]; then
                convert -background $couleur_fond -fill $couleur_text -size $taille -gravity center label:"$finalLines" $file_name
        else
                convert -background $couleur_fond -fill $couleur_text -size $taille -gravity center -pointsize $font_size label:"$finalLines" $file_name
        fi
        
        case "$OSTYPE" in
          darwin*)  open $file_name ;; # OSX
          linux*)   eog $file_name ;; # Linux
          *)        echo -e "Système : $OSTYPE inconnu. \nPrévisualisation de l'image non affiché." ;;
        esac
        
    fi
        
fi
