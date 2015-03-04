git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# next line stops script execution
# exec $SHELL -l 

source ~/.bash_profile

CONFIGURE_OPTS="--disable-install-rdoc" ~/.rbenv/bin/rbenv install 2.2.0

rbenv global 2.2.0
#~/.rbenv/bin/rbenv rehash
rbenv rehash

#~/.rbenv/shims/gem install rails passenger -N
gem install rails passenger -N
#~/.rbenv/bin/rbenv rehash
rbenv rehash

echo 'install passenger module...(log: passenger.log)'
#~/.rbenv/shims/passenger-install-apache2-module --auto --languages ruby >> passenger.log 2>&1
passenger-install-apache2-module --auto --languages ruby >> passenger.log 2>&1
#~/.rbenv/shims/passenger-install-apache2-module --snippet > passenger.conf
passenger-install-apache2-module --snippet > passenger.conf

git init --bare repo.git

