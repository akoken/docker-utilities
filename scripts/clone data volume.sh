
if [ "$1" = "" ]
then
        echo "Provide a source volume name"
        exit
fi

if [ "$2" = "" ] 
then
        echo "Provide a destination volume name"
        exit
fi

docker volume inspect $1 > /dev/null 2>&1
if [ "$?" != "0" ]
then
        echo "The source volume \"$1\" does not exist"
        exit
fi

docker volume inspect $2 > /dev/null 2>&1

if [ "$?" = "0" ]
then
        echo "The destination volume \"$2\" already exists"
        exit
fi



echo "Creating destination volume \"$2\"..."
docker volume create --name $2  
echo "Copying data from source volume \"$1\" to destination volume \"$2\"..."
echo docker run --rm \
                -i \
                -t \
                -v $2:/from \
                -v $1:/to \
                alpine ash -c "cd /to ; cp -a /from/* ."