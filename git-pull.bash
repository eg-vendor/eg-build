
# Find all git packages in a directory and pull them

if [ ! "$1" ]
then
    echo "First argument is target directory"
    exit
fi

if [ ! -d "$1" ]
then
    echo "$1 is not a directory"
    exit
fi

wd="$(pwd)"

for git in $(find "$1/" -iname .git)
do
    cd "$(dirname $git)"
    echo "$(pwd): git pull"
    git pull
    cd "$wd"
done

