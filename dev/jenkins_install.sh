#!/bin/bash
cd /opt/
#install java rpm package with jdk 8
wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm
#unpack rpm package
rpm -ivh jdk-8u131-linux-x64.rpm
#enable the EPEL package
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
#adding key to the above package
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#update
yum update -y
#install jenkins
yum install jenkins -y
#start jenkins
systemctl start jenkins
#enable jenkins as a os level service
systemctl enable jenkins


#maven installation
wget https://mirrors.estointernet.in/apache/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip
#unzip the package
unzip apache-maven-3.8.1-bin.zip
#rename
mv apache-maven-3.8.1 maven38
#change the permissions
chmod -R 700 maven38


#install git 
yum update -y
yum install git -y

