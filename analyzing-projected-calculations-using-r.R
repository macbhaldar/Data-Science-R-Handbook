library(tidyr)
library(dplyr)
library(stringr)
library(lubridate)
## 
## Attaching package: 'lubridate'
## The following objects are masked from 'package:base':
## 
##     date, intersect, setdiff, union

library(devtools)
install_github("nguyennico/planr")

library(planr)
library(ggplot2)

Blueprint_DB <- planr::blueprint
glimpse(Blueprint_DB)
## Rows: 520
## Columns: 7
## $ DFU                 <chr> "Item 000001", "Item 000002", "Item 000003", "Item…
## $ Period              <date> 2022-07-03, 2022-07-03, 2022-07-03, 2022-07-03, 2…
## $ Demand              <dbl> 364, 1419, 265, 1296, 265, 1141, 126, 6859, 66, 38…
## $ Opening.Inventories <dbl> 6570, 5509, 2494, 7172, 1464, 9954, 2092, 17772, 1…
## $ Supply.Plan         <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
## $ Min.Stocks.Coverage <dbl> 4, 4, 4, 6, 4, 6, 4, 6, 4, 4, 4, 4, 4, 6, 4, 6, 4,…
## $ Max.Stocks.Coverage <dbl> 8, 6, 12, 6, 12, 6, 8, 10, 12, 12, 8, 6, 12, 6, 12…

unique(Blueprint_DB$DFU)
##  [1] "Item 000001" "Item 000002" "Item 000003" "Item 000004" "Item 000005"
##  [6] "Item 000006" "Item 000007" "Item 000008" "Item 000009" "Item 000010"

range(Blueprint_DB$Period)
## [1] "2022-07-03" "2023-06-25"

summary(Blueprint_DB$Demand)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       0      62     119     508     690    6859

July_03 <- Blueprint_DB %>% filter(Period == "2022-07-03")
summary(July_03$Opening.Inventories)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1222    2192    4460    5766    7022   17772

summary(Blueprint_DB$Supply.Plan)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       0       0       0     256       0   16104

Item_000008 <- filter(Blueprint_DB, Blueprint_DB$DFU == "Item 000008")

summary(Item_000008)
##      DFU                Period               Demand     Opening.Inventories
##  Length:52          Min.   :2022-07-03   Min.   : 500   Min.   :    0      
##  Class :character   1st Qu.:2022-09-30   1st Qu.: 744   1st Qu.:    0      
##  Mode  :character   Median :2022-12-28   Median :1176   Median :    0      
##                     Mean   :2022-12-28   Mean   :2203   Mean   :  342      
##                     3rd Qu.:2023-03-27   3rd Qu.:3432   3rd Qu.:    0      
##                     Max.   :2023-06-25   Max.   :6859   Max.   :17772      
##   Supply.Plan    Min.Stocks.Coverage Max.Stocks.Coverage
##  Min.   :    0   Min.   :6           Min.   :10         
##  1st Qu.:    0   1st Qu.:6           1st Qu.:10         
##  Median :    0   Median :6           Median :10         
##  Mean   :  989   Mean   :6           Mean   :10         
##  3rd Qu.:    0   3rd Qu.:6           3rd Qu.:10         
##  Max.   :16104   Max.   :6           Max.   :10

# Create a calculated database for the Projected Inventories @ DFU level
Calculated_DB <- proj_inv(
  data = Blueprint_DB,
  DFU = DFU,
  Period = Period,
  Demand = Demand,
  Opening.Inventories = Opening.Inventories,
  Supply.Plan = Supply.Plan,
  Min.Stocks.Coverage = Min.Stocks.Coverage,
  Max.Stocks.Coverage = Max.Stocks.Coverage
)

colnames(Calculated_DB)
##  [1] "DFU"                            "Period"                        
##  [3] "Demand"                         "Opening.Inventories"           
##  [5] "Calculated.Coverage.in.Periods" "Projected.Inventories.Qty"     
##  [7] "Supply.Plan"                    "Min.Stocks.Coverage"           
##  [9] "Max.Stocks.Coverage"            "Safety.Stocks"                 
## [11] "Maximum.Stocks"                 "PI.Index"                      
## [13] "Ratio.PI.vs.min"                "Ratio.PI.vs.Max"

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

