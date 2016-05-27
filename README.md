# How deploy local environment

## MAC OSX
- Install **[Vagrant](https://www.vagrantup.com/)** <br>
- Install **[Landrush](https://github.com/vagrant-landrush/landrush)** vagrant plugin<br>
`$ vagrant plugin install landrush`
- Place ssl certificates into ssl folder
- Склонируйте репозиторий с проектом, желательно в папку с vagrant, так-как этот путь прописан по умолччанию в Vagrantfile
- Start Vagrant box `vagrant up` <br>
В процессе первого старта Vagrant установит все необходимые пакеты (Nginx, Postgress, NodeJs, rbenv, ruby etc.) и скопирует файлы конфигурации и ssl сертификаты, так-же в процессе установки могут вылетать некоторые ошибки, все нормально, не обращайте внимания, я еще работаю на этим.
- После того, как установка закончится войдите в бокс `vagrant ssh`
- Перейдите в папку с проектом `$ cd /vagrant_data/sharebird`
- `$ bundle install`
- `$ rake db:create`
- `$ rake db:migrate`
- `$ puma -e development`
