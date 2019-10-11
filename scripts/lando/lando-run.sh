#!/usr/bin/env bash

# Make sure all code has been downloaded.
composer install

cp /app/dist/settings.php /app/html/sites/default/settings.php
cp /app/dist/lando/settings.lando.php /app/html/sites/default/settings.local.php

# Create file directories and set file permissions.
mkdir -p "/app/private/files"
mkdir -p  "/app/html/sites/default/files"
chgrp -R www-data "/app/html/sites/default/files" "/app/private/files"
chmod -R g+w "/app/html/sites/default/files" "/app/private/files"
chmod 2775 "/app/html/sites/default/files" "/app/private/files"

# Do new D8 install if there is no site installed.
if ! /app/vendor/bin/drush status --field=bootstrap --root=/app/html | grep -q Successful; then
    #echo 'Performing D8 site install.'
    /app/vendor/bin/drush --root=/app/html si social install_configure_form.update_status_module='array(FALSE,FALSE)' --site-name="Open Social" -y
    /app/vendor/bin/drush --root=/app/html cex -y

    # Make sure some non-default modules are enabled.
    /app/vendor/bin/drush --root=/app/html en social_comment_upload
    /app/vendor/bin/drush --root=/app/html en social_devel
    /app/vendor/bin/drush --root=/app/html en devel_entity_updates
fi;

# Per instructions on https://www.drupal.org/docs/8/distributions/open-social/installing-and-updating
/app/vendor/bin/drush --root=/app/html updb -y
/app/vendor/bin/drush --root=/app/html entup -y
/app/vendor/bin/drush --root=/app/html -y fra --bundle=social
/app/vendor/bin/drush --root=/app/html cr
#/app/vendor/bin/drush --root=/app/html cim -y
#/app/vendor/bin/drush --root=/app/html cr
/app/vendor/bin/drush --root=/app/html upwd admin password

echo "Log in with credentials admin/password"
