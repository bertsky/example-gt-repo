#!/bin/bash
metsfiles=`ls data/`
path=`pwd`

for eachfile in $metsfiles
do
cd $path/data/$eachfile

if test -f "mets.xml"; then
    cd $path/data/$eachfile;ocrd zip bag -i ocrd_data_structur_$eachfile;sudo mv $path/data/*.zip $path/ocrdzip_out/

else
 
    cd $path/data/$eachfile;ocrd workspace init $eachfile;sudo mkdir ghout/$eachfile;sudo mv $path/data/$eachfile/mets.xml ghout/$eachfile/ 
    
fi
done





