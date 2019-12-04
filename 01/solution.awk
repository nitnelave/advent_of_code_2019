# Awk is a line processing language. We will run some code for each line of the input.


# Run this block at the beginning, to initialize variables.
# This is not strictly necessary, since variables default to 0.
BEGIN {
  # Fuel for the modules, for part 1.
  FUEL=0
  # Fuel for the modules and the fuel, for part 2.
  FUEL2=0
}

# Run this block for each line
{
  # The weight of the module is the entire line, since each line is just a number.
  WEIGHT=$0
  FUEL_FOR_WEIGHT=int(WEIGHT / 3) - 2
  FUEL += FUEL_FOR_WEIGHT
  # Now compute the fuel for the fuel.
  while (FUEL_FOR_WEIGHT > 0) {
    FUEL2 += FUEL_FOR_WEIGHT
    FUEL_FOR_WEIGHT=int(FUEL_FOR_WEIGHT / 3) - 2
  }
}

# Once at the end of the file, print the results.
END {
  print FUEL
  print FUEL2
}
