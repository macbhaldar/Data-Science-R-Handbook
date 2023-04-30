library(sparkline)

#-------------------
# Create Value_DB
#-------------------

# aggregation
tab_scan <- blueprint %>% select(DFU, Demand, Opening.Inventories, Supply.Plan,
                                 Min.Stocks.Coverage,
                                 Max.Stocks.Coverage) %>%
  group_by(DFU) %>%
  summarise(Total.Demand = sum(Demand),
            Opening.Inventories = sum(Opening.Inventories),
            Supply.Plan = sum(Supply.Plan),
            Min.Stocks.Coverage = mean(Min.Stocks.Coverage),
            Max.Stocks.Coverage = mean(Max.Stocks.Coverage)
  )

# Get results
Value_DB <- tab_scan

#-------------------
# Create Sparklines for Demand
#-------------------

# replace missing values by zero
blueprint$Demand[is.na(blueprint$Demand)] <- 0

# aggregate
tab_scan <- blueprint %>%
  group_by(DFU,
           Period) %>%
  summarise(Quantity = sum(Demand))

# generate Sparkline
Sparkline_Demand_DB <- tab_scan %>%
  group_by(DFU) %>%
  summarise(Demand.Quantity = list(Quantity))

#-------------------
# Create Sparklines for Supply Plan
#-------------------

# replace missing values by zero
blueprint$Supply.Plan[is.na(blueprint$Supply.Plan)] <- 0

# aggregate
tab_scan <- blueprint %>%
  group_by(DFU,
           Period) %>%
  summarise(Quantity = sum(Supply.Plan))

# generate Sparkline
Sparkline_Supply_DB <- tab_scan %>%
  group_by(DFU) %>%
  summarise(Supply.Quantity = list(Quantity))

#----------------------------------------
# Link both databases
tab_scan <- left_join(Value_DB, Sparkline_Demand_DB)
tab_scan <- left_join(tab_scan, Sparkline_Supply_DB)

# Get Results
Overview_DB <- tab_scan

reactable(
  tab_scan,
  compact = TRUE,
  defaultSortOrder = "asc",
  defaultSorted = c("DFU"),
  defaultPageSize = 20,
  columns = list(
    `DFU` = colDef(name = "Item", minWidth = 150),
    `Opening.Inventories` = colDef(
      name = "Opening Inventories (units)",
      aggregate = "sum",
      footer = function(values)
        formatC(
          sum(values),
          format = "f",
          big.mark = ",",
          digits = 0
        ),
      format = colFormat(separators = TRUE, digits = 0)
      #style = list(background = "yellow",fontWeight = "bold")
    ),
    `Total.Demand` = colDef(
      name = "Total Demand (units)",
      aggregate = "sum",
      footer = function(values)
        formatC(
          sum(values),
          format = "f",
          big.mark = ",",
          digits = 0
        ),
      format = colFormat(separators = TRUE, digits = 0),
      style = list(background = "yellow", fontWeight = "bold")
    ),
    `Supply.Plan` = colDef(
      name = "Supply Plan (units)",
      aggregate = "sum",
      footer = function(values)
        formatC(
          sum(values),
          format = "f",
          big.mark = ",",
          digits = 0
        ),
      format = colFormat(separators = TRUE, digits = 0)
    ),
    `Min.Stocks.Coverage` = colDef(
      name = "Min Stocks Coverage (periods)",
      
      cell = data_bars(tab_scan,
                       #round_edges = TRUE
                       #value <- format(value, big.mark = ","),
                       #number_fmt = big.mark = ",",
                       fill_color = "#32CD32",
                       #fill_opacity = 0.8,
                       text_position = "outside-end")
    ),
    `Max.Stocks.Coverage` = colDef(
      name = "Max Stocks Coverage (periods)",
      cell = data_bars(tab_scan,
                       #round_edges = TRUE
                       #value <- format(value, big.mark = ","),
                       #number_fmt = big.mark = ",",
                       fill_color = "#FFA500",
                       #fill_opacity = 0.8,
                       text_position = "outside-end")
    ),
    Demand.Quantity = colDef(
      name = "Demand",
      cell = function(value, index) {
        sparkline(tab_scan$Demand.Quantity[[index]])
      }
    ),
    Supply.Quantity = colDef(
      name = "Supply",
      cell = function(values) {
        sparkline(values, type = "bar")
      }
    )
  ),
  # close columns list
  
  defaultColDef = colDef(footerStyle = list(fontWeight = "bold")),
  columnGroups = list(
    colGroup(
      name = "Demand & Supply Inputs",
      columns = c("Total.Demand", "Opening.Inventories", "Supply.Plan")
    ),
    colGroup(
      name = "Stocks Targets Parameters",
      columns = c("Min.Stocks.Coverage", "Max.Stocks.Coverage")
    )
  )
) # close reactable