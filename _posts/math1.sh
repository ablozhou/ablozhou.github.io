#!/bin/bash
# using ./math1.sh 2017-04-19-pca.md
sed -i ".bak"  '{
    s/\\(/\$/g 
    s/\\)/\$/g 
    s/\\\[/\$\$/g
    s/\\\]/\$\$/g
    s/&amp;/\ /g
    }' $1 
