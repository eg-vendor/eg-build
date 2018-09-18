# eg-build

Example vendor build package which builds whitelamp-uk and eg-vendor packages in a single directory.

This is a copy/tweak example for your own vendor build package.

Run these commands:

mkdir ~/hpapi
git clone https://github.com/eg-vendor/eg-build.git
bash eg-build/eg-build.bash ~/hpapi

Read the notes.

Create database(s) and import SQL models in ./hpapi/.hpapi-build-sql/.

Configure ~/hpapi/.hpapi-config/ especially:
  * hpapi-models.cfg.json
  * whitelamp-uk/hpapi-hpapi.cfg.php

Configure web server for directory ~/hpapi/hpapi-server/ by:
 * Giving server directory permissions
 * Either symbolically link directory from document root as subdirectory eg:
     ln -s ~/hpapi/hpapi-server /var/www/html/api
 * Or create a virtual host for with directory as document root

Test using this command but with the appropriate URL for your server configuration:
php ~/hpapi/whitelamp-uk/hpapi-client-php-cli/hpapi.php eg-build/test.json https://localhost/api/
The returned JSON should contain the property response->returnValue containing a datetime-stamped UUID.
