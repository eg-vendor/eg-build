
# Hpapi directory
if [ ! -d "$1" ]
then
    echo "Hpapi directory \"$1\" not found" 
    exit 101
fi
cd "$1"
wd="$(pwd)"


# Example vendor packages
mkdir -p eg-vendor
cd eg-vendor
if [ ! -d ./eg-server ]
then
    git clone https://github.com/eg-vendor/eg-server.git
fi
if [ ! -d ./eg-client ]
then
    git clone https://github.com/eg-vendor/eg-client.git
fi
cd ..

# Whitelamp packages
mkdir -p whitelamp-uk
cd whitelamp-uk
if [ ! -d ./hpapi-server ]
then
    git clone https://github.com/whitelamp-uk/hpapi-server.git
fi
if [ ! -d ./hpapi-hpapi ]
then
    git clone https://github.com/whitelamp-uk/hpapi-hpapi.git
fi
if [ ! -d ./hpapi-client-js ]
then
    git clone https://github.com/whitelamp-uk/hpapi-client-js.git
fi
if [ ! -d ./hpapi-client-php-cli ]
then
    git clone https://github.com/whitelamp-uk/hpapi-client-php-cli.git
fi
if [ ! -d ./hpapi-utility ]
then
    git clone https://github.com/whitelamp-uk/hpapi-utility.git
fi
if [ ! -d ./hpapi-dba ]
then
    git clone https://github.com/whitelamp-uk/hpapi-dba.git
fi
cd ..


# Logs
mkdir -p .hpapi-log
touch .hpapi-log/hpapi-last-output.log


# Config
mkdir -p .hpapi-config
for egpath in $(find . -iname *.EXAMPLE)
do
    if [ ! -f $egpath ]
    then
        echo "Aborting further config - probably whitespace in a path"
        exit
    fi
    newfile=$(basename "$egpath")
    newfile=${newfile%.*}
    cd $(dirname $egpath)
    cd ../..
    vendor="$(basename "$(pwd)")"
    cd "$wd"
    echo "From $(pwd):"
    mkdir -p .hpapi-config/$vendor
    if [ -f .hpapi-config/$vendor/$newfile ]
    then
        continue
    fi
    echo cp $egpath .hpapi-config/$vendor/$newfile
    cp $egpath .hpapi-config/$vendor/$newfile
done
cd .hpapi-config
for file in choices.cfg.html hpapi-models.cfg.json hpapi-pdo.dfn.json hpapi-server.hdr.php humans.txt
do
    if [  -f  ./$file ]
    then
        rm whitelamp-uk/$file
    else
        if [ -f whitelamp-uk/$file ]
        then
            mv whitelamp-uk/$file ./
        fi
    fi
done
cd ..


# Information
echo ""                                                             >  ./.hpapi-log/hpapi-build.log
echo "Location:           $1"                                       >> ./.hpapi-log/hpapi-build.log
echo "Build log:          $(pwd)/.hpapi-log/hpapi-build.log"        >> ./.hpapi-log/hpapi-build.log
echo "Last response log:  $(pwd)/.hpapi-log/hpapi-last-output.log"  >> ./.hpapi-log/hpapi-build.log
echo "Document root:      $(pwd)/whitelamp-uk/hpapi-server"         >> ./.hpapi-log/hpapi-build.log
echo ""                                                             >> ./.hpapi-log/hpapi-build.log
echo "Configuration:"                                               >> ./.hpapi-log/hpapi-build.log
find .hpapi-config -type f -iname '*'                               >> ./.hpapi-log/hpapi-build.log
echo ""                                                             >> ./.hpapi-log/hpapi-build.log
echo "Config examples:"                                             >> ./.hpapi-log/hpapi-build.log
find . -type f -iname '*.EXAMPLE'                                   >> ./.hpapi-log/hpapi-build.log
echo ""                                                             >> ./.hpapi-log/hpapi-build.log
cat ./.hpapi-log/hpapi-build.log

