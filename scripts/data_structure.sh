#!/bin/bash
metsfiles=`ls data/`
path=`pwd`

for eachfile in $metsfiles
do
cd $path/data/$eachfile

if test -f "mets.xml"; then
    cd $path/data/$eachfile;ocrd zip bag -i ocrd_data_structur_$eachfile;sudo mv $path/data/*.zip $path/ocrdzip_out/

else
 
    echo "sh mets.sh"

fi



   
   
   
   
done





