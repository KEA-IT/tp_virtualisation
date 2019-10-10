#!/bin/bash

#------déclaration variable globale------#
ip="192.168.33.10"
sync="data"
box="ubuntu/xenial64"
lamp_choice="sudo apt install apache2 mysql-server php7.0"
lamp_choice_char="apache mysql php"

#-----SETUP-----#
if [[ ! -e Vagrantfile ]]
then
    echo "Vagrant.configure("2") do |config|" > Vagrantfile
    echo "config.vm.box = \"$box\"" >> Vagrantfile
    echo "config.vm.network \"private_network\", ip: \"$ip\"" >> Vagrantfile
    echo "config.vm.synced_folder \"$sync\", \"/vagrant_data\"" >> Vagrantfile
    echo "end" >> Vagrantfile
else
    rm Vagrantfile
    Vagrantfile init
    echo "Vagrant.configure("2") do |config|" > Vagrantfile
    echo "config.vm.box = \"$box\"" >> Vagrantfile
    echo "config.vm.network \"private_network\", ip: \"$ip\"" >> Vagrantfile
    echo "config.vm.synced_folder \"$sync\", \"/vagrant_data\"" >> Vagrantfile
    echo "end" >> Vagrantfile
fi

#------déclaration des fonctions------#
menu() {
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
        read -p "quelle est la nouvelle adresse ip : " ip
        echo "Vagrant.configure("2") do |config|" > Vagrantfile
        echo "config.vm.box = \"$box\"" >> Vagrantfile
        echo "config.vm.network \"private_network\", ip: \"$ip\"" >> Vagrantfile
        echo "config.vm.synced_folder \"$sync\", \"/vagrant_data\"" >> Vagrantfile
        echo "end" >> Vagrantfile
        if [[ $(grep -o -i $ip Vagrantfile | wc -l) == 1 ]]
        then
            echo "l'ip a correctement été changé"
        elif [[ $(grep -o -i $ip Vagrantfile | wc -l) == 0 ]]
        then
            echo "l'ip na pas été changé"
        else
            echo "erreur lors de la modification ip"
        fi
        read -p "On continue ?"
        main
    ;;
    2)
        clear
        read -p "quelle est le nouveau nom du dossier syncronisé : " sync
        echo "Vagrant.configure("2") do |config|" > Vagrantfile
        echo "config.vm.box = \"$box\"" >> Vagrantfile
        echo "config.vm.network \"private_network\", ip: \"$ip\"" >> Vagrantfile
        echo "config.vm.synced_folder \"$sync\", \"/vagrant_data\"" >> Vagrantfile
        echo "end" >> Vagrantfile
        if [[ $(grep -o -i $sync Vagrantfile | wc -l) == 1 ]]
        then
            echo "le nom du dossier de syncronisation a été changé"
        elif [[ $(grep -o -i $ip Vagrantfile | wc -l) == 0 ]]
        then
            echo "le nom du dossier de syncronisation n'a pas été changé"
        else
            echo "erreur lors de la modification du dossier de sync"
        fi
        read -p "On continue ?"
        main
    ;;
    3)
        clear
        echo "Quelle box voulez vous installer :"
        echo " 1- ubuntu/xenial64"
        echo " 2- ubuntu/trusty64"
        read -p "Votre choix : " choice_box
        if [[ $choice_box == 1 ]]
        then
            box="ubuntu/xenial64"
        elif [[ $choice_box == 2 ]]
        then
            box="ubuntu/trusty64"
        else
            echo "Erreur lors de la saisie, aucune modification na été prise en compte"
            read -p "Retour au menu"
            main
        fi
        echo "Vagrant.configure("2") do |config|" > Vagrantfile
        echo "config.vm.box = \"$box\"" >> Vagrantfile
        echo "config.vm.network \"private_network\", ip: \"$ip\"" >> Vagrantfile
        echo "config.vm.synced_folder \"$sync\", \"/vagrant_data\"" >> Vagrantfile
        echo "end" >> Vagrantfile
        if [[ $(grep -o -i $box Vagrantfile | wc -l) == 1 ]]
        then
            echo "la box a installer a été changé"
        elif [[ $(grep -o -i $box Vagrantfile | wc -l) == 0 ]]
        then
            echo "la box a installer na pas été changé"
        else
            echo "erreur lors de la modification de la box"
        fi
        read -p "On continue ?"
        main
    ;;
    4)
        clear
        echo "Configuration des paquet pre-installer"
        echo " "
        echo "Apache   MySql   PHP"
        echo "  a        m      p "
        echo "Pour installer Apache et php saisir : ap"
        echo "Pour installer seulement MySql saisir : m"
        echo "Pour installer les trois saisir : amp"
        echo " "
        read -p "Votre choix (dans lordre amp): " lamp_choice
        case $lamp_choice in
            a)
                read -p "Vous avez choisie d'instaler uniquement Apache" a
                lamp_choice="sudo apt install apache2"
                lamp_choice_char="apache"
                main
                ;;
            m)
                read -p "Vous avez choisie d'instaler uniquement MySql" a
                lamp_choice="sudo apt install mysql-server"
                lamp_choice_char="mysql"
                menu
                ;;
            p)
                read -p "Vous avez choisie d'instaler uniquement PHP" a
                lamp_choice="sudo apt install php7.0"
                lamp_choice_char="php"
                menu
                ;;
            am)
                read -p "Vous avez choisie d'installer Apache et MySql" a
                lamp_choice="sudo apt install apache2 mysql-server"
                lamp_choice_char="apache mysql"
                menu
                ;;
            ap)
                read -p "Vous avez choisie d'installer Apache et PHP" a
                lamp_choice="sudo apt install apache2 php7.0"
                lamp_choice_char="apache php"
                menu
                ;;
            mp)
                read -p "Vous avez choisie d'installer MySql et PHP" a
                lamp_choice="sudo apt install mysql-server php7.0"
                lamp_choice_char="mysql php"
                menu
                ;;
            amp)
                read -p "Vous avez choisie d'installer Apache, MySql et PHP" a
                lamp_choice="sudo apt install apache2 mysql-server php7.0"
                lamp_choice_char="apache mysql php"
                menu
                ;;
            *)
                read -p "Erreur lors de la saisie" a
                menu
                ;;
        esac
        ;;
    5)
        clear
        echo "reset du fichier vagrantfile"
        rm Vagrantfile
        vagrant init
        main
        ;;
    6)
        main
    esac


}

main() {
    clear
    echo $lamp_choice_char
    echo "-----------------------------------------------------"
    echo "    Bienvenue dans le créateur de machine virtuel    "
    echo "-----------------------------------------------------"
    echo " "
    echo " Le fichier vargantFile a été créé ici : "
    pwd
    echo " "
    echo " IP = $ip"
    echo " BOX = $box"
    echo " Sync_name = $sync"
    echo " Pre-instalé = $lamp_choice_char"
    echo "-----------------------------------------------------"
    read -p " voulez vous faire des modifications dans le fichier vagrantFile ? (o/n) : " change_file
    if [[ $change_file == "o" ]]; then
        menu
    elif [[ $change_file == "n" ]]; then
        echo "Création du dossier de syncronisation"
        mkdir $sync 
        echo "Lancement de Vagrant"
        vagrant up
        vagrant ssh -c "sudo apt-get update -y"
        vagrant ssh -c "sudo apt-get upgrade -y"
        vagrant ssh -c "$lamp_choice -y"
    else
        echo "Erreur lors de la saisie" && sleep 2
        main
    fi
}

#------main------#
main
