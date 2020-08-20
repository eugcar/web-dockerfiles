FROM ecarocci/base:centos7.7

LABEL maintainer="carocci.eugenio@gmail.com"

# Refer to: https://blog.remirepo.net/post/2019/12/03/Install-PHP-7.4-on-CentOS-RHEL-or-Fedora
WORKDIR /tmp
RUN yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y && \
    yum install https://rpms.remirepo.net/enterprise/remi-release-7.rpm -y && \
    yum install yum-utils -y && \
    yum-config-manager --enable remi-php74 && \
    yum -y update