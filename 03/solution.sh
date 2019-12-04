#! /bin/sh

# POSIX shell compliant
# Place your input in "input.txt"

FILE=input.txt

# This function will "trace" a wire, by printing all of the coordinates the
# wires goes through in $OUTPUT, along with at what step they were reached in
# $OUTPUT_STEP
trace () {
  INPUT=$1
  OUTPUT=$2
  OUTPUT_STEP=$3
  rm -f $OUTPUT
  rm -f $OUTPUT_STEP
  X=0
  Y=0
  STEP=0
  # Separate the input on the commas.
  IFS=,
  # i will take values "R18", "L4", and so on.
  for i in $INPUT
  do
    # Direction is the first character.
    DIR=$(expr substr "$i" 1 1)
    LEN=$(expr length "$i")
    LEN=$((LEN - 1))
    # The max steps in this direction is the rest.
    MAX=$(expr substr "$i" 2 $LEN )
    unset IFS
    # j = 0, 1, ..., max-1
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
      # Print like a path, to be able to use dirname/basename.
      echo "$X/$Y" >> $OUTPUT
      echo "$X/$Y/$STEP" >> $OUTPUT_STEP
    done
  done
}

# Trace the first line of the file (the first wire).
trace "$(head -n 1 $FILE)" out1.txt out1_step.txt
# Trace the last line of the file (the second wire).
trace "$(tail -n 1 $FILE)" out2.txt out2_step.txt
# Deduplicate the coordinates, in case a wire crossed itself.
sort out1.txt | uniq > out1_uniq.txt
sort out2.txt | uniq > out2_uniq.txt
# Find the intersections, i.e. the coordinates in both files, i.e. the lines
# that are repeated after joining the files.
cat out1_uniq.txt out2_uniq.txt | sort | uniq -d > intersections.txt

rm -f distance.txt
rm -f signal_distance.txt
for point in $(cat intersections.txt)
do
  # Remove the '-' signs for the manhattan distance.
  abs_point=$(echo $point | tr -d -)
  # Here's where it's useful to have it as "X/Y", reading it as a path.
  X=$(dirname $abs_point)
  Y=$(basename $abs_point)
  # We write the distance and the coordinates to the file.
  echo "$((X+Y)): $X,$Y" >> distance.txt
  # We find the first time the wire reached the intersection by searching in
  # the file the first line with the coordinates. The last part of the "path" is
  # the step number.
  STEP1=$(basename $(grep -E "^$point/" out1_step.txt))
  STEP2=$(basename $(grep -E "^$point/" out2_step.txt))
  # We write the sum of the steps and the coordinates to the file.
  echo "$((STEP1+STEP2)): $X,$Y" >> signal_distance.txt
done


# Find the smallest distance (sort by number then take the first line).
sort -n distance.txt | head -n1
# Find the smallest sum of steps.
sort -n signal_distance.txt | head -n1
