#!/bin/bash
metsfiles=`ls data/`
page=`find -name 'GT-PAGE'`
path=`pwd`


for eachfile in $page
do
cd $path/$eachfile;cd ..
p=`pwd`
if test -f "mets.xml"; then
    cd $p;ocrd zip bag -i ocrd_data_structur_${PWD##*/};cd ${PWD##*/};sudo mv $path/data/*.zip $path/ocrdzip_out/
    

else
    echo "${PWD##*/}"
    echo "cd $p;"
    # cd $p;cd ..;ocrd workspace -d ${PWD##*/} init ;cd ${PWD##*/};pwd;ls;sh $path/ghout/mets.sh;sudo mkdir $path/ghout/${PWD##*/};sudo mv mets.xml $path/ghout/${PWD##*/}/
    
fi
done
