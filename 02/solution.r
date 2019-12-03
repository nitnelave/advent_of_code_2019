data_file = unlist(c(read.table("input.txt", sep=",")))


for (first in seq(0, 99)) {
  for (second in seq(0, 99)) {
    data_raw <- data_file
    data_raw[2] <- first
    data_raw[3] <- second

    op = seq(0, length(data_raw)-1, by=4)

    add <- function(i1, i2, d) {
      set_data(d, data(i1) + data(i2))
    }

    mul <- function(i1, i2, d) {
      set_data(d, data(i1) * data(i2))
    }

    data_raw

    data <- function(i) {
      data_raw[i+1]
    }

    set_data <- function(i, v) {
      data_raw[i+1] <<- v
    }

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

    if (first == 12 && second == 2) {
      print(data_raw[1])
    }
    if (data_raw[1] == 19690720) {
      cat(first, ", ", second, "\n")
    }
  }
}
