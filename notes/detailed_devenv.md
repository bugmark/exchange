# Bugmark DevEnv

This covers the config and install of software components for Bugmark development.

NOTE: you don't need the full development environment to contribute documentation fixes! Just clone the tracker, edit text files and submit PR's.
## Required Skills

To be successful, you'll need good skills with the following tools:

- git
- Linux command line
- Web development
- PostgresQL
- ruby/rails
- vim, Emacs or some command-line editor
- tmux (nice to have)

## Host Machine

We assume that you're using Ubuntu 16.04 as your host machine. If you're Mac savvy, you'll be able to get things running on a Mac.

Your host machine can exist in a few different forms:
1) a destop Ubuntu system
2) a Virtual Machine running locally (using Vagrant)
3) a Virtual Machine running in the data center

Of the three options, the best and simplest is 3), running in the data center.
We like Linode - you can allocate a cheap node for development that will cost
$5/month.

WARNING: if you choose to install on a local system (option 1), this
configuration process will install many packages and will make changes to your
user configuration, including:
- adding items to your `.bashrc`, modifying your path
- adding your UserID to `sudoers`

In this case, it is ususally best to use a dedicated user-id.

## Development VM Configuration

Follow these steps to set up a working development environment running on an Ubuntu Virtual machine.

Let's get started:

1. Install VirtualBox and Vagrant on your host machine (Linux, Win, Mac OK)

2. Download the dev-machine Vagrantfile 
   `wget raw.githubusercontent.com/bugmark/exchange/master/Vagrantfile`

3. Run `vagrant up` to create a virtual machine.

4. Login to your virtual machine using `vagrant ssh`

## Cloning the Bugmark Exchange

Clone the tracker `mkdir src; cd src; git clone https://github.com/bugmark/exchange.git`

`cd` to the tracker directory `cd exchange`

Install the following, with the recommended versions:
1. ruby 2.5
2. gem 2.7
3. rails 5.1.4
4. ansible 2.3.2.0 (or higher, this is important.)
5. postgresql:

Install postgresql with:
   
```sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-common
sudo apt-get install postgresql-9.5 libpq-dev
```

Start postgres console and create a user postgres with the password postgres:

```sudo -u postgres psql
postgres=# CREATE USER postgres WITH PASSWORD 'postgres'; 
postgres=# ALTER USER postgres CREATEDB;
postgres=# \q
```

6. nodejs 8.11 and yarn 1.6.0:

First, configure the repo using:

```curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
```

Configure the node source repo with:
`curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -`

Install node.js 8.11.1 and native build tools:
```sudo apt-get install -y nodejs
sudo apt-get install -y build-essential
```
        
Install yarn
`sudo apt-get update && sudo apt-get install yarn`

7. install ssh: `sudo apt-get install openssh-server` 
8. tmux

## Development Environment Provisioning

On the host machine:

1.Checkout the dev branch `git checkout -b dev origin/dev`

2.Install ansible `script/dev/provision/install_ansible`
    Troubleshooting: Check the ansible version with `ansible --version`. It should be 2.3.2.0 or higher.

3. Install ansible roles `script/dev/provision/install_roles`

4. Install extra npm packages:

`sudo npm install -g coffescript`

`sudo npm install fkill`

    
5. Provision the dev machine: `script/dev/provision/localhost`
    
     Troubleshooting:
    
     - If you see the error `fatal: [localhost]: FAILED! => {"changed": false, "msg": "Destination /etc/ssh/sshd_config" does not exist !", "rc": 257}`
  
       It's probably because your ssh isn't properly configured.
       Install ssh with `sudo apt-get install openssh-server` and open config file with `nano /etc/ssh/sshd_config`

     - If you see the error `fatal: [localhost]: FAILED! => {"changed": false, "failed": true,"msg": "Unsupported parameter for module: path"}`
       It's probably because your ansible version isn't compatible, try upgrading your ansible version with:

       Check the version:
       `ansible --version`

       To upgrade your ansible version:
       `sudo -H pip install --upgrade ansible`

       If this doesn't work, try removing all the previous versions and installing again with PPA:
     
       ```sudo apt-get remove ansible
       compgen -c | grep ansible (should not return anything)
       sudo apt-add-repository ppa:ansible/ansible
       sudo apt-get update
       sudo apt-get install ansible
       ```


6. Check database status, and see the active sessions with: `systemctl status postgresql`

7. Start a new shell: `bash` (required to load your new user configuration)

## Application Bootstrap

Follow these steps to bootstrap the app in your development environment.

1. Install ruby gems: `sudo gem install bundler` 
2. Install dependencies

```sudo apt-get install libpq-dev 
sudo apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev
sudo apt-get install libxslt-dev libxml2-dev
sudo gem install pg -v '1.0.0'
sudo gem install nokogiri
```
       
3. bundle install
Troubleshooting: for the error `"Could not find 'bundler' (1.16.1) required"` try: `sudo bundle install`
   
4. `sudo apt-get install graphviz`
5. Install nodejs modules: `yarn install`

6. Create databases `bundle exec rails db:create`

7. Run migrations `bundle exec rails db:migrate`

8. Start the `tmux` development session `script/dev/session`

A cheat-sheet for tmux navigation is in `~/.tmux.conf`

## Host Web Access

    Get the host IP address `ifconfig` or `hostname -I`

    On your local machine, add the VM IP Address to /etc/hosts : `nano /etc/hosts`

    On your local machine, browse to `http://<hostname>:3000`
    
Voila! You've set up Bugmark on your local machine. 

## Online Collaboration
### ssh-chat

Connect to the ssh-chat server from the command line. `script/util/sshchat`

### File Transfer

Sender:

- type `wormhole send <filename>`
- note the wormhole code

Receiver:

- type `wormhole receive`
- get the wormhole code from the sender
- enter the wormhole code

### Terminal Sharing

Session host:

- start a tmate session `script/tmate/start`
- publish the session address `script/tmate/address` the session address is published onto SSH-Chat

Session participant:

- enter the ssh command with session address on your command line

### Desktop Sharing

Use Google Hangouts.

### sshfs

There is a remote-mount utility "sshfs" installed on your server.

With this, you can mount a directory from your server to your local desktop.

That way you can use a Desktop GUI editor like Atom or VsCode.

Here are [sshfs usage instructions](https://www.digitalocean.com/community/tutorials/how-to-use-sshfs-to-mount-remote-file-systems-over-ssh)
