#!/bin/bash

VERSION=0.4.5
set -e

# Functions
function npm_error(){
    echo 'You need to install Node before we can continue (http://nodejs.org/)'
    exit 1
}

# Let's go
echo $'\n'cracklistr $VERSION
echo ================

if [[ -d 'node_modules/apache-server-configs/dist' && -d 'node_modules/bootstrap' && -d 'node_modules/bootswatch' && -d 'node_modules/font-awesome' && -d 'node_modules/_bower_components/highlightjs' && -d 'node_modules/jquery' && -d 'node_modules/jquery-searcher' && -d 'node_modules/_bower_components/m8tro-bootstrap' && -d 'node_modules/_bower_components/stupid-jquery-table-sort' ]]
then
    echo "Node modules found"
else
    echo 'Missing Node modules, downloading'
    npm install || npm_error
fi

if [ -e 'dist/config.json' ]
then
    # upgrade codebase only
    echo $'Updating codebase'
    gulp upgrade --silent
else
    # clean up dist-folder, copy files
    echo $'Initializing application'
    gulp init --silent
fi

# set dependencies source
gulp setup --silent

gulp merge --silent

echo $'\nGame over!'