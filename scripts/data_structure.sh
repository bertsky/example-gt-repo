#!/bin/bash
metsfiles=`ls data/`
page=`find -name 'GT-PAGE'`
path=`pwd`

for eachfile in $page
do
cd $path/$eachfile;cd ..
p=`pwd`
if test -f "mets.xml"; then
    cd $path/$eachfile;cd ..;ocrd zip bag -i ocrd_data_structur_${PWD##*/};sudo mv $path/data/*.zip $path/ocrdzip_out/
    

else
 
    cd $path/$eachfile;cd ..;ocrd workspace init ${PWD##*/};sudo mkdir $path/ghout/${PWD##*/};sudo mv $p/mets.xml $path/ghout/${PWD##*/}/
    
fi
done