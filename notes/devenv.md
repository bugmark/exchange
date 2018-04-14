# Bugmark DevEnv

This covers the config and install of software components for Bugmark
development.

NOTE: you don't need the full development environment to contribute
documentation fixes!  Just clone the repo, edit text files and submit PR's.

## Required Skills

To be successful, you'll need good skills with the following tools:
- Git
- Linux command line
- Web development
- PostgresQL
- Ruby/Rails
- Vim, Emacs or some command-line editor
- Tmux (nice to have)

## Host Machine

We assume that you're using Ubuntu 16.04 as your host machine.  If you're Mac
savvy, you'll be able to get things running on a Mac. 

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

Follow these steps to set up a working development environment running on an
Ubuntu Virtual machine.

Let's get started:

1. Install VirtualBox and Vagrant on your host machine (Linux, Win, Mac OK)

2. Download the dev-machine Vagrantfile 
   `wget raw.githubusercontent.com/bugmark/exchange/master/Vagrantfile`

3. Run `vagrant up` to create a virtual machine.

4. Login to your virtual machine using `vagrant ssh`

## Cloning the Bugmark Exchange

1. Clone the repo 
   `mkdir src; cd src; git clone https://github.com/bugmark/exchange.git`

2. CD to the repo directory `cd exchange`

## Development Environment Provisioning

On the host machine:

1. Checkout the dev branch `git checkout -b dev origin/dev`

2. Install ansible `script/dev/provision/install_ansible`

3. Install ansible roles `script/dev/provision/install_roles`

4. Provision the dev machine `script/dev/provision/localhost`

5. Check database status: `systemctl status postgresql`

6. Start a new shell: `bash` (required to load your new user configuration)

## Application Bootstrap

Follow these steps to bootstrap the app in your development environment.

1. Install ruby gems `gem install bundler; bundle install`

2. Install NPM components: `yarn install`

3. Create databases `bundle exec rails db:create`

4. Run migrations `bundle exec rails db:migrate`

5. Start the tmux development session `script/dev/session`

   A cheat-sheet for tmux navigation is in `~/.tmux.conf`.

## Host Web Access

1. Get the host IP address `ifconfig`  

2. On your local machine, add the VM IP Address to `/etc/hosts`

3. On your local machine, browse to `http://<hostname>:3000`

## Online Collaboration

### SSH-Chat

Connect to the SSH-Chat server from the command line.
`script/util/sshchat`

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
- publish the session address `script/tmate/address`
  the session address is published onto SSH-Chat

Session participant:
- enter the ssh command with session address on your command line

### Desktop Sharing

Use Google Hangouts.

### SSHFS

There is a remote-mount utility "sshfs" installed on your server.

With this, you can mount a directory from your server to your local desktop.

That way you can use a Desktop GUI editor like Atom or VsCode.

Here are SSHFS usage instructions:
https://www.digitalocean.com/community/tutorials/how-to-use-sshfs-to-mount-remote-file-systems-over-ssh
