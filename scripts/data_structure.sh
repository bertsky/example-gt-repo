#!/bin/bash

topdir="$PWD"
for workspace in $(find -name GT-PAGE -type d)
do
    # chdir to workspace
    pushd "$workspace"/..
    name=$(basename "$PWD")
    if $name = data; then
        name=$(basename $(dirname "$PWD"))
    fi
    if test -f "mets.xml"; then
        ocrd zip bag -i ocrd_data_structur_$name
        mv $PWD.ocrd.zip "$topdir"/ocrdzip_out/
    else
        ocrd workspace init
        sh "$topdir"/ghout/mets.sh
        mkdir "$topdir"/ghout/$name
        mv mets.xml "$topdir"/ghout/$name/
        # and zip?
    fi
    popd
done


