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
echo "                                                             ";
echo "                                                             ";
echo "       █▄▄ █░█ █ █░░ █▀▄     █░█░█ █▀▀ █▄▄     ▀█▀ █▀█ █▀█ █░░ █▀     █▀ █▀▀ ▀█▀ █░█ █▀█  ";
echo "       █▄█ █▄█ █ █▄▄ █▄▀     ▀▄▀▄▀ ██▄ █▄█     ░█░ █▄█ █▄█ █▄▄ ▄█     ▄█ ██▄ ░█░ █▄█ █▀▀  ";
echo "                                                             ";
echo "       Developer : github.com/anggrdwjy                      ";
echo "       Version 1.0.0 | 14/11/2024                            ";
echo "                                                             ";
echo " |==========================================================|";
echo " |                                                          |";
echo " |     List Menu :                                          |";
echo " |     [1] Install Apache2                                  |";
echo " |     [2] Check Log Web Server                             |";
echo " |     [3] Install PHP                                      |";
echo " |     [4] Install MySQL                                    |";
echo " |     [5] Exit                                             |";
echo " |                                                          |";
echo " ============================================================";
read -p " Select List : " choice;
echo "                                                            ";
case $choice in

1) read -p "Install Apache2 Now? y/n :" -n 1 -r
   echo ""
   echo " ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   sudo apt-get update
   sudo apt-get install apache2
   read -p "Restart Apache2 Now? y/n :" -n 1 -r
   echo  ""
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   sudo systemctl restart apache2
   fi
   ;;

2) read -p "Check Log Web Server? y/n :" -n 1 -r
   echo ""
   echo " ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   sudo cat /var/log/apache2/access.log
   read -p "Monitoring Log Web Server? y/n :" -n 1 -r
   echo ""
   echo " ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   sudo tail -f /var/log/apache2/access.log
   fi
   ;;

3) read -p "Install PHP? y/n :" -n 1 -r
   echo ""
   echo " ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   sudo apt-get update
   sudo apt-get install software-properties-common
   sudo add-apt-repository ppa:onderj/php
   sudo apt-get update
   sudo apt-get install php
   sudo cp asset/phpinfo.php /var/www/html
   echo "                                                  ";
   echo " Check PHP : http://your-ip/phpinfo.php           ";
   echo "                                                  ";
   fi
   ;;

4) read -p "Install MySQL? y/n :" -n 1 -r
   echo ""
   echo " ";
   if [[ ! $REPLY =~ ^[Nn]$ ]]
   then
   sudo apt-get update
   sudo apt install mysql-server
   echo -n "Password Root Your Database : ";
   read passmysql
   sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$passmysql';" 
   sudo clear
   service apache2 restart
   fi
   ;;

5) exit
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
