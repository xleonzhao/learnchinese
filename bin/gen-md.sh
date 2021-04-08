#!/usr/bin/env bash

. ~/etc/chinese4kids.conf

SEL="$BASEDIR/select"
BIN="$BASEDIR/bin"

current="2017-09-25"
start=$current

gen_md_files=$1

gen_init_md() {
  cd $BASEDIR/www
  for((i=1; i<=5; i++)) {
    if [ -f content/posts/$start-text.md ]; then
      rm -rf content/posts/$start-text.md
    fi
    $HUGO new posts/$start-text.md
    start=`$BIN/next-day.pl $start`
  }
}

if [ ! -z "$gen_md_files" ]; then
  gen_init_md
fi

cd $SEL/$current

TWW="$current.final.list"
total0=`wc -l $TWW | cut -f 1 -d ' '`
avg0=`expr $total0 \/ 5 + 1`

LWW='repeated-words.list'
total1=`wc -l $LWW | cut -f 1 -d ' '`
avg1=`expr $total1 \/ 5 + 1`

start=$current
tmpfile="tmp.md"

for((i=0; i<5; i++)) {
  echo $i

  s0=`expr $avg0 \* $i`; 
  from0=`expr $total0 - $s0`; 
  thisweek=`less $TWW | tail -n $from0 | head -n $avg0`; 
  echo $s0,$from0,$thisweek; 

  echo > $tmpfile
  for w in `echo $thisweek`; do
    echo -n " <span style='color:red'>**$w**</span> "
  done >> $tmpfile

  echo >> $tmpfile
  echo >> $tmpfile

  s1=`expr $avg1 \* $i`; 
  from1=`expr $total1 - $s1`; 
  lastweek=`less $LWW | tail -n $from1 | head -n $avg1`; 
  echo $s0,$from0,$lastweek; 

  c=0
  for w in `echo $lastweek`; do
    echo -n " **$w** " 
    c=`expr $c + 1`
    m=`expr $c % 10`
    if [ $m -le 0 ]; then
      echo
    fi
  done >> $tmpfile
  echo >> $tmpfile

  if [ ! -z "$gen_md_files" ]; then
    cat $tmpfile >> $BASEDIR/www/content/posts/$start-text.md
  else
    cat $tmpfile
  fi
  start=`$BIN/next-day.pl $start`
}
 
