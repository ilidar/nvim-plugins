#!/usr/bin/env bash

set -e

SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR_PATH=$(dirname "$SCRIPT_PATH")
REPO_DIR_PATH=$(realpath "$SCRIPT_DIR_PATH/..")

delete_existing_link()
{
    if [ -L ${1} ] ; then
        if [ -e ${1} ] ; then
            rm $1
        fi
    fi
}

link_config_dir()
{
    DIR_PATH="$REPO_DIR_PATH/$1"
    DIR_LINK_PATH="$HOME/.local/share/nvim/site/pack/plugins/$1"

    echo "Linking dir $DIR_PATH to $DIR_LINK_PATH"

    delete_existing_link $DIR_LINK_PATH
    ln -s -f "$DIR_PATH" "$DIR_LINK_PATH"
}

plugins_init()
{
    mkdir -p $HOME/.local/share/nvim/site/pack/plugins

    link_config_dir opt
    link_config_dir start
}

plugins_setup()
{
    nvim --headless -c 'TSInstallSync all' -c 'qall'
}

plugins_init
plugins_setup

