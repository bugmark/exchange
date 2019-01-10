# Bugmark DevEnv

This covers the config and install of software components for Bugmark
development.

NOTE: you don't need the full development environment to contribute
documentation fixes!  Just clone the tracker, edit text files and submit PR's.

## Required Skills

To be successful, you'll need good skills with the following tools:
- Git
- Linux command line
- Web development
- PostgresQL
- Ruby/Rails
- Vim, Emacs or some command-line editor
- Tmux 

## Host Machine

We assume that you're using Ubuntu 18.04 as your host machine.  If you're Mac
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

1. Install Git, VirtualBox and Vagrant on your host machine (Linux, Win, Mac OK)

2. Run these commands:

    $ git clone http://github.com/andyl/VVM``
    $ cd VVM/packaged_full
    $ vagrant up
    $ vagrant ssh

## Cloning the Bugmark Exchange

1. Clone the tracker
   `mkdir src; cd src; git clone https://github.com/bugmark/exchange.git`

2. CD to the tracker directory `cd exchange`

## Application Bootstrap

Follow these steps to bootstrap the app in your development environment.

1. Install ruby gems `bundle install`

2. Install NPM components: `yarn install`

3. Create databases `bundle exec rails db:create`

4. Run migrations `bundle exec rails db:migrate`

5. Start the tmux development session `./script/dev/session`

  - A cheat-sheet for tmux navigation is in `~/.tmux.conf`.

## Host Web Access

1. Get the VM IP address `ifconfig | grep addr`  

2. On your local machine (host)
  - On Linux: Add the VM IP Address to `/etc/hosts`
  - On Windows: VirtualBox must be setup to use a bridged network adapter to allow a connection from the host to the Bugmark server on the VM. Restart VM `sudo shutdown -r` and restart the tmux development session, if necessary. No other changes are needed.

3. On your local machine (host), browse to `http://<VM IP address>:3000`
