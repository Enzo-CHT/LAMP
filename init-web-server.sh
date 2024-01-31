#!/bin/bash

## Programme d'installation basique de package LAMP
## Installation de PhpMyAdmin
##



red='\e[0;31m'
green='\e[0;32m'
white='\e[0;38m'
## INSTALLATION APACHE2


echo -e "${red}Installation Apache2";
sudo apt-get update -y ;
sudo apt-get install -y apache2 ;
sudo systemctl enable apache2 ; 


echo -e "${red}Installation Apache2 ${green}[ OK ]${white}";
sudo apache2ctl -v;


## CONFIGURATION APACHE 2
echo "${white}Configuration modules Apache2";
sudo systemctl restart apache2;
sudo a2enmod rewrite ;
sudo a2enmod deflate ;
sudo a2enmod headers ;
sudo a2enmod ssl ;
sudo systemctl restart apache2;
sudo apt-get install -y apache2-utils ;
echo "Configuration modules Apache2 ${green}[ OK ]${white}";


## INSTALLATION PHP


echo -e "${red}Installation PHP${white}";

sudo apt-get install -y php ;
sudo apt-get install -y php-pdo php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath  ;

sudo touch /var/www/html/phpinfo.php;
sudo echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php;
php -v;



echo -e "${red}Installation PHP ${green}[ OK ]${white}";


echo -e "${red}Création du fichier phpinfo.php ${green}[ OK ]${white}";

## INSTALLATION MARIADB


echo -e "${red}Installation MariaDB${white}";
sudo apt-get install -y mariadb-server ;


echo -e "${red}Installation MariaDB ${green}[ OK ]${white}${white}";



echo -e "${red}Configuration MariaDB${white}";
sudo mariadb-secure-installation;
sudo systemctl restart mariadb ;
sudo echo "lower_case_table_names = 1" >> /etc/mysql/my.cnf;
sudo service mariadb restart;
echo "Configuration MariaDB ${green}[ OK ]${white}";
mariadb -V;


##INSTALLATION phpMyAdmin


echo -e "${red}Installation phpMyAdmin${white}";


sudo apt install wget -y ;
sudo systemctl status apache2;
sudo apt -y install php php-cgi php-mysqli php-pear php-mbstring libapache2-mod-php php-common php-phpseclib php-mysql ;

sudo wget -P /tmp/Downloads https://www.phpMyAdmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz;


echo -e "${red}Installation phpMyAdmin ${green}[ OK ]${white}${white}";



echo -e "${red}Check GPG Key${white}";
sudo wget -P /tmp/Downloads https://files.phpMyAdmin.net/phpMyAdmin.keyring
cd /tmp/Downloads;



echo -e "${red}Importation clé GPG${white}";
sudo gpg --import phpMyAdmin.keyring ;
sudo wget https://www.phpMyAdmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz.asc ;
sudo gpg --verify phpMyAdmin-latest-all-languages.tar.gz.asc;



echo -e "${red}Configuration phpMyAdmin${white}";
sudo mkdir /var/www/html/phpMyAdmin;
sudo tar xvf phpMyAdmin-latest-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpMyAdmin ;
sudo cp /var/www/html/phpMyAdmin/config.sample.inc.php /var/www/html/phpMyAdmin/config.inc.php ;


# Entrer blowfish secret 
# CHANGER LE BLOWFISH-SECRET
sudo echo """
<?php
declare(strict_types=1);
$cfg['blowfish_secret'] = 'this_Is_My_SecretPassphrase'; 

$i = 0;
$i++;

$cfg['Servers'][$i]['auth_type'] = 'cookie';

$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = false;

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';
""" > /var/www/html/phpMyAdmin/config.inc.php;


sudo chmod 660 /var/www/html/phpMyAdmin/config.inc.php;

sudo chown -R www-data:www-data /var/www/html/phpMyAdmin;
sudo systemctl restart apache2;



echo -e "${red}Configuration phpMyAdmin ${green}[ OK ]${white}${white}";
