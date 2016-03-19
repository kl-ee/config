FROM jenkins:latest
MAINTAINER pi

USER root
RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins
RUN apt-get update
RUN apt-get install -y cmake ninja-build g++
RUN apt-get install -y ncurses-dev
ENV CXX=/usr/bin/g++
USER jenkins

ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war"
