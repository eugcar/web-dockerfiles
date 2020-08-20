FROM ecarocci/base:centos7.6

LABEL maintainer="carocci.eugenio@gmail.com"

# Refer to: https://ius.io/setup
WORKDIR /tmp
RUN yum install -y epel-release && \
    yum update -y && \
    yum install -y https://repo.ius.io/ius-release-el7.rpm && \
    yum-config-manager --enable ius-archive && \
    yum -y update