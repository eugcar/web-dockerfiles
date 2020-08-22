FROM ecarocci/php-fpm-base:7.1

LABEL maintainer="carocci.eugenio@gmail.com"

# Configure entrypoint
COPY ./functions/symfony/*.sh                         /docker-entrypoint-functions/symfony/
COPY ./images/php/7.1/php-fpm/symfony-3/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod u+x /docker-entrypoint.sh && \
    chmod u+x /docker-entrypoint-functions/symfony/*.sh