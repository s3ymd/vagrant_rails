apt-get -y update
apt-get -y autoremove
apt-get -y remove --purge nano rpcbind ruby
apt-get -y install git unzip
apt-get -y install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
apt-get -y install libsqlite3-dev nodejs apache2
apt-get -y install libcurl4-openssl-dev apache2-threaded-dev libapr1-dev libaprutil1-dev
apt-get -y install postgresql-9.3
apt-get -y upgrade

# for passenger-install-apache2-module
dd if=/dev/zero of=/swap bs=1M count=1024; mkswap /swap; swapon /swap

if grep rails /etc/passwd; then
  deluser --remove-home rails
fi
adduser --disabled-password --gecos "" rails
usermod -a -G sudo rails
su -l rails -c '/bin/bash /vagrant/setup-ruby.sh'
su -l rails -c '/bin/bash /vagrant/setup-rails.sh'
cp ~rails/passenger.conf /etc/apache2/conf-available/
sed -e s/XXXXXXXX/`cat ~rails/secret`/ /vagrant/rails-site.conf > /etc/apache2/sites-available/rails-site.conf
rm ~rails/secret
a2enconf passenger
a2dissite 000-default
a2ensite rails-site
service apache2 restart

sudo -u postgres createuser rails
sudo -u postgres createdb -O rails app_production


reboot
