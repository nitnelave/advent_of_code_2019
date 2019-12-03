#! /bin/sh

# POSIX shell compliant
# Place your input in "input.txt"

FILE=input.txt

trace () {
  INPUT=$1
  OUTPUT=$2
  OUTPUT_STEP=$3
  rm -f $OUTPUT
  rm -f $OUTPUT_STEP
  X=0
  Y=0
  STEP=0
  IFS=,
  for i in $INPUT
  do
    DIR=$(expr substr "$i" 1 1)
    LEN=$(expr length "$i")
    LEN=$((LEN - 1))
    MAX=$(expr substr "$i" 2 $LEN )
    unset IFS
    for j in $(seq $MAX)
    do
      STEP=$((STEP+1))
      case $DIR in
        "D") Y=$((Y - 1));;
        "U") Y=$((Y + 1));;
        "L") X=$((X - 1));;
        "R") X=$((X + 1));;
        *) echo "error: $i";;
      esac
      echo "$X/$Y" >> $OUTPUT
      echo "$X/$Y/$STEP" >> $OUTPUT_STEP
    done
  done
}

trace "$(head -n 1 $FILE)" out1.txt out1_step.txt
trace "$(tail -n 1 $FILE)" out2.txt out2_step.txt
sort out1.txt | uniq > out1_uniq.txt
sort out2.txt | uniq > out2_uniq.txt
cat out1_uniq.txt out2_uniq.txt | sort | uniq -d > intersections.txt

rm -f distance.txt
rm -f signal_distance.txt
for point in $(cat intersections.txt)
do
  abs_point=$(echo $point | tr -d -)
  X=$(dirname $abs_point)
  Y=$(basename $abs_point)
  echo "$((X+Y)): $X,$Y" >> distance.txt
  STEP1=$(basename $(grep -E "^$point/" out1_step.txt))
  STEP2=$(basename $(grep -E "^$point/" out2_step.txt))
  echo "$((STEP1+STEP2)): $X,$Y" >> signal_distance.txt
done

sort -n distance.txt | head -n1
sort -n signal_distance.txt | head -n1
