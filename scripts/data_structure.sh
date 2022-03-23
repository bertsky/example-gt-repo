#!/bin/bash
path="$(find -name "mets.xml" -execdir pwd \; -quit)"
metsfiles=`ls data/`
for eachfile in $metsfiles
do
   
   echo "cd /home/runner/work/example-gt-repo/example-gt-repo/data/$eachfile;ocrd zip bag -i ocrd_data_structur_$eachfile;sudo mv /home/runner/work/example-gt-repo/example-gt-repo/data/*.zip /home/runner/work/example-gt-repo/example-gt-repo/ocrdzip_out/"
   
   
   
done
