#!/usr/bin/env bash

. ~/etc/chinese4kids.conf

Usage() {
  echo "Usage: $0 <list>"
  echo " e.g.: $0 2017-08-28.list"
  echo
  exit
}

file=$1

if [ -z "$file" -o ! -f "$file" ]; then
  echo "No list file"
  Usage
fi

for i in `less $file`; do
  cat $FCDIR/$i.txt
done
