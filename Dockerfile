FROM fedora:20
MAINTAINER lars@oddbit.com

RUN yum -y upgrade
RUN yum -y install python-keystoneclient

ADD keystonerc /root/keystonerc

