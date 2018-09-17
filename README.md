# eg-build
Example vendor build script (including whitelamp-uk packages)

Run these commands:

mkdir ~/hpapi
git clone https://github.com/eg-vendor/eg-build.git
bash eg-build/eg-build.bash ~/hpapi

Note the HTTP document root and implement in web server configuration
Create a database and import into it the SQL contained in eg-build.sql.tmp

Configure everything in ~/hpapi/.hpapi-config/

Test with this command:
php ~/hpapi/whitelamp-uk/hpapi-client-php-cli/hpapi.php -f ~/hpapi/eg-vendor/hpapi-json-examples/hello.json
 
Browse the example javascript client: ~/hpapi/eg-vendor/eg-client/index.html

