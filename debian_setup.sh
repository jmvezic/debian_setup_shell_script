read -sp "Enter the password you wish to have as MySQL root user: " mysqlpass
sudo apt-get update
sudo apt-get --assume-yes upgrade
sudo apt-get -y install apache2
export DEBIAN_FRONTEND="noninteractive"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $mysqlpass"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $mysqlpass"
sudo apt-get install -y mysql-server
mysql_secure_installation <<EOF
$mysqlpass
n
Y
Y
Y
Y
EOF
sudo apt-get -y install php5 php-pear php5-mysql
sudo service apache2 restart
sudo echo "<?php phpinfo(); ?>" > /var/www/html/info.php
sudo apt-get -y install htop tmux
sudo fallocate -l 1G /swapfile
ls -lh /swapfile
sudo chmod 600 /swapfile
ls -lh /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo sysctl vm.swappiness=10
sudo echo "\n" > /etc/sysctl.conf
sudo echo "vm.swappiness=10" > /etc/sysctl.conf
sudo sysctl vm.vfs_cache_pressure=50
sudo echo "\n" > /etc/sysctl.conf
sudo echo "vm.vfs_cache_pressure=50" > /etc/sysctl.conf
sudo apt-get install -y vsftpd
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.original
sudo replace "#write_enable=YES" "write_enable=YES" -- /etc/vsftpd.conf
sudo /etc/init.d/vsftpd restart
