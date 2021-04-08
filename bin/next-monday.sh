#!/usr/bin/env bash

Usage() {
  echo "Usage: $0 <date>"
  echo " e.g.: $0 20170903"
  echo
  exit
}

date=$1
if [ -z $date ]; then
  date=`date +%Y%m%d`
fi

next_monday() {
  local yi=${1:0:4} mi=${1:4:2} di=${1:6:2}
  mi=${mi#0}
  di=${di#0}
  local yo=$yi mo=$mi do
  do=$(cal -M -m $mi $yi | awk 'c==1 {print $1; exit} NR>2 && /'"$di"'/ {c++}')
  echo $di, $do
  if [ "X$do" = X ];then
    ((mo=mi+1))
    if ((mo>12)); then
      ((mo=1, yo=yi+1))
    fi
    do=$(cal -M -m $mo $yo | awk 'NR>2 && !/^  /{print $1; exit}')
  fi
  printf "%04d-%02d-%02d\n" $yo $mo $do
}

next_monday $date
