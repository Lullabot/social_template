#!/usr/bin/env bash

# Make sure all code has been downloaded.
composer install

# Do new D8 install if there is no site installed.
if ! /app/vendor/bin/drush status --field=bootstrap --root=/app/html | grep -q Successful; then
    echo 'Performing D8 site install.'
    /app/vendor/bin/drush --root=/app/html si social --site-name="Open Social" -y
fi;
/app/vendor/bin/drush --root=/app/html updb -y
/app/vendor/bin/drush --root=/app/html cr
/app/vendor/bin/drush --root=/app/html cim -y
/app/vendor/bin/drush --root=/app/html cr
/app/vendor/bin/drush --root=/app/html upwd admin password

echo "Log in with credentials admin/password"
