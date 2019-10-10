#!/bin/bash

#------déclaration variable globale------#
ip="192.168.33.10"
sync_local="data"
sync_dist="/vagrant_data"
box="ubuntu/xenial64"
lamp_choice="sudo apt install apache2 mysql-server php7.0"
lamp_choice_char="apache mysql php"

#-----SETUP-----#
if [[ ! -e Vagrantfile ]]
then
    echo "Vagrant.configure(\"2\") do |config|" > Vagrantfile
    echo "config.vm.box = \"$box\"" >> Vagrantfile
    echo "config.vm.network \"private_network\", ip: \"$ip\"" >> Vagrantfile
    echo "config.vm.synced_folder \"$sync_local\", \"$sync_dist\"" >> Vagrantfile
    echo "end" >> Vagrantfile
fi

#------déclaration des fonctions------#
menu() {
    clear
    echo "-----------------------------------------------------"
    echo -e "\e[39m \e[31m    Bienvenue dans l'éditeur de fichier vagrantFile  \e[39m  "
    echo "-----------------------------------------------------"
    echo " "
    echo " 1- Modifier l'adresse ip de la machine virtuel"
    echo " 2- Modifier le nom du dossier local de sycronisation"
    echo " 3- Modifier le nom du dossier distant de syncronisation"
    echo " 4- Modifier la box de la machine virtuel"
    echo " 5- Modifier les paquet à installer"
    echo " 6- Reset le fichier vagrantFile"
    echo " 7- Quiter l'éditeur"
    read -p " Votre choix ? (1, 2, 3, 4, ...) : " modify_choice
    case $modify_choice in
        1)
            clear
            read -p "quelle est la nouvelle adresse ip : " ip
            echo "Vagrant.configure(\"2\") do |config|" > Vagrantfile
            echo "config.vm.box = \"$box\"" >> Vagrantfile
            echo "config.vm.network \"private_network\", ip: \"$ip\"" >> Vagrantfile
            echo "config.vm.synced_folder \"$sync_local\", \"$sync_dist\"" >> Vagrantfile
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
            menu
        ;;
        2)
            clear
            read -p "quelle est le nouveau nom du dossier syncronisé : " sync_local
            echo "Vagrant.configure(\"2\") do |config|" > Vagrantfile
            echo "config.vm.box = \"$box\"" >> Vagrantfile
            echo "config.vm.network \"private_network\", ip: \"$ip\"" >> Vagrantfile
            echo "config.vm.synced_folder \"$sync_local\", \"$sync_dist\"" >> Vagrantfile
            echo "end" >> Vagrantfile
            if [[ $(grep -o -i $sync_local Vagrantfile | wc -l) == 1 ]]
            then
                echo "le nom du dossier de syncronisation a été changé"
            elif [[ $(grep -o -i $ip Vagrantfile | wc -l) == 0 ]]
            then
                echo "le nom du dossier de syncronisation n'a pas été changé"
            else
                echo "erreur lors de la modification du dossier de sync"
            fi
            read -p "On continue ?"
            menu
        ;;
        3)
            clear
            read -p "quelle est le nouveau nom du dossier syncronisé : " sync_dist
            echo "Vagrant.configure(\"2\") do |config|" > Vagrantfile
            echo "config.vm.box = \"$box\"" >> Vagrantfile
            echo "config.vm.network \"private_network\", ip: \"$ip\"" >> Vagrantfile
            echo "config.vm.synced_folder \"$sync_local\", \"$sync_dist\"" >> Vagrantfile
            echo "end" >> Vagrantfile
            if [[ $(grep -o -i $sync_dist Vagrantfile | wc -l) == 1 ]]
            then
                echo "le nom du dossier de syncronisation a été changé"
            elif [[ $(grep -o -i $ip Vagrantfile | wc -l) == 0 ]]
            then
                echo "le nom du dossier de syncronisation n'a pas été changé"
            else
                echo "erreur lors de la modification du dossier de sync"
            fi
            read -p "On continue ?"
            menu
        ;;
        4)
            clear
            echo "Quelle box voulez vous installer :"
            echo " 1- ubuntu/xenial64"
            echo " 2- ubuntu/trusty64"
            echo " 3- ubuntu/bionic64"
            read -p "Votre choix : " choice_box
            if [[ $choice_box == 1 ]]
            then
                box="ubuntu/xenial64"
            elif [[ $choice_box == 2 ]]
            then
                box="ubuntu/trusty64"
            elif [[ $choice_box == 3 ]]
            then
                box="ubuntu/bionic64"
            else
                echo "Erreur lors de la saisie, aucune modification na été prise en compte"
                read -p "Retour au menu"
                menu
            fi
            echo "Vagrant.configure(\"2\") do |config|" > Vagrantfile
            echo "config.vm.box = \"$box\"" >> Vagrantfile
            echo "config.vm.network \"private_network\", ip: \"$ip\"" >> Vagrantfile
            echo "config.vm.synced_folder \"$sync_local\", \"$sync_dist\"" >> Vagrantfile
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
            menu
        ;;
        5)
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
                    read -p "Vous avez choisie d'instaler uniquement Apache" 
                    lamp_choice="sudo apt install apache2"
                    lamp_choice_char="apache"
                    menu
                ;;
                m)
                    read -p "Vous avez choisie d'instaler uniquement MySql" 
                    lamp_choice="sudo apt install mysql-server"
                    lamp_choice_char="mysql"
                    menu
                ;;
                p)
                    read -p "Vous avez choisie d'instaler uniquement PHP" 
                    lamp_choice="sudo apt install php7.0"
                    lamp_choice_char="php"
                    menu
                ;;
                am)
                    read -p "Vous avez choisie d'installer Apache et MySql" 
                    lamp_choice="sudo apt install apache2 mysql-server"
                    lamp_choice_char="apache mysql"
                    menu
                ;;
                ap)
                    read -p "Vous avez choisie d'installer Apache et PHP" 
                    lamp_choice="sudo apt install apache2 php7.0"
                    lamp_choice_char="apache php"
                    menu
                ;;
                mp)
                    read -p "Vous avez choisie d'installer MySql et PHP" 
                    lamp_choice="sudo apt install mysql-server php7.0"
                    lamp_choice_char="mysql php"
                    menu
                ;;
                amp)
                    read -p "Vous avez choisie d'installer Apache, MySql et PHP" 
                    lamp_choice="sudo apt install apache2 mysql-server php7.0"
                    lamp_choice_char="apache mysql php"
                    menu
                ;;
                *)
                    read -p "Erreur lors de la saisie"
                    menu
                ;;
            esac
        ;;
        6)
            ip="192.168.33.10"
            sync_local="data"
            sync_dist="/vagrant_data"
            box="ubuntu/xenial64"
            clear
            echo "reset du fichier vagrantfile"
            echo "Vagrant.configure(\"2\") do |config|" > Vagrantfile
            echo "config.vm.box = \"$box\"" >> Vagrantfile
            echo "config.vm.network \"private_network\", ip: \"$ip\"" >> Vagrantfile
            echo "config.vm.synced_folder \"$sync_local\", \"$sync_dist\"" >> Vagrantfile
            echo "end" >> Vagrantfile
            main
        ;;
        7)
            main
        ;;
        *)
            read -p "Erreur lors de la saisie"
            menu
        ;;
    esac
    
    
}

