#!/bin/bash
function linkfile() {
    local SOURCE=$1
    local DEST=$2
    local SUDO=$3
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    if (( $SUDO ))
    then
	sudo rm $DEST
	sudo ln -s $DIR/$SOURCE $DEST
    else
	rm $DEST
	ln -s $DIR/$SOURCE $DEST
    fi
}

linkfile emacs/emacs.el ~/.emacs      0
linkfile git/gitconfig ~/.gitconfig  0




