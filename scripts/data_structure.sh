#!/bin/bash
metsfiles=`ls data/`
page=`find -name 'GT-PAGE'`
path=`pwd`


for eachfile in $page
do
cd $path/$eachfile;cd ..
p=`pwd`
if test -f "mets.xml"; then
    cd $p;pwd;ls -l;ocrd zip bag -i ocrd_data_structur_${PWD##*/} -d $p -I;pwd;ls
    
    # ocrd zip bag -i ocrd_data_structur_${PWD##*/};pwd;ls -l;cd ${PWD##*/};pwd;ls -l;
    # sudo mv $path/data/*.zip $path/ocrdzip_out/
    

else
    ocrd workspace --directory $p init;sh $path/ghout/mets.sh;cd $p;ocrd zip bag -i ocrd_data_structur_${PWD##*/};pwd;ls -l
    # cd ${PWD##*/};sudo mv $path/data/*.zip $path/ocrdzip_out/
    # sudo mkdir $path/ghout/${PWD##*/};sudo mv mets.xml $path/ghout/${PWD##*/}/
fi
done
