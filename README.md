# A ready to use Apache Hadoop Cluster

This bundle provides a ready to use Apache Hadoop Cluster with connected Hive integration on top of Vagrant virtual machines. The default setup includes one Hadoop Master node and two Hadoop Slave nodes (and a backup node).

## Hadoop Cluster Details

- Ubuntu (Precise) 12.04 LTS 64-bit
- Java 6 (openjdk-6-jdk)
- Apache Hadoop 1.0.2 (Stable)
- Apache Pig 0.9.2 (Stable)
- Apache Hive 0.8.1 (Stable)
- MongoDB Connector for Hadoop ([view on Github](https://github.com/mongodb/mongo-hadoop/blob/master/README.md))

## System Requirements

- A working Git Installation
- A working Vagrant installation (http://www.vagrantup.com/)

## Quick Start

Step 1: Clone the repository (master)

	git clone https://github.com/ssalat/vagrant-hadoop-cluster.git vagrant-hadoop-cluster
	cd vagrant-hadoop-cluster
	git submodule init
	git submodule update

Step 2: Extend your /etc/hosts file on your local machine and add the following entries:

	192.168.66.10   hadoop-master.local
	192.168.66.11   hadoop-slave1.local
	192.168.66.12   hadoop-slave2.local

Step 3: Start the Vagrant Hadoop Cluster (first the slaves and after that the master):

	vagrant up hadoop-master /hadoop-slave[0-9]/

Step 4: SSH into the hadoop-master and switch to root user:

	vagrant ssh hadoop-master
	sudo su

Step 5: Format the HDFS filesystem (as root user):

	hadoop namenode -format

Step 6: Start the hadoop cluster (as root user):

	sh /usr/lib/hadoop/bin/start-all.sh

Check the cluster status by the web interfaces.

## Web Interfaces (GUIs)

#### Namenode web interface (master only):

	http://hadoop-master.local:50070/

[Open URL in Browser](http://hadoop-master.local:50070/)

#### Jobtracker web interface (master only):

	http://hadoop-master.local:50030/

[Open URL in Browser](http://hadoop-master.local:50030/)

#### Tasktracker web interface (all slaves):

	http://hadoop-slave1.local:50060/

[Open URL in Browser](http://hadoop-slave1.local:50060/)

	http://hadoop-slave2.local:50060/

[Open URL in Browser](http://hadoop-slave2.local:50060/)

## Examples

All the following examples are executed as root user on the hadoop-master node (see Step 4 in the Quick Start Guide).

### Apache Pig

Run an Apache Pig Script in local mode:

	pig -x local script.pig

Run an Apache Pig Script in cluster mode:

	pig -x mapreduce script.pig
