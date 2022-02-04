library(tidyverse)
library(magrittr)

# Create roxygen-style data documentation from schema file
schema <- read_rds(here::here("data-raw", "schema.rds"))

schema %>%
  unnest(PROPERTIES) %>%
  transmute(
    TABLE,
    DOC = glue::glue("#'   \\item{\\code{<<VARIABLE>>}}{<<DESCRIPTION>>}", .open = "<<", .close = ">>")
  ) %>%
  nest(DOC_TXT = c(DOC)) %>%
  walk2(
    .x = .$DOC_TXT,
    .y = .$TABLE,
    .f = ~write_csv(.x, file = here::here("data-raw", str_c("doc_", .y, ".csv")))
  )
