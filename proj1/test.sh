#!/bin/sh

if [ $# -ne 2 ] ; then
  printf -- "Usage: $0 <binary> <outdatadirectory>\nOutput data is written to <outdatadirectory>.\n"
  exit 1
fi

BIN=$1
DIR=$2

if [ ! -d "$DIR" ] ; then
  mkdir "$DIR"
fi

total=0
success=0
for f in ./tests/*.py; do
  total="$(echo "$total+1" | bc)"
  expectedout="${f%.py}.out"
  base="$(basename -- "$f")"
  if [ -f "$expectedout" ] ; then
    outfile="./$DIR/${base%.py}.out"
    "$BIN" "$f" > "$outfile"
    diffout="${outfile%.out}.diff"
    diff -- "$outfile" "$expectedout" > "$diffout"
    if [ $? -ne 0 ] ; then
      printf -- "\n%s: FAILED (diff shown below):\n" "$base"
      cat -- "$diffout"
    else
      printf -- "\n%s: PASSED\n" "$base"
      success="$(echo "$success+1" | bc)"
    fi
  else
    "$BIN" "$f" > /dev/null
    if [ $? -eq 0 ] ; then
      printf -- "\n%s: FAILED (should have errored)\n" "$base"
    else
      printf -- "\n%s: PASSED\n" "$base"
      success="$(echo "$success+1" | bc)"
    fi
  fi
done
printf -- "\n%s/%s TESTS PASSED\n" "$success" "$total"
