library(candela)

data <- list(
  list(name='Do this', level=1, start=0, end=5),
  list(name='This part 1', level=2, start=0, end=3),
  list(name='This part 2', level=2, start=3, end=5),
  list(name='Then that', level=1, start=5, end=15),
  list(name='That part 1', level=2, start=5, end=10),
  list(name='That part 2', level=2, start=10, end=15))

candela('GanttChart',
        data=data, label='name',
        start='start', end='end', level='level',
        width=700, height=200)





library(DiagrammeR)

mermaid("
gantt
dateFormat  YYYY-MM-DD
title A Very Nice Gantt Diagram

section Basic Tasks
This is completed             :done,          first_1,    2014-01-06, 2014-01-08
This is active                :active,        first_2,    2014-01-09, 3d
Do this later                 :               first_3,    after first_2, 5d
Do this after that            :               first_4,    after first_3, 5d

section Important Things
Completed, critical task      :crit, done,    import_1,   2014-01-06,24h
Also done, also critical      :crit, done,    import_2,   after import_1, 2d
Doing this important task now :crit, active,  import_3,   after import_2, 3d
Next critical task            :crit,          import_4,   after import_3, 5d

section The Extras
First extras                  :active,        extras_1,   after import_4,  3d
Second helping                :               extras_2,   after extras_1, 20h
More of the extras            :               extras_3,   after extras_1, 48h
")



library(timevis)

data <- data.frame(
  id      = 1:4,
  content = c("Item one"  , "Item two"  ,"Ranged item", "Item four"),
  start   = c("2016-01-10", "2016-01-11", "2016-01-20", "2016-02-14 15:00:00"),
  end     = c(NA          ,           NA, "2016-02-04", NA)
)

timevis(data)






library(plotly)

df <- read.csv("https://cdn.rawgit.com/plotly/datasets/master/GanttChart-updated.csv", 
               stringsAsFactors = F)

df$Start  <- as.Date(df$Start, format = "%m/%d/%Y")
client    <- "Sample Client"
cols      <- RColorBrewer::brewer.pal(length(unique(df$Resource)), name = "Set3")
df$color  <- factor(df$Resource, labels = cols)

p <- plot_ly()
for(i in 1:(nrow(df) - 1)){
  p <- add_trace(p,
                 x = c(df$Start[i], df$Start[i] + df$Duration[i]), 
                 y = c(i, i), 
                 mode = "lines",
                 line = list(color = df$color[i], width = 20),
                 showlegend = F,
                 hoverinfo = "text",
                 text = paste("Task: ", df$Task[i], "<br>",
                              "Duration: ", df$Duration[i], "days<br>",
                              "Resource: ", df$Resource[i]),
                 evaluate = T
  )
}

p




library(reshape2)
library(ggplot2)

tasks <- c("Review literature", "Mung data", "Stats analysis", "Write Report")
dfr <- data.frame(
  name        = factor(tasks, levels = tasks),
  start.date  = as.Date(c("2010-08-24", "2010-10-01", "2010-11-01", "2011-02-14")),
  end.date    = as.Date(c("2010-10-31", "2010-12-14", "2011-02-28", "2011-04-30")),
  is.critical = c(TRUE, FALSE, FALSE, TRUE)
)
mdfr <- melt(dfr, measure.vars = c("start.date", "end.date"))

ggplot(mdfr, aes(value, name, colour = is.critical)) + 
  geom_line(size = 6) +
  xlab(NULL) + 
  ylab(NULL)





install.packages("vistime")    
library("vistime")  

dat <- data.frame(Position=c(rep("President", 3), rep("Vice", 3)),
                  Name = c("Washington", "Adams", "Jefferson", "Adams", "Jefferson", "Burr"),
                  start = rep(c("1789-03-29", "1797-02-03", "1801-02-03"), 2),
                  end = rep(c("1797-02-03", "1801-02-03", "1809-02-03"), 2),
                  color = c('#cbb69d', '#603913', '#c69c6e'),
                  fontcolor = rep("white", 3))

vistime(dat, events="Position", groups="Name", title="Presidents of the USA")





library(ggplot2)

tasks <- c("Review literature", "Mung data", "Stats analysis", "Write Report")
dfr <- data.frame(
  name        = factor(tasks, levels = tasks),
  start.date  = as.Date(c("2010-08-24", "2010-10-01", "2010-11-01", "2011-02-14")),
  end.date    = as.Date(c("2010-10-31", "2010-12-14", "2011-02-28", "2011-04-30")),
  is.critical = c(TRUE, FALSE, FALSE, TRUE)
)

ggplot(dfr, aes(x =start.date, xend= end.date, y=name, yend = name, color=is.critical)) +
  geom_segment(size = 6) +
  xlab(NULL) + ylab(NULL)






