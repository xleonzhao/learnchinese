#!/usr/bin/env bash

Usage() {
  echo "Usage: $0 <words id list>"
  echo " e.g.: $0 2017-09-11.list"
  echo
  exit
}

list=$1
if [ -z "$list" -o ! -f "$list" ]; then
  Usage
fi

echo hi
