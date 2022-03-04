#!/bin/bash
repN = ${{ github.repository.name}} 


   sudo java -jar saxon-he-10.5.jar -xsl:scripts/gt-overview_metadata.xsl output=METADATA repoName=$repN -s:scripts/gt-overview_metadata.xsl -o:ghout/metadata.md



