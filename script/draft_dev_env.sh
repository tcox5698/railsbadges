#!/usr/bin/env bash


gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

sudo yum localinstall http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm

sudo yum install postgresql94 postgresql93-server postgresql94-contrib postgresql94-libs postgresql94-devel

sudo yum install nano

sudo /usr/pgsql-9.4/bin/postgresql94-setup initdb

sudo chkconfig postgresql-9.4 on

sudo service postgresql-9.4 start

sudo su - postgres

    createuser -s vagrant
    exit

sudo ln -s /usr/pgsql-9.4/bin/p* /usr/local/bin

wget http://mirror.sfo12.us.leaseweb.net/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
sudo rpm -Uvh epel-release-7-5.noarch.rpm

sudo yum install qtwebkit-devel # will work with the dash in between qt and webkit, but not if you are using chef
sudo ln -s /usr/lib64/qt4/bin/qmake /usr/bin/qmake # or some other method to get qmake in your path like `export QMAKE`

bundle exec rake db:create
bundle exec rake db:migrate