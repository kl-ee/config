#!/usr/bin/env bash

###############################################################################
# Helpful Links
###############################################################################
# https://engineering.riotgames.com/news/putting-jenkins-docker-container
# https://engineering.riotgames.com/news/docker-jenkins-data-persists
# https://engineering.riotgames.com/news/jenkins-docker-proxies-and-compose

# https://engineering.riotgames.com/news/taking-control-your-docker-image
###############################################################################

# Build docker images
#   - "Empty" images based on latest debian/jenkins images on the box)
#   - Data volumes below are what makes these images unique for us
docker build -t jenkins-pi jenkins-pi/.
docker build -t jenkins-data jenkins-data/.

# Start docker containers
#   - [New] docker create --name=jenkins-data jenkins-data
#   - [Old] See below for data volume migration
docker run -p 56789:8080 -p 5000:5000 --name=jenkins-master --volumes-from=jenkins-data -d jenkins-pi

# Stop docker containers
# TODO: Make this an option
#docker stop jenkins-master
#docker rm jenkins-master
##(This deletes our data - tar the data if we really want this)docker rm jenkins-data
## If we want to tar the data, create a container that mounts the data container and a local mount
##  then tar the data in the data container into the local mount
## Remember: docker cp jenkins-data:/file file

###############################################################################
#  Data Volume Migration
###############################################################################
# https://docs.docker.com/engine/userguide/containers/dockervolumes/
# http://stackoverflow.com/questions/21597463/how-to-port-data-only-volumes-from-one-host-to-another/23778599#23778599
###############################################################################
# [Original Machine] Tar data volume into backup_file
#   Note: Transfer the tar file to the new machine
docker run --rm --volumes-from jenkins-data -v `pwd`:/backup debian:jessie tar cvf /backup/backup.tar /var/log/jenkins /var/jenkins_home

# [New Machine] Untar backup_file into new data volume
#   Note: Must have jenkins-data-pi image
#   Note: Make sure we have the backup file in the current working directory because we mounted `pwd`
docker create --name=jenkins-data jenkins-data-pi
docker run --rm -volumes-from=jenkins-data -v `pwd`:/backup debian:jessie bash -c "tar xvf /backup/backup.tar"

