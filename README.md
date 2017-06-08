# README

## HOW TO BOOTSTRAP

### Staging using a Vagrant VM

- install vagrant
- bring up the machine (`vagrant up`)
- login to the machine (`vagrant ssh`)

### On Staging or Production

- install python (`sudo apt-get install python -y -q`)
- install ssh (`sudo apt-get install ssh -y -q`)
- create a deploy user (`sudo adduser deploy`)
- add user to admin group (`sudo addgroup deploy admin`)
- setup DNS (using `/etc/hosts` or your dns registrar)
- setup SSH key for deploy user