main() {
    clear
    echo "-----------------------------------------------------"
    echo -e "\e[39m \e[31m    Bienvenue dans le créateur de machine virtuel \e[39m    "
    echo "-----------------------------------------------------"
    echo " "
    echo " Le fichier vargantFile va etre été créé ici : "
    pwd
    echo " "
    echo " IP = $ip"
    echo " BOX = $box"
    echo " Sync_local = $sync_local"
    echo " Sync_dist = $sync_dist"
    echo " Pre-instalé = $lamp_choice_char"
    echo "-----------------------------------------------------"
    read -p " voulez vous faire des modifications dans le fichier vagrantFile ? (y/n) : " change_file
    if [[ $change_file == "y" ]]
    then
        menu
    elif [[ $change_file == "n" ]]
    then
        read -p " Voulez vous lancer la box (y/n) : " run_vagrant
        if [[ $run_vagrant == "y" ]]
        then
            echo "Création du dossier de syncronisation"
            mkdir $sync_local
            vagrant up
            vagrant ssh -c "sudo apt-get update -y"
            vagrant ssh -c "$lamp_choice -y"
            vagrant_manager
        elif [[ $run_vagrant == "n" ]]
        then
            vagrant_manager
            read -p "la box a été créé retour au gestionnaire de box"
            vagrant_manager
        else
            read -p "Erreur lors de la saisie (rappel y/n)"
            main
        fi
    else
        read -p "Erreur lors de la saisie"
        main
    fi
}

