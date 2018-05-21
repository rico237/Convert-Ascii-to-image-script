#!/bin/bash
FILE=$1
if [ -f "$FILE" ]; then
    echo "File $1 exists"
else 
    echo "File $1 does not exist"
fi 
