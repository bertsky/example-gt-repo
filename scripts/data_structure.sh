#!/bin/bash
path=`pwd`
metsfiles=`ls data/`
for eachfile in $metsfiles
do
   cd $path/data/$eachfile;ocrd zip bag -i ocrd_data_structur_$eachfile;sudo mv $path/data/*.zip $path/ocrdzip_out/
   
   
   
done