# Read the file, and convert to a vector.
data_file = unlist(c(read.table("input.txt", sep=",")))

# Loop over all possible inputs.
for (first in seq(0, 99)) {
  for (second in seq(0, 99)) {
    # Copy the base state, then update with the input.
    data_raw <- data_file
    data_raw[2] <- first
    data_raw[3] <- second

    # Indices of the operations, 0-based (i.e. [0, 4, 8, ...]).
    op = seq(0, length(data_raw)-1, by=4)

    # Add the cells at (0-based) index i1 and i2 into the one at d.
    add <- function(i1, i2, d) {
      set_data(d, data(i1) + data(i2))
    }

    # Same for multiplication.
    mul <- function(i1, i2, d) {
      set_data(d, data(i1) * data(i2))
    }

    # Read the data, offsetting the index to turn it into 1-based.
    data <- function(i) {
      data_raw[i+1]
    }

    # Write to the data, offsetting the index to turn it into 1-based.
    set_data <- function(i, v) {
      data_raw[i+1] <<- v
    }

    # Iterate over all the operations, executing them as we go.
    # 1: add
    # 2: mul
    # 99: stop
    for (i in op) {
      if (data(i) == 1) {
        add(data(i+1), data(i+2), data(i+3))
      } else if (data(i) == 2) {
        mul(data(i+1), data(i+2), data(i+3))
      } else if (data(i) == 99) {
        break
      } else {
        print("Error")
        break
      }
    }

    # The first problem gives us the input [12, 2] and asks for the result.
    if (first == 12 && second == 2) {
      print(data_raw[1])
    }
    # The second problem gives us the answer 19690720 and asks for the correct input.
    if (data_raw[1] == 19690720) {
      cat(first, ", ", second, "\n")
    }
  }
}
