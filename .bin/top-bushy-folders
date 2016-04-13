#!/bin/bash

if [ $# -ne 1 ];then
  echo "Usage: `basename $0` DIRECTORY"
  exit 1
fi

echo "Wait a moment if you want a good top of the bushy folders..."

find "$@" -type d -print0 2>/dev/null | while IFS= read -r -d '' file; do 
    echo -e `ls -A "$file" 2>/dev/null | wc -l` "files in:\t $file"
done | sort -nr | head | awk '{print NR".", "\t", $0}'

exit 0
