#!/bin/bash

# Add file limits configs - allow to open 100,000 file descriptors
echo "* hard nofile 100000
* soft nofile 100000" | sudo tee --append /etc/security/limits.conf

# reboot for the file limit to be taken into account
sudo reboot # then redo login with SSH
sudo service zookeeper start
sudo chown -R ubuntu:ubuntu /data/kafka # after the mount done before for the kaf. cluster

# edit kafka configuration
rm config/server.properties
vi config/server.properties # paste the proprieties in the kafka folder

# launch kafka
bin/kafka-server-start.sh config/server.properties

# Install Kafka boot scripts
sudo vi /etc/init.d/kafka # paste the kafka/kafka file
sudo chmod +x /etc/init.d/kafka
sudo chown root:root /etc/init.d/kafka
# you can safely ignore the warning
sudo update-rc.d kafka defaults

# start kafka
sudo service kafka start # sudo service kafka status to check
# verify it's working
nc -vz localhost 9092
# look at the server logs
cat /home/ubuntu/kafka/logs/server.log

# RUNNING KAFKA COMMANDS
# create a topic
bin/kafka-topics.sh --zookeeper zookeeper1:2181/kafka --create --topic first_topic --replication-factor 1 --partitions 3
# produce data to the topic
bin/kafka-console-producer.sh --broker-list kafka1:9092 --topic first_topic
hi
hello
(exit)
# read that data
bin/kafka-console-consumer.sh --bootstrap-server kafka1:9092 --topic first_topic --from-beginning
# list kafka topics
bin/kafka-topics.sh --zookeeper zookeeper1:2181/kafka --list
