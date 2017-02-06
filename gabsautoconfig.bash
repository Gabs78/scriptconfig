#!/bin/bash

if [[ $EUID > 0 ]]

then

echo

echo -e '\033[31mPlease run as root/sudo\033[0m'

echo

exit 1

else

clear

#=============================================================================
# Install Packages
#=============================================================================

echo -e '\033[31m#============================================================================='

echo -e '# Gabs Configuration Script'

echo -e '#=============================================================================\033[0m'

echo

list="wget vim subversion zsh git linuxlogo sudo terminator"

list2="apache2 php5 libapache2-mod-php5 php5-mcrypt mysql-server php5-mysql phpmyadmin"

echo -e '\033[36m-----Update Packages List-----\033[0m'

echo

apt-get update

echo

echo -e '\033[36m-----Install Wget, SVN, ZSH, GIT, Linuxlogo, Sudo \& Terminator-----\033[0m'

echo 

apt-get -y install $list

echo

echo -e '\033[36m-----Install Web Server-----\033[0m'

echo

debconf-set-selections <<< 'mysql-server mysql-server/root_password password 123'

debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 123'

debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'

debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password 123'

debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password 123'

debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password 123'

debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'

apt-get -y install $list2

echo

echo -e '\033[36m-----Update Packages-----\033[0m'

echo

apt-get -y dist-upgrade

#=============================================================================
# Add the Correct MOTD
#=============================================================================

echo

rm /etc/linux_logo.conf

echo '# /etc/linux_logo.conf
#
# This conf file controls linux_logo. Place your command-line options
# for linux_logo on the first line of this file. Users may use a
# ~/.linux_logo file which will over-ride this file.
#
# The following logos are compiled in to the Debian version of linux_logo:
#
#        Num     Type    Ascii   Name            Description
#        1       Classic Yes     aix             AIX Logo
#        2       Classic Yes     bsd             FreeBSD Logo
#        3       Banner  Yes     bsd_banner      FreeBSD Logo
#        4       Classic Yes     irix            Irix Logo
#        5       Banner  Yes     solaris         The Default Banner Logos
#        6       Banner  Yes     banner-simp     Simplified Banner Logo
#        7       Banner  Yes     banner          The Default Banner Logo
#        8       Classic Yes     classic-nodots  The Classic Logo, No Periods
#        9       Classic Yes     classic-simp    Classic No Dots Or Letters
#        10      Classic Yes     classic         The Default Classic Logo
#        11      Classic Yes     core            Core Linux Logo
#        12      Banner  Yes     debian_banner_2 Debian Banner 2
#        13      Banner  Yes     debian_banner   Debian Banner (white)
#        14      Classic Yes     debian_old      Debian Old Penguin Logos
#        15      Classic Yes     debian          Debian Swirl Logos
#        16      Classic Yes     gnu_linux       Classic GNU/Linux
#        17      Banner  Yes     mandrake_banner Mandrake(TM) Linux Banner
#        18      Banner  Yes     mandrake        Mandrakelinux(TM) Banner
#        19      Banner  Yes     mandriva        Mandriva(TM) Linux Banner
#        20      Banner  Yes     pld             PLD Linux banner
#        21      Banner  Yes     redhat          RedHat Banner (white)
#        22      Banner  Yes     slackware       Slackware Logo
#        23      Banner  Yes     sme             SME Server Banner Logo
#        24      Banner  Yes     sourcemage_ban  Source Mage GNU/Linux banner
#        25      Banner  Yes     sourcemage      Source Mage GNU/Linux large
#        26      Banner  Yes     suse            SUSE Logo
#        27      Banner  Yes     ubuntu          Ubuntu Logo
#
# See the man page or the output of linux_logo -h for a complete
# list a command-line options.

-L 16' > /etc/linux_logo.conf
linux_logo > /etc/motd

#=============================================================================
# User Name                                                                   
#=============================================================================
                                                                              
echo -e '\033[36m-----User Name-----\033[0m'                                  
                                                                              
echo                                                                          
                                                                              
echo "Please enter your user name:"
                                         
echo

echo -n '--> '                                                                          
                                                                              
read account

check=$(grep -c "^$account:" /etc/passwd)

while [[ $check != 1 ]]
do
echo
echo "User <'$account'> doesn't exists!"
echo
echo -n '--> '
read account
echo
check=$(grep -c "^$account:" /etc/passwd)
done

echo

echo "User <'$account'> successfuly found!"

echo

#=============================================================================
# Configure the Prompt
#=============================================================================

prompt='export PS1="\[\033[38;5;45m\][\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;9m\]\@\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;45m\]]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;45m\][\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;28m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;10m\]\H\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;87m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;45m\]]\[$(tput sgr0)\]\[\033[38;5;15m\]\n--> \[$(tput sgr0)\]"'

prompt2='PS1="\[\033[38;5;45m\][\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;9m\]\@\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;45m\]]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;45m\][\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;1m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;10m\]\H\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;87m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;45m\]]\[$(tput sgr0)\]\[\033[38;5;15m\]\n--> \[$(tput sgr0)\]"'

echo $prompt >> /home/$account/.bashrc

echo $prompt2 >> /root/.bashrc

echo '# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi' >> /etc/bash.bashrc

#=============================================================================
# Configure Sudo
#=============================================================================

echo -e '\033[36m-----Activate Sudo for user <'$account'>-----\033[0m'

echo

adduser $account sudo

echo

#=============================================================================
# Configure VIM
#=============================================================================

touch /home/$account/.vimrc

chown $account:$account /home/$account/.vimrc

touch /root/.vimrc

echo 'syntax on
colorscheme elflord' > /home/$account/.vimrc

echo 'syntax on
colorscheme elflord' > /root/.vimrc

#=============================================================================
# Alias Bash
#=============================================================================

alias="#Alias

alias install='sudo apt-get install'

alias update='sudo apt-get update'

alias la='ls -la'

alias su='sudo su'

alias osmc='ssh osmc@osmc.gabs-serv.fr'

alias sudo='sudo '

alias serv='cd /var/www/html/'

alias apache-restart='sudo /etc/init.d/apache2 restart'

alias dev1='php /var/www/html/Symfony_Blog/bin/console cache:clear --env=dev'

alias prod1='php /var/www/html/Symfony_Blog/bin/console cache:clear --env=prod'

alias cache='sudo chmod -R 777 /var/www/html/Symfony_Blog/var/'

alias prod='cache && prod1 && cache'

alias dev='cache && dev1 && cache'

alias css='sudo rm -rf web/bundles web/images web/css && php bin/console assets:install web && php bin/console assetic:dump web'

alias sql='mysql -u root -p'

alias dist-upgrade='sudo apt-get dist-upgrade'"

echo $alias >> /root/.bashrc

echo $alias >> /home/$account/.bashrc 

#=============================================================================
# Configure Phpmyadmin
#=============================================================================

echo 'Include /etc/phpmyadmin/apache.conf' >> /etc/apache2/apache.conf

echo

echo -e '\033[36m-----Restart Apache Server-----\033[0m'

echo

/etc/init.d/apache2 restart

echo

#=============================================================================
# Script End
#=============================================================================

echo -e '\033[36m-----Done-----\033[0m'

zsh

fi