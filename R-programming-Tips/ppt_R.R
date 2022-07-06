# Automate PowerPoint Slide Decks with R

library(officer)
library(flextable)
library(tidyverse)
library(tidyquant)
library(timetk)

# Use tidyquant to pull in some stock data

stock_data_tbl <- c("AAPL", "GOOG", "FB", "NVDA") %>%
  tq_get(from = "2019-01-01", to = "2020-08-31")


# DATA WRANGLING

stock_returns_tbl <- stock_data_tbl %>%
  select(symbol, date, adjusted) %>%
  group_by(symbol) %>%
  summarise(
    week    = last(adjusted) / first(tail(adjusted, 7)) - 1,
    month   = last(adjusted) / first(tail(adjusted, 30)) - 1,
    quarter = last(adjusted) / first(tail(adjusted, 90)) - 1,
    year    = last(adjusted) / first(tail(adjusted, 365)) - 1,
    all     = last(adjusted) / first(adjusted) - 1
  )

# PLOTS & TABLES

# Stock Plot
stock_plot <- stock_data_tbl %>%
  group_by(symbol) %>%
  summarize_by_time(adjusted = AVERAGE(adjusted), .by = "week") %>%
  plot_time_series(date, adjusted, .facet_ncol = 2, .interactive = FALSE)

stock_plot

# Stock Return Table
stock_table <- stock_returns_tbl %>%
  rename_all(.funs = str_to_sentence) %>%
  mutate_if(is.numeric, .funs = scales::percent) %>%
  flextable::flextable()

stock_table


# MAKE A POWERPOINT DECK

doc <- read_pptx()
doc <- add_slide(doc)
doc <- ph_with(doc, value = "Stock Report", location = ph_location_type(type = "title"))
doc <- ph_with(doc, value = stock_table, location = ph_location_left())
doc <- ph_with(doc, value = stock_plot, location = ph_location_right())

print(doc, target = "data/stock_report.pptx")
