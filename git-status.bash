
# Find all git packages in a directory and report status

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
    echo "$(pwd): git status"
    git status
    cd "$wd"
done

