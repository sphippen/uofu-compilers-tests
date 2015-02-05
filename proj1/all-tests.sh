#!/bin/sh

if [ $# -ne 2 ] ; then
  printf -- "Usage: $0 <binary> <outdatadirectory>\nOutput data is written to <outdatadirectory>.\n"
  exit 1
fi

BIN=$1
DIR=$2

total=0
success=0
for f in ./tests/*.py; do
  total="$(echo "$total+1" | bc)"
  ./test.sh "$BIN" "$DIR" "$f"
  if [ $? -eq 0 ] ; then
    success="$(echo "$success+1" | bc)"
  fi
done
printf -- "\n%s/%s TESTS PASSED\n" "$success" "$total"
