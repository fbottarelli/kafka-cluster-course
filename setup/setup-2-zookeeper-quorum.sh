#!/bin/bash
# create data dictionary for zookeeper
sudo mkdir -p /data/zookeeper
sudo chown -R ubuntu:ubuntu /data/
# declare the server's identity
echo "1" > /data/zookeeper/myid
# edit the zookeeper settings
rm /home/ubuntu/kafka/config/zookeeper.properties
# now copy the zookeeper.proprieties config file in zookeeper folder in this new empty file:
vi /home/ubuntu/kafka/config/zookeeper.properties
# restart the zookeeper service
sudo service zookeeper stop
sudo service zookeeper start
# we need to launch this command in each machine to adress the ERRORS

# observe the logs - need to do this on every machine
cat /home/ubuntu/kafka/logs/zookeeper.out | head -100
nc -vz localhost 2181 # or zookeeper1
nc -vz localhost 2888
nc -vz localhost 3888
echo "ruok" | nc localhost 2181 ; echo
echo "stat" | nc localhost 2181 ; echo
bin/zookeeper-shell.sh localhost:2181
# not happy
ls /
