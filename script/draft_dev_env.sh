#!/usr/bin/env bash

set -e

#gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
#echo "FINISHED installing keys"
#
#sudo yum -y localinstall http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
#echo "FINISHED installing pgdg-centos rpm"
#
#wget http://mirror.sfo12.us.leaseweb.net/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
#echo "FINISHED epel rpm fetch"
#
#sudo rpm -Uvh epel-release-7-5.noarch.rpm
#echo "FINISHED epel rpm install"

sudo yum -y install postgresql94 postgresql94-server postgresql94-contrib postgresql94-libs postgresql94-devel qtwebkit-devel nano
echo "FINISHED installing packages"

sudo /usr/pgsql-9.4/bin/postgresql94-setup initdb
echo "FINISHED postgres initdb"

sudo chkconfig postgresql-9.4 on
echo "FINISHED postgres service enable"

sudo service postgresql-9.4 start
echo "FINISHED postgres service start"

sudo ln -s /usr/pgsql-9.4/bin/p* /usr/local/bin
echo "FINISHED postgres symlinking binaries"

sudo -i -u postgres -H sh -c "createuser -s vagrant"
echo "FINISHED postgres create vagrant user"

sudo ln -s /usr/lib64/qt4/bin/qmake /usr/bin/qmake # or some other method to get qmake in your path like `export QMAKE`
echo "FINISHED qt install"

if [ -d "/usr/local/rvm/rubies"  ]; then
  echo "vagrant_provision: rvm and ruby already installed"
else
  echo "vagrant_provision: installing rvm"
  sudo -i -u vagrant -H sh -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"

  sudo -i -u vagrant -H sh -c "\curl -sSL https://get.rvm.io | bash -s stable --ruby"

  sudo -i -u vagrant -H sh -c "gem install bundler"
fi

#bundle exec rake db:create
#bundle exec rake db:migrate