#!/bin/bash
if [[ ! -e Vagrantfile ]]
then
    vagrant init
else
    echo " Le fichier vagrantFile est déjà créé"
fi

#------déclaration des fonctions------#
menu(){
clear
echo "-----------------------------------------------------"
echo "   Bienvenue dans l'éditeur de fichier vagrantFile   "
echo "-----------------------------------------------------"
echo " "
echo " 1- Modifier l'adresse ip de la machine virtuel"
echo " 2- Modifier le nom du dossier local de sycronisation"
echo " 3- Modifier la box de la machine virtuel"   
echo " 4- Modifier les paquet à installer"
echo " 5- Reset le fichier vagrantFile"
echo " 6- Quiter l'éditeur"
read -p " Votre choix ? (1, 2, 3, 4) : " modify_choice
case $modify_choice in
    1)
        clear
        echo "vous avez choisie 1"
        read -p "On continue ?"
        main;;
    2)
        clear
        echo "vous avez choisie 2"
        read -p "On continue ?"
        main;;
    3)
        clear
        echo "vous avez choisie 3"
        read -p "On continue ?"
        main;;
    4)
        clear
        echo "vous avez choisie 4"
        read -p "On continue ?"
        main;;
    5)
        main;;
esac
    
}

main(){
clear
echo "-----------------------------------------------------"
echo "    Bienvenue dans le créateur de machine virtuel    "
echo "-----------------------------------------------------"
echo " "
echo " Le fichier vargantFile a été créé ici : "
pwd
echo " "
read -p " voulez vous faire des modifications dans le fichier vagrantFile ? (o/n) : " change_file
if [[ $change_file == "o" ]]
then
    menu
elif [[ $change_file == "n" ]]
then
    echo "on va créer le dossier sync et lancer la vm"
else
    echo "Erreur lors de la saisie" && sleep 2
    main
fi
}

#------main------#
main

