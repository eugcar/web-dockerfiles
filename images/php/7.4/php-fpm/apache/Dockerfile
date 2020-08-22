FROM ecarocci/php-fpm-base:7.4

LABEL maintainer="carocci.eugenio@gmail.com"

# Install Apache2
RUN yum update -y && \
    yum install httpd -y && \
    yum clean all

RUN rm -rf /etc/httpd/conf.d/autoindex.conf && \
    rm -rf /etc/httpd/conf.d/userdir.conf && \
    rm -rf /etc/httpd/conf.d/welcome.conf && \
    rm -rf /etc/httpd/conf.d/000-default.conf && \
    rm -rf /etc/httpd/conf.modules.d/00-dav.conf E && \
    rm -rf /etc/httpd/conf.modules.d/00-lua.conf && \
    rm -rf /etc/httpd/conf.modules.d/01-cgi.conf && \
    rm -rf /var/www/html && \
    rm -rf /var/www/cgi-bin

# Copy configuration
COPY ./conf/httpd/httpd.conf            /etc/httpd/conf/httpd.conf
COPY ./conf/httpd/conf.d/*.conf         /etc/httpd/conf.d/
COPY ./conf/httpd/conf.modules.d/*.conf /etc/httpd/conf.modules.d/

# Configure entrypoint
COPY ./functions/apache/*.sh                              /docker-entrypoint-functions/apache/
COPY ./images/php/7.4/php-fpm/apache/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod u+x /docker-entrypoint.sh && \
    chmod u+x /docker-entrypoint-functions/apache/*.sh