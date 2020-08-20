FROM centos:7.6.1810

LABEL maintainer="carocci.eugenio@gmail.com"

# Refer to: https://hub.docker.com/_/centos - Minor Tags section
RUN yum -y update && \
    yum clean all && \
    yum install policycoreutils-python -y && \
    yum install epel-release -y && \
    yum-config-manager --enable "Extra Packages for Enterprise Linux 7 - x86_64" && \
    yum install wget -y

# Install utilities
RUN yum install dos2unix \
                git \
                htop \
                less \
                nano \
                ntp \
                openssl \
                psmisc \
                unzip \
                vim \
                -y && \
    yum clean all