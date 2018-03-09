# Bugmark README

## Synopsis

This is the codebase behind [bugmark.net](https://bugmark.net), Bugmark - A Market for Tradable Software Issues.

## Contributors

Thank you to all of our contributors.  Contributors to the codebase can be found [here](https://github.com/bugmark/bugmark/graphs/contributors).

## License

[MPL v2.0](https://github.com/bugmark/bugmark/blob/master/LICENSE).


## Contributing

All developers are welcome to contribute to the codebase. All contributors are expected to adhere to our code of conduct, which can be found [here](https://www.mozilla.org/en-US/about/governance/policies/participation/).  Thank you for your contribution - details on our stack can be found below.

NOTE: you don't need the full development environment to contribute documentation fixes!  Just clone the repo, edit text files and submit PR's.

## Development VM Configuration

Follow these steps to set up a working development environment running on an Ubuntu Virtual machine.

NOTE: this configuration process will install many packages and will make changes to your user configuration, including:
- adding items to your `.bashrc`, modifying your path
- adding your UserID to `sudoers`

To preserve your settings, perform this configuration under a separate userid.

Let's get started:

1. Install VirtualBox and Vagrant on your host machine (Linux, Win, Mac OK)

2. Download the dev-machine Vagrantfile 
   `wget raw.githubusercontent.com/mvscorg/bugmark/Vagrantfile`

3. Run `vagrant up` to create a virtual machine.

4. Login to your virtual machine using `vagrant ssh`

5. Use the following command to clone the local/forked copy of the repo to your local environment:

   `mkdir src; cd src; git clone https://github.com/<github username>/bugmark.git`
   
   Once the git clone is complete, navigate into the root folder. Then, use the following to install dependencies.

6. CD to the repo directory `cd ~/src/bugmark`


## System Requirements

Before beginning the installation of your environment, ensure that you have a copy of git, Ruby, and Rails on your computer.

* [Git](https://git-scm.com/downloads) 
* [Ruby 2.4.0 and Rails 5.1.3](https://gorails.com/setup/ubuntu/16.04)
* [PostGreSQL](https://www.postgresql.org/download/linux/ubuntu/)

## Postgres

Start the postgres console using the following command:

``` sudo -u postgres psql ```

Next, create a user postgres with the password postgres:

``` 
    CREATE USER postgres WITH PASSWORD 'postgres'; 
    ALTER USER postgres CREATEDB;
```
Exit the console using the following command:

``` \q ```

Open `config/database.yml`. Then make sure you modify the settings so it could connect to your postgres server.

Open file `/etc/postgresql/9.1/main/pg_hba.conf` and change the following line:

`local     all     postgres     peer`

to

`local    all     postgres      md5`

After altering this file, save and exit, don't forget to restart your PostgreSQL server using command ```sudo service postgresql restart```.

## Development Environment Provisioning

On the new VM:

1. Checkout the dev branch `git checkout -b dev origin/dev`

2. Install ansible `script/dev/provision/install_ansible`

3. Install ansible roles `script/dev/provision/install_roles`

4. Provision the dev machine `script/dev/provision/localhost`

5. Check database status: `systemctl status postgresql`

6. Start a new shell: `bash` (required to load your new user configuration)


## Dependencies
Type following commands to install and configure dependencies. 
```
sudo apt-get install libpq-dev linuxbrew-wrapper
bundle config git.allow_insecure true
git config --global url.https://github.com/.insteadOf git://github.com/
sudo apt install yard
npm install
yard config --gem-install-yri
```
1. Install ruby gems
   ```
   gem install pg -v '0.20.0'
   gem install bundler
   bundle install
   ```
2. Install NPM components: `yarn install`
   
   If working behind proxy
   ```
   yarn config set https-proxy http://your.proxy.server:port
   yarn config set https-proxy http://your.proxy.server:port
   ```

3. Get seed data from a partner: (you might get by without this...)

| PARTNER COMMAND         | YOUR COMMAND          |
|-------------------------|-----------------------|
| `script/seed/share_env` | `script/seed/get_env` |

4. Run migrations `bundle exec rails db:migrate`

5. Finally, seed the database using: ` rake db:seed `

6. Load seed data `script/data/all_reload`

7. Start the tmux development session `script/dev/session`

   A cheat-sheet for tmux navigation is in `~/.tmux.conf`.


## Finish

Now, everything should be completely set up! Run the app locally on your computer using the following command:

``` rails s ```

You should be to view and interact with the site on http://localhost:3000. Now you're ready to get start contributing!


## Testing

`bundle exec rake spec` 
    
## Host Web Access

1. Get the VM IP address `ifconfig`  

2. On your host machine, add the VM IP Address to `/etc/hosts`

3. On your host machine, browse to `http://<hostname>:3000`

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

