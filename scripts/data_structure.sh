#!/bin/bash
metsfiles=`ls data/`
page=`find -name 'GT-PAGE'`
path=`pwd`


for eachfile in $page
do
cd $path/$eachfile;cd ..
p=`pwd`
if test -f "mets.xml"; then
    cd $p;ocrd zip bag -i ocrd_data_structur_${PWD##*/};cd ${PWD##*/};mv $path/data/*.zip $path/ocrdzip_out/
    

else
    p2 cd $p;cd.. 
    echo erster: $path/$eachfile
    echo zweiter: $p
    echo $path
    
    # ocrd workspace --directory $p init;sh $path/ghout/mets.sh;cd $p;ocrd zip bag -i ocrd_data_structur_${PWD##*/};sudo mv *.zip $path/ocrdzip_out/
    
    # pwd;ls -l
    
    # mv $path/data/*.zip $path/ocrdzip_out/
    
    # mkdir $path/ghout/${PWD##*/};sudo mv mets.xml $path/ghout/${PWD##*/}/
fi
done


