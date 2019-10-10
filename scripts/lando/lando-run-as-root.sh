#!/usr/bin/env bash

# Set file permissions.
mkdir -p "/app/private/files"
mkdir -p  "/app/html/sites/default/files"
chgrp -R www-data "/app/html/sites/default/files" "/app/private/files"
chmod -R g+w "/app/html/sites/default/files" "/app/private/files"
chmod 2775 "/app/html/sites/default/files" "/app/private/files"
