#!/bin/sh

if [ $# -ne 3 ] ; then
  printf -- "Usage: $0 <binary> <outdatadirectory> <testfile>\nOutput data is written to <outdatadirectory>.\n"
  exit 1
fi

BIN=$1
DIR=$2
TESTFILE=$3

if [ ! -f "$TESTFILE" ] ; then
  checkintests="./tests/$TESTFILE"
  if [ ! -f "$checkintests" ] ; then
    printf -- "\n%s: FAILED (couldn't find input file)\n" "$TESTFILE"
    exit 1
  else
    TESTFILE="$checkintests"
  fi
fi

if [ ! -d "$DIR" ] ; then
  mkdir "$DIR"
fi

expectedout="${TESTFILE%.py}.out"
base="$(basename -- "$TESTFILE")"
if [ -f "$expectedout" ] ; then
  outfile="./$DIR/${base%.py}.out"
  "$BIN" "$TESTFILE" > "$outfile"
  diffout="${outfile%.out}.diff"
  diff -- "$outfile" "$expectedout" > "$diffout"
  if [ $? -ne 0 ] ; then
    printf -- "\n%s: FAILED (diff shown below):\n" "$base"
    cat -- "$diffout"
    exit 1
  else
    printf -- "\n%s: PASSED\n" "$base"
    exit 0
  fi
else
  "$BIN" "$TESTFILE" > /dev/null
  if [ $? -eq 0 ] ; then
    printf -- "\n%s: FAILED (should have errored)\n" "$base"
    exit 1
  else
    printf -- "\n%s: PASSED\n" "$base"
    exit 0
  fi
fi
