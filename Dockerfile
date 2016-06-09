FROM ubuntu:latest
RUN locale-gen en_US.UTF-8 \
	&& export LANG=en_US.UTF-8 \
	&& apt-get update \
	&& apt-get install -y software-properties-common \
	&& apt-get install -y language-pack-en-base \
	&& LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php \
	&& apt-get update \
    && apt-get -y install apache2 libapache2-mod-php5.6 php5.6 php5.6-cli php5.6-mbstring php-xdebug sqlite3 php5.6-mysql php-apcu php-imagick php-memcached php-pear curl imagemagick php5.6-dev php5.6-phpdbg php5.6-gd npm nodejs-legacy php5.6-json php5.6-curl php5.6-sqlite3 php5.6-pgsql php5.6-intl apache2 vim git-core wget libsasl2-dev libssl-dev libsslcommon2-dev libcurl4-openssl-dev mercurial \
	&& a2enmod headers \
	&& a2enmod rewrite \
	&& npm install -g grunt-cli bower

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log
RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR


VOLUME [ "/var/www/html" ]
WORKDIR /var/www/html

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/apache2" ]
CMD ["-D", "FOREGROUND"]
