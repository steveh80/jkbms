# JKBMS

Dockerfile to create a docker container which is connecting to a JKBMS via Bluetooth LE and pushes its values periodically to mqtt.


## Bluetooth connection to JK BMS

Install bluetooth on your host machine first and find your JKBMS Mac address:

```
apt install pi-bluetooth bluez
reboot

# scan for bluetooth devices
hcitool lescan
```

Create `/root/jkbms/jkbms.conf` with the following content, use the macaddress in the field `port`:

```
[SETUP]
# Number of seconds to pause between command execution loop
# 0 is no pause, greater than 60 will cause service restarts
pause=5
mqtt_broker=192.168.x.x
mqtt_user=jkbms
mqtt_pass=xxx
porttype=MQTT
mqtt_topic=jkbms

# This example would work on a JKBMS that uses JK04 protocol (HW v3.0)
[JKBMS]
type=jkbms
protocol=JK02
port=C8:47:8C:E5:A1:E8
command=getCellData
tag=CellData
outputs=json_mqtt
```

Start Docker-Container:
```
docker run -d \
  --restart=always \
  --net=host\
  --privileged \
  -v /var/run/dbus/:/var/run/dbus/:z \
  -v /root/jkbms/jkbms.conf:/etc/jkbms.conf \
  --name jkbms haeuslschmid/jkbms
```
