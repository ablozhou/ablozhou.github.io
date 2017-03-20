#!/bin/bash

sed  '{
    s/`\$/\$/g 
    s/\$`/\$/g 
    s/```math/\$\$/g
    s/```/\$\$/g
    }' $1 