instaler_vagrant_virtual (){
    clear
    echo "-----------------------------------------------------"
    echo -e " \e[39m \e[31m            Installation de vagrant    \e[39m            "
    echo "-----------------------------------------------------"
    echo "                                                     "
    if [[ $(dpkg -s vagrant | grep -o -i Status) == "Status" ]]
    then
        echo " vagrant est deja installé, super !"
    else
        echo " vagrant n'est pas installé, dommage !"
        read -p " t'inquiète pas on peux l'installer ensemble si tu veux ? (y/n) : " vagrant_instal
        if [[ $vagrant_instal == "y" ]]
        then
            sudo apt install vagrant -y
        elif [[ $vagrant_instal == "n" ]]
        then
            read -p " pas de problème au revoir, appuie sur une touche pour sortir"
            exit
        else
            echo " Erreur lors de la saisie" && sleep 2
            instaler_vagrant_virtual
        fi
    fi
    
    if [[ $(dpkg -s virtualBox | grep -o -i Status) == "Status" ]]
    then
        echo " virtualBox est deja installé, super !"
    else
        echo " virtualBox n'est pas installé, dommage !"
        read -p " t'inquiète pas on peux l'installer ensemble si tu veux ? (y/n) : " virtualBox_instal
        if [[ $virtualBox_instal == "y" ]]
        then
            sudo apt install virtualbox -y
        elif [[ $virtualBox_instal == "n" ]]
        then
            read -p " pas de problème au revoir, appuie sur une touche pour sortir"
            exit
        else
            echo " Erreur lors de la saisie" && sleep 2
            instaler_vagrant_virtual
        fi
    fi
    read -p " Tout est bon, on continue (appuie sur une touche pour continuer) ?"
    vagrant_manager
}

vagrant_manager() {
    clear
    echo "-----------------------------------------------------"
    echo -e "\e[39m \e[31m      Bienvenue dans le manager de box vagrant    \e[39m   "
    echo "-----------------------------------------------------"
    echo " "
    echo " 1- Afficher toute les box active"
    echo " 2- Créer une nouvelle box"
    echo " 3- Eteindre une box"
    echo " 4- Allumer une box"
    echo " 5- Supprimer une box"
    echo " 6- Exit"
    read -p " Votre choix ? (1, 2, 3, 4) : " manage_choice
    case $manage_choice in
        1)
            clear
            echo "Ci-dessous les box active :"
            echo " "
            echo "id       name    provider   state   directory "
            vagrant global-status | grep running
            echo " "
            read -p "Appuie sur une touche pour continuer"
            vagrant_manager
        ;;
        2)
            main
        ;;
        3)
            clear
            echo "Ci-dessous les box active :"
            echo " "
            echo "id       name    provider   state   directory "
            vagrant global-status | grep running
            echo " "
            
            read -p "quelle est l'id de la box a eteidre : " id_halt
            if [[ $id_halt == "" ]]
            then
                id_halt="000000"
            fi
            if [[ $(vagrant global-status | grep -o -i $id_halt) == $id_halt ]]
            then
                vagrant halt $id_halt -f && read -p "J'ai arreter la box id : $id_halt"
                vagrant_manager
            else
                read -p "Erreur lors de la saisie de l'id"
                vagrant_manager
            fi
        ;;
        4)
            clear
            echo "Ci-dessous les box non active :"
            echo " "
            echo "id       name    provider   state   directory "
            vagrant global-status | grep poweroff
            echo " "
            read -p "quelle est l'id de la box a allumer : " id_up
            if [[ $id_up == "" ]]
            then
                id_up="000000"
            fi
            if [[ $(vagrant global-status | grep -o -i $id_up) == $id_up ]]
            then
                vagrant up $id_up
                read -p "J'ai allumer la la box id : $id_up"
                vagrant_manager
            else
                read -p "Erreur lors de la saisie de l'id"
                vagrant_manager
            fi
        ;;
        5)
            clear
            echo "Ci-dessous les box :"
            echo " "
            echo "id       name    provider   state   directory "
            vagrant global-status | grep virtualbox
            echo " "
            read -p "quelle est l'id de la box a supprimer : " id_suppr
            if [[ $id_suppr == "" ]]
            then
                id_suppr="000000"
            fi
            if [[ $(vagrant global-status | grep -o -i $id_suppr) == $id_suppr ]]
            then
                vagrant destroy $id_suppr -f
                read -p "J'ai supprimé la la box id : $id_suppr"
                vagrant_manager
            else
                read -p "Erreur lors de la saisie de l'id"
                vagrant_manager
            fi
        ;;
        6)
            exit
        ;;
        *)
            read -p "Erreur lors de la saisie de l'id"
            vagrant_manager
        ;;
        
    esac
    
}

#------main------#
instaler_vagrant_virtual