#!/bin/bash

topdir="$PWD"
for workspace in $(find -name GT-PAGE -type d)
do
    # chdir to workspace
    pushd $(dirname "$workspace")
    name=$(basename "$PWD")
    if test -f "mets.xml"; then
        ocrd zip bag -i ocrd_data_structur_$name
        sudo mv $workspace.ocrd.zip "$topdir"/ocrdzip_out/
    else
        ocrd workspace init
        sh "$topdir"/ghout/mets.sh
        sudo mkdir "$topdir"/ghout/$name
        sudo mv mets.xml $path/ghout/$name/
    fi
done


