#!/bin/bash

sed -i ".bak"  $'{
    s/`\$/\$/g 
    s/\$`/\$/g 
    s/```math/\\\n\$\$/g
    s/```/\$\$\\\n/g
    }' $1 
