How deploy local environment
============================

Install
=======

- Install **[Vagrant](https://www.vagrantup.com/)**
- Install **[VirtualBox](https://www.virtualbox.org/)**

> ### If you are using Ubuntu 16.04
In Ubuntu 16.04, there is an error when you installing landrush plugin. To fix it you should apply patch for vagrant.
~~~bash
sudo patch --directory /usr/lib/ruby/vendor_ruby/vagrant < vagrant-plugin.patch
~~~
The fix should be released in Vagrant 1.8.2

- Install **[Landrush](https://github.com/vagrant-landrush/landrush)** vagrant plugin

~~~bash
vagrant plugin install landrush
~~~
> ### Only for Ubuntu
Install resolvconf and dnsmasq
~~~bash
sudo apt-get install -y resolvconf dnsmasq
sudo sh -c 'echo "server=/sharebird.dev/127.0.0.1#10053" > /etc/dnsmasq.d/vagrant-landrush'
sudo service dnsmasq restart
~~~

- Clone the repository with project, better to do it into vagrant folder, because this is the default path in Vagrantfile<br><br>

Up Vagrant box
~~~bash
vagrant up
~~~

>During the first "Vagrant up” -  Vagrant will install all the necessary packages (Nginx, Postgress, NodeJs, rbenv, ruby etc.), cope the configuration files and ssl-certificates. Also there might me some errors during this process - don’t take them into account (I’m working on them).

- When the installation is finished, run the box

~~~bash
vagrant ssh
~~~
- Move to the folder with project

~~~bash
cd /vagrant_data/sharebird
~~~
~~~bash
bundle install
rake db:create
rake db:migrate
puma -e development -b tcp://0.0.0.0:3000
~~~
