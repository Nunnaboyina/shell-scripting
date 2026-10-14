#!/bin/bash

echo "Please enter marks"
read  marks

if [ marks -lt 30 ]; then 
    echo "Fail"
elif [ marks -lt 40 ]; then 
    echo "Pass"
elif [ marks -lt 60 ]; then 
    echo "Second class"
elif [ marks -lt 80 ]; then 
    echo "First class"
elif [ marks -lt 100 ]; then 
    echo "Distinction"
fi