FROM larsks/fedora-base:20
MAINTAINER lars@oddbit.com

RUN yum -y install python-keystoneclient
RUN yum -y install python-glanceclient
ADD keystonerc /root/keystonerc
ADD setup-keystone.sh /root/setup-keystone.sh

