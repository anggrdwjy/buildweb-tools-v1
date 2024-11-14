#!/bin/bash
#################################################################
# Author        : Anggarda Saputra Wijaya                       #
# Email         : aw0x0410@gmail.com                            #
# Github        : https://github.com/anggrdwjy.                 #
#################################################################
again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]];
do
clear
echo " ####################################################";
echo " ##                                                ##";
echo " ##      █▄▄ █░█ █ █░░ █▀▄     █░█░█ █▀▀ █▄▄       ##";
echo " ##      █▄█ █▄█ █ █▄▄ █▄▀     ▀▄▀▄▀ ██▄ █▄█       ##";
echo " ##                                                ##";
echo " ##      ▀█▀ █▀█ █▀█ █░░ █▀                        ##";
echo " ##      ░█░ █▄█ █▄█ █▄▄ ▄█      by anggrdwjy      ##";
echo " ##                                                ##";
echo " ##      Developer : github.com/anggrdwjy          ##";
echo " ##      Version 1.0.0 | 14/11/2024                ##";
echo " ##                                                ##";
echo " ####################################################";
echo " ##                                                ##";
echo " ##      List Menu :                               ##";
echo " ##      [1] Install Apache2                       ##";
echo " ##      [2] Install PHP                           ##";
echo " ##      [3] Install PHPMyAdmin                    ##";
echo " ##      [4] Install MySQL                         ##";
echo " ##      [5] Install Virtual Host                  ##";
echo " ##      [6] Check Log Web Server                  ##";
echo " ##      [7] Bandwidth Monitoring Server           ##";
echo " ##      [8] Monitoring CPU and Memory             ##";
echo " ##      [9] Reboot Server                         ##";
echo " ##      [10] Exit                                 ##";
echo " ##                                                ##";
echo " ####################################################";
echo "                                                 ";
read -p " Select List : " choice;
echo "                                                 ";
case $choice in

1) read -p "Install Apache2 Now? y/n :" -n 1 -r
   echo  ""
   echo "                                             ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   sudo apt-get update
   sudo apt-get install apache2 -y
   sudo systemctl restart apache2
   fi
   ;;

2) read -p "Install PHP? y/n :" -n 1 -r
   echo  ""
   echo "                                             ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   sudo apt-get update
   sudo apt-get install php
   sudo cp asset/phpinfo.php /var/www/html
   echo " |===========================================|";
   echo " | Check PHP : http://your-ip/phpinfo.php    |";
   echo " |===========================================|";
   fi
   ;;

3) read -p "Install PHPMyAdmin? y/n :" -n 1 -r
   echo  ""
   echo "                                             ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   sudo apt-get install phpmyadmin
   echo " |===========================================|";
   echo " | Check PHP : http://your-ip/phpmyadmin     |";
   echo " |===========================================|";
   fi
   ;;
   
4) read -p "Install MySQL? y/n :" -n 1 -r
   echo  ""
   echo "                                             ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   sudo apt-get update
   sudo apt install mysql-server
   echo -n "Password Root Your Database: ";
   read passmysql
   sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$passmysql';" 
   sudo clear
   service apache2 restart
   fi
   ;;

5) echo -n "Input Your Domain : "
   read domain
   if [ -z "$(ls -A /home/$domain/*)" ]; then
   echo "Install Virtual Host With Domain"
   sudo useradd -m $domain
   sudo passwd $domain
   sudo mkdir -p /home/$domain/public_html
   sudo chown -r $domain.$domain /home/$domain/public_html
   sudo chmod -R 755 /home/$domain
   echo "Web Server Work !!!" >> /home/$domain/public_html/index.html
   sudo chmod 755 /home/$domain/public_html/index.html
   sudo chown $domain.$domain /home/$domain/public/index.html
   sudo cp asset/apache2.conf /etc/apache2/
   sudo cp asset/domain.conf /etc/apache2/sites-available/$domain.conf
   sudo nano /etc/apache2/sites-available/$domain.conf
   sudo a2ensite $domain.conf
   sudo service apache2 reload
   else
   echo "Your Domain Available"
   fi
   ;;

6) read -p "Check Log Web Server? y/n :" -n 1 -r
   echo  ""
   echo "                                             ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   sudo cat /var/log/apache2/access.log
   fi
   ;;
    
7) read -p "Install Bandwidth Monitoring? y/n :" -n 1 -r
   echo  ""
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   sudo apt install iptraf-ng
   fi
   read -p "Check Bandwidth Monitoring? y/n :" -n 1 -r
   echo  ""
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   iptraf-ng
   fi
   ;;
   
8) read -p "Install Monitoring CPU and RAM? y/n :" -n 1 -r
   echo  ""
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   sudo apt install htop
   fi
   read -p "Show Monitoring CPU and RAM? y/n :" -n 1 -r
   echo  ""
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   sudo htop
   fi
   ;;

9) read -p "Reboot Your Server? y/n :" -n 1 -r
   echo  ""
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   reboot
   fi
   ;;
   
10) exit
   ;;

*)    echo "Sorry, Your Choice Not Available"
esac
echo "                                                  ";
echo -n "Back to Menu? [y/n]: ";
echo "                                                  ";
read again;
while [[ $again != 'Y' ]] && [[ $again != 'y' ]] && [[ $again != 'N' ]] && [[ $again != 'n' ]];
do
echo " Variable Not Available in Menu ";
echo "                                                  ";
echo -n "Back to Menu? [y/n]: ";
echo "                                                  ";
read again;
done
done 
