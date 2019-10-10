#!/bin/bash

ln -snf ${TUGBOAT_ROOT}/docroot ${DOCROOT}
composer install --optimize-autoloader --no-ansi --no-interaction

# Use the tugboat-specific Drupal settings
cp ${TUGBOAT_ROOT}/.tugboat/settings.local.php ${DOCROOT}/sites/default/
# Generate a unique hash_salt to secure the site
echo "\$settings['hash_salt'] = '$(openssl rand -hex 32)';" >> "${DOCROOT}/sites/default/settings.local.php"

# File permissions.
mkdir -p ${TUGBOAT_ROOT}/private/files
mkdir -p  ${DOCROOT}/sites/default/files
chgrp -R www-data ${DOCROOT}/sites/default/files ${TUGBOAT_ROOT}/private/files
chmod -R g+w ${DOCROOT}/sites/default/files ${TUGBOAT_ROOT}/private/files
chmod 2775 ${DOCROOT}/sites/default/files ${TUGBOAT_ROOT}/private/files

# Install the site from configuration if not already installed.
if ! drush -r ${DOCROOT} status --field=bootstrap | grep -q Successful; then
    drush -r ${DOCROOT} si standard --site-name="Daily Report" -y
    drush -r ${DOCROOT} config-set "system.site" uuid 'e512c491-20cf-4c93-a0b8-bd1df5883f98' -y
    drush -r ${DOCROOT} ev '\Drupal::entityManager()->getStorage("shortcut_set")->load("default")->delete();'
fi;
drush -r ${DOCROOT} updb -y
drush -r ${DOCROOT} cr
drush -r ${DOCROOT} cim -y
drush -r ${DOCROOT} cr
drush -r ${DOCROOT} upwd admin password
