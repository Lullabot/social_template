# Open Social

This repo is a fork of [Open Social](https://github.com/goalgorilla/social_template).

## Lando
This fork includes configuration to create a local PHP 7.3 environment using Lando. This is handy if you don't have PHP 7.3 installed on your local machine (a requirement for this distro to work).

Once Lando is installed, just navigate to the top level of this repo and start Lando:

```
lando start
```
Once Lando is started, you can install/update the code. 

```
lando composer install
lando composer update --with-dependencies
```
The Lando scripts will install an Open Social site from scratch if the database is empty.