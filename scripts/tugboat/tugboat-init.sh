#!/bin/bash

# Build steps so Tugboat build will match Georgia.gov Quay image.
# @see https://bitbucket.org/georgiagov/docker-webhead/src/b3880b4ebf99a49bc3c09664022ed3c639c126da/webhead-tugboat/Dockerfile
apt-get update && \
    apt-get install -y --no-install-recommends --quiet gnupg && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y --no-install-recommends --quiet \
      imagemagick \
      mysql-client \
      parallel \
      libxml2-dev \
      nodejs && \
    npm install -g grunt-cli && \
# Install drush-launcher
    wget -q -O /usr/local/bin/drush https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar && \
    chmod +x /usr/local/bin/drush && \
# Install opcache, zip, and mod-rewrite.
    docker-php-ext-install opcache && \
    docker-php-ext-install zip && \
    docker-php-ext-install soap && \
    a2enmod headers rewrite && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
