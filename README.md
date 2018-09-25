# eg-build

Example vendor build package which builds whitelamp-uk and eg-vendor packages in a single directory.

This is a copy/tweak example for your own vendor build package.

Run these commands:

git clone https://github.com/eg-vendor/eg-build.git
cat eg-build/README.md
mkdir ~/hpapi
bash eg-build/eg-build.bash ~/hpapi

Read the notes.

Create database(s) and import SQL models in ./hpapi/.hpapi-build-sql/.

Add test users for JSON test files with this stored procedure (in database containing hpapi model):

CALL `hpapiInsertTestUsers`();

Configure ~/hpapi/.hpapi-config/ especially:
  * hpapi-models.cfg.json
  * whitelamp-uk/hpapi-hpapi.cfg.php
[HTTP without SSL requires that constant HPAPI_SSL_ENFORCE be set to false]

Configure web server for directory ~/hpapi/hpapi-server/ by:
 * Giving server directory permissions
 * Either symbolically link directory from document root as subdirectory eg:
     ln -s ~/hpapi/hpapi-server /var/www/html/api
 * Or create a virtual host for with directory as document root

Test using this command but with the appropriate URL for your server configuration:
php ~/hpapi/whitelamp-uk/hpapi-client-php-cli/hpapi.php eg-build/test.json https://localhost/api/
Or with interactive password (factory set to "password"):
php ~/hpapi/whitelamp-uk/hpapi-client-php-cli/hpapi.php eg-build/test-interactive.json https://localhost/api/
The returned JSON should contain the property response->returnValue containing a datetime-stamped UUID.


Note that an incorrect password still POSTs but only methods allowed for user group 'anon' will give a response->returnValue without an authentication error (notice the property authStatus changes if password is empty/wrong). An unrecognised API key is rejected entirely.

The critical tables for configuring web access control and validation are:
  * hpapi_call [server methods <--> SQL routines]
  * hpapi_membership [users <--> user groups]
  * hpapi_methodarg [server method arguments <--> validation patterns]
  * hpapi_run [server methods <--> user groups]
  * hpapi_sprarg [SQL routine arguments <--> validation patterns]
  * hpapi_user [key,email <--> password hash]

