# Bugmark DevEnv

This covers the install and config of software components for Bugmark
development.

NOTE: you don't need the full development environment to contribute
documentation fixes!  Just clone the tracker, edit text files and submit PR's.

## Required Skills

You'll need good skills with the following tools:

- Git
- Linux command line
- Web development
- PostgresQL
- Ruby/Rails
- Vim, Emacs or some command-line editor
- Tmux 

Know how to clone a repo, make commits and submit PRs. Check out our [Git
Sandbox][gs] for info and practice.

[gs]: https://github.com/bugmark/sandbox

## Development Machine

Use Ubuntu 18.04 for development. We use [Virtual Machines][vvm].  Follow these
steps to set up a working system:

1. Install Git, VirtualBox and Vagrant on your host machine (Linux, Win, Mac OK)

2. Run these commands:

    $ git clone http://github.com/andyl/VVM
    $ cd VVM/packaged_full
    $ vagrant up
    $ vagrant ssh

[vvm]: https://github.com/andyl/VVM

## Cloning the Bugmark Exchange

1. Clone the tracker

    `mkdir src; cd src; git clone git@github.com:bugmark/exchange.git`

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

1. Configure [port forwarding][vpf] in your Vagrantfile.

2. In the browser on your local machine, visit `http://localhost:<yourport>`.

[vpf]: https://www.vagrantup.com/docs/networking/forwarded_ports.html

