# **Domo - Openwrt**

###Domo scripts and configurations for Openwrt

# USAGE

###Required packages
- mosquitto
- libmosquitto
- lua
- lua-mosquitto
- libwebsockets-openssl (optional)

### Copy files
- Generate SSL certificates (see /etc/mosquitto/certificates.README)
- Generate passwd file (see /etc/mosquitto/passwd.README)
- Copy files from this repo to your Openwrt system
- Copy SSL certificates and passwd to your Openwrt system (see /etc/mosquitto/mosquitto.conf)
- Edit MQTT username and password in /root/mqtt_client/mqtt_send.lua /root/mqtt_client/mqtt_scattato.lua
- Assign right permissions to files (init.d, mqtt_client, mosquitto.conf, passwd, etc...)
- Enable mosquitto, domo and cron services

### Reboot your system