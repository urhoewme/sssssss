FROM ubuntu

LABEL maintainer = "Proteon Communication Builders BV"

ENV DEBIAN_FRONTEND noninteractive

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

RUN apt-get update && apt-get install -y apache2

RUN mkdir -p /var/www/html
RUN mkdir -p /var/log/apache2/vhost

ADD vhost.conf /etc/apache2/sites-available/
ADD index.html /var/www/html

RUN a2dissite 000-default
RUN a2ensite vhost

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]