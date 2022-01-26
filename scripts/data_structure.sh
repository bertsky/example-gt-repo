#!/bin/bash
metsfiles=`ls data_structure/`
for eachfile in $metsfiles
do
   cd /home/runner/work/example-gt-repo/example-gt-repo/data_structure/$eachfile;ocrd zip bag -i ocrd_data_structur_$eachfile;sudo mv /home/runner/work/example-gt-repo/example-gt-repo/data_structure/*.zip /home/runner/work/example-gt-repo/example-gt-repo/ocrdzip_out/
   
   
   
done