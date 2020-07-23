# Setup InfluxDB and Grafana for Visualizations and Analytics

## Install InfluxDB and Grafana if not already installed

1.  append file ./script/dev/provision/playbook/development.yml (`vim ~/src/exchange/script/dev/provision/playbook/development.yml` in section 'roles' with 
```
    - influxdb
    - grafana
```

2. Go to the ~/src/exchange folder `cd ~/src/exchange`

3. Install ansible roles to get updated roles `./script/dev/provision/install_roles`

4. Provision the dev machine to install InfluxDB and Grafana `./script/dev/provision/localhost`

5. Test if InfluxDB is running `systemctl status influxdb` and if not, start influx `sudo systemctl start influxdb`

6. Connect to the InfluxDB by typing the command: `influx`

7. Within the influx console, create an admin user `create user admin with password 'admin' with all privileges`

8. Leave influx `exit`

9. Rerun the provision script to finish the installation `./script/dev/provision/localhost`

10. Test if Grafana is running `systemctl status grafana-server` and if not, start Grafana `sudo systemctl start grafana-server`

11. Grafana should be available from a browser `http://<hostname>:3030` with username `admin` and password `admin`


## Configure Grafana

1. Connect to Grafana from a browser `http://<hostname>:3030` with username `admin` and password `admin`

2. Configure a DB connection
  - type: influxDB
  - Basic Autho (yes)
  - user: admin
  - pasword: admin
  - database: bugm_stats
  - user: admin
  - password: admin

3. Only after you have data in InfluxDB does it make sense to setup a panels because Grafana will only allow you to setup visualizations for existing data.
