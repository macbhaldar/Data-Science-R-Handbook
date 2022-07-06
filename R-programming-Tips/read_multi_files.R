# Reading Multiple Files

library(tidyverse)
library(fs)

file_paths <- fs::dir_ls("data")
file_paths

file_contents <- list()

for (i in seq_along(file_paths)) {
  file_contents[[i]] <- read_csv(
    file = file_paths[[i]]
  )
}

file_contents <- set_names(file_contents, file_paths)

file_paths %>%
  map(function (path) {
    read_csv(path)
  })
