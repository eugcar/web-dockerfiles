FROM ecarocci/base:centos7.7-remi

LABEL maintainer="carocci.eugenio@gmail.com"

# Install Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Install Node.js and Yarn
WORKDIR /tmp
RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash - && \
    yum install nodejs -y && \
    curl https://dl.yarnpkg.com/rpm/yarn.repo -o /etc/yum.repos.d/yarn.repo && \
    rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg && \
    yum install yarn -y && \
    yarn global add gulp

# Install base PHP Dependencies
RUN yum update -y && \
    yum install \
        php-bcmath \
        php-cli \
        php-fpm \
        php-gd \
        php-json \
        php-mbstring \
        php-pecl-mcrypt \
        php-mysqlnd \
        php-opcache \
        php-pdo \
        php-pecl-mongodb \
        php-pecl-xdebug \
        php-soap \
        php-xml \
        -y && \
    mkdir -p /run/php-fpm && \
    yum clean all

# Copy configuration
COPY ./conf/php/7.4/php-fpm/php-fpm.conf /etc/php-fpm.conf
COPY ./conf/php/7.4/php/php.ini          /etc/php.ini
COPY ./conf/php/7.4/php/php.d/*.ini      /etc/php.d/

# Configure entrypoint
COPY ./functions/general/*.sh                           /docker-entrypoint-functions/general/
COPY ./functions/php/*.sh                               /docker-entrypoint-functions/php/
COPY ./functions/php-fpm/*.sh                           /docker-entrypoint-functions/php-fpm/
COPY ./images/php/7.4/php-fpm/base/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod u+x /docker-entrypoint.sh && \
    chmod u+x /docker-entrypoint-functions/general/*.sh && \
    chmod u+x /docker-entrypoint-functions/php/*.sh && \
    chmod u+x /docker-entrypoint-functions/php-fpm/*.sh && \
    mkdir /docker-entrypoint-init.d

WORKDIR /var/www/html

CMD ["/docker-entrypoint.sh"]