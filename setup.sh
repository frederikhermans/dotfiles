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

mkdir -p $HOME/.ipython
if [ -L $HOME/.ipython/profile_marsta ] && [ "`readlink $HOME/.ipython/profile_marsta`" == "$PWD/profile_marsta" ]
then
    echo profile_marsta already installed.
else
    backup $HOME/.ipython/profile_marsta
    ln -vs $PWD/profile_marsta $HOME/.ipython/profile_marsta
fi
