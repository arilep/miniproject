# All-in-one work environment

A mini-project for a pre-configured work environment.

Install and configure the most common tools and programs quickly and easily, and monitor your VM's system usage in your browser:

![image](https://github.com/user-attachments/assets/01d508f8-59d0-42dc-b7e1-25ff22769e8e)

### Software to be installed:
- Netdata
- Micro
- Git
- Apache
- Firewall (ufw)

### Installation

1. Download and/or replace Vagrantfile contents
2. Set up VM's with `vagrant up`
3. Accept the slave-key on master with `sudo salt-key -A`
4. Create a folder for the module `sudo mkdir -p /srv/salt/example && cd /srv/salt/example`
5. Copy init.sls into the folder, or run `sudoedit init.sls` and insert the init.sls data into the file.
6. Run the module on the slave `sudo salt '*' state.apply example`

### Netdata fix

If netdata isn't working:

1. SSH into 'pcslave' with `vagrant ssh pcslave`
2. Edit the Netdata config file: `sudoedit /etc/netdata/netdata.conf`
3. Set "bind socket to IP" value to 192.168.60.102 (slave IP)
4. enable port 19999: `sudo ufw allow 19999`
5. Restart netdata with `sudo systemctl restart netdata` and go to the browser: `http://192.168.60.102:19999`
