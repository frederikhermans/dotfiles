#!/bin/bash

backup() {

    BACKUP="$1~"

    if [ -f $1 ]
    then
        BACKUP="$1~"
        SUFFIX=1
        while [ -f $BACKUP ]
        do
            BACKUP="$1~.$SUFFIX"
            let SUFFIX=SUFFIX+1
        done

        mv -v $1 $BACKUP
    fi
}

for FILE in .vimrc .vim .gitconfig
do
    if [ -L $HOME/$FILE ] && [ "`readlink $HOME/$FILE`" == "$PWD/$FILE" ]
    then
        echo $FILE already points to $PWD/$FILE
    else
        backup $HOME/$FILE
        ln -vs $PWD/$FILE $HOME/$FILE
    fi
done

