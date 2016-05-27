# How deploy local environment

## MAC OSX
- Install **[Vagrant](https://www.vagrantup.com/)** <br>
- Install **[Landrush](https://github.com/vagrant-landrush/landrush)** vagrant plugin<br>
`$ vagrant plugin install landrush`
- Copy **sharebird** config file from `NGINX` directory to `/etc/nginx/sites-available`
- Create symlink <br>
`$ ln -n /ect/nginx/sites-available/sharebird /etc/nginx/sites-enabled`
- Copy ssl certificates from `ssl` directory to `/etc/nginx/ssl/sharebird`
