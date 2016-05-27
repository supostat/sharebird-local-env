#!/usr/bin/env bash

echo "### Updating system ###"
sudo apt-get update && sudo apt-get upgrade -y > /dev/null

echo "### INSTALL NGINX ###"

sudo apt-get install nginx -y > /dev/null
sudo rm -f /etc/nginx/sites-available/default && sudo rm -f /etc/nginx/sites-enabled/default > /dev/null

echo "### CREATE SSL DIRECTORIES ###"
sudo mkdir /etc/nginx/ssl && sudo mkdir /etc/nginx/ssl/sharebird > /dev/null

echo "### Copy ssl sertificates ###"
sudo cp -r /tmp/ssl/. /etc/nginx/ssl/sharebird/ > /dev/null

echo "### Copy sharebird NGINX config file ###"
sudo cp /tmp/nginx/sharebird /etc/nginx/sites-available > /dev/null
sudo ln -n /etc/nginx/sites-available/sharebird /etc/nginx/sites-enabled > /dev/null

sudo service nginx restart > /dev/null

echo '### Install postgresql 9.5 ###'
sudo apt-get install libpq-dev -y > /dev/null

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list' > /dev/null
sudo wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add - > /dev/null

sudo apt-get -y update > /dev/null
sudo apt-get -y install postgresql postgresql-contrib > /dev/null

psql --version

# fix access type
echo "### Fixing postgres pg_hba.conf file ###"
# replace the ipv4 host line with the above line
sudo cat >> /etc/postgresql/9.5/main/pg_hba.conf <<EOF
host    all         all         0.0.0.0/0             md5
EOF

echo '### Create superuser developer ###'
sudo su postgres -c "psql -c \"CREATE USER developer WITH PASSWORD 'developer' CREATEDB CREATEUSER CREATEROLE;\" "

echo '### Modify base encoding for new databases ###'
sudo su postgres -c "psql -c \"update pg_database set datistemplate=false where datname='template1';\" "
sudo su postgres -c "psql -c \"drop database template1;\" "
sudo su postgres -c "psql -c \"create database template1 with owner=postgres encoding='UTF-8' lc_collate='en_US.utf8' lc_ctype='en_US.utf8' template template0;\" "
sudo su postgres -c "psql -c \"update pg_database set datistemplate=true where datname='template1';\""

echo '### Install rbenv ###'

sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev > /dev/null

cd $HOME && git clone git://github.com/sstephenson/rbenv.git .rbenv

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build > /dev/null
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile

echo '### Download and install ruby 2.3.1 build ###'
rbenv install -v 2.3.1 > /dev/null
rbenv global 2.3.1 > /dev/null

echo '### Install bundler gem ###'
gem install bundler > /dev/null

echo "### Install NodeJs ###"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs > /dev/null
echo "### Install NodeJs essential ###"
sudo apt-get install -y build-essential > /dev/null

echo '### Done !!! ###'
