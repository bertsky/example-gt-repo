#!/bin/bash
metsfiles=`ls data_structure/raw/`
for eachfile in $metsfiles
do
   # echo cd ../data_structure/raw/$eachfile; ocrd zip bag -i ocrd_data_structur_$eachfile;sudo mv /home/runner/work/example-gt-repo/example-gt-repo/data_structure/raw/$eachfile/*.zip /home/runner/work/example-gt-repo/example-gt-repo/ocrdzip_out/
   echo cd /home/runner/work/example-gt-repo/example-gt-repo/data_structure/raw/$eachfile;ls /home/runner/work/example-gt-repo/example-gt-repo/data_structure/raw/$eachfile
done