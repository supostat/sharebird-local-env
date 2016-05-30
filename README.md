How deploy local environment
============================

Install
=======

- Install **[Vagrant](https://www.vagrantup.com/)**

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

- Склонируйте репозиторий с проектом, желательно в папку с vagrant, так-как этот путь прописан по умолччанию в Vagrantfile<br><br>
Up Vagrant box
~~~bash
vagrant up
~~~

>В процессе первого старта Vagrant установит все необходимые пакеты (Nginx, Postgress, NodeJs, rbenv, ruby etc.) и скопирует файлы конфигурации и ssl сертификаты, так-же в процессе установки могут вылетать некоторые ошибки, все нормально, не обращайте внимания, я еще работаю на этим.

- После того, как установка закончится войдите в бокс
~~~bash
vagrant ssh
~~~
- Перейдите в папку с проектом
~~~bash
cd /vagrant_data/sharebird
~~~
~~~bash
bundle install
rake db:create
rake db:migrate
puma -e development -b tcp://0.0.0.0:3000
~~~
