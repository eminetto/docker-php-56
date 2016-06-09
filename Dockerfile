FROM php:5.6-cli
RUN apt-get update \
	&& apt-get install -y software-properties-common git mercurial zip libpq-dev \
    && docker-php-ext-install -j$(nproc) pdo_mysql pdo_pgsql mbstring
