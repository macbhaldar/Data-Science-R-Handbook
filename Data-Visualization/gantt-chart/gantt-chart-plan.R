library(tidyverse)
library(plan)

df <- data.frame(task=c("Explore Ideas", "Finalize Idea", "Make Plots with\n geom_line", "Make Plots with\n Plan Package", "Add Writeups", "Refine Plots", "Review Tutorial", "Submit Tutorial", "Get Feedback\n and Update"), 
                 start=c("2019-10-15", "2019-10-18", "2019-10-19", "2019-10-22", "2019-10-24", "2019-10-25", "2019-10-26", "2019-10-27", "2019-10-28"),
                 end=c("2019-10-18", "2019-10-19", "2019-10-24", "2019-10-26", "2019-10-27", "2019-10-27", "2019-10-28", "2019-10-28", "2019-10-31"), 
                 owner=c("Harish", "Phani", "Harish", "Phani", "Phani", "Harish", "Phani", "Harish", "Phani"))

head(df)


# Converting the dates from factor type to date type:
df <- df %>% 
  mutate(start = as.Date(start), end = as.Date(end))

# add another column that indicates whether the date is the start date or the end date.
df_tidy <- df %>% 
  gather(key=date_type, value=date, -task, -owner)


g <- new("gantt")
g <- ganttAddTask(g, "Explore Ideas","2019-10-15","2019-10-18",done=100 )
g <- ganttAddTask(g, "Finalize project","2019-10-18","2019-10-19",done=100 )
g <- ganttAddTask(g, "Create WBS","2019-10-19","2019-10-20",done=100 )
g <- ganttAddTask(g, "Gantt chart - geom_line","2019-10-20","2019-10-24",done=100 )
g <- ganttAddTask(g, "Gantt chart - package","2019-10-22","2019-10-26",done=100 )
g <- ganttAddTask(g, "Add Writeup","2019-10-24","2019-10-27",done=100 )
g <- ganttAddTask(g, "Refine Plot","2019-10-25","2019-10-27",done=100 )
g <- ganttAddTask(g, "Review Tutorial","2019-10-26","2019-10-28",done=80 )
g <- ganttAddTask(g, "Submit Tutorial","2019-10-27","2019-10-28",done=0 )
g <- ganttAddTask(g, "Get Feedback and Update","2019-10-28","2019-10-31",done=0 )

plot(g, ylabel=list(font=ifelse(is.na(g[["start"]]), 2, 1)),
     event.time="2019-10-27", event.label="Report Date",
     main = "Community Contribution Gantt Chart")
legend("topright", pch=22, pt.cex=2, cex=0.9, pt.bg=gray(c(0.3, 0.9)),
       border="black",
       legend=c("Completed", "Not Yet Done"), bg="white", xpd=TRUE)



# categorize sections of tasks into groups
g <- new("gantt")
g <- ganttAddTask(g, "Plan")
g <- ganttAddTask(g, "Explore Ideas","2019-10-15","2019-10-18",done=100 )
g <- ganttAddTask(g, "Finalize project","2019-10-18","2019-10-19",done=100 )
g <- ganttAddTask(g, "Create WBS","2019-10-19","2019-10-20",done=100 )
g <- ganttAddTask(g, "Implement")
g <- ganttAddTask(g, "Gantt chart - geom_line","2019-10-20","2019-10-24",done=100 )
g <- ganttAddTask(g, "Gantt chart - package","2019-10-22","2019-10-26",done=100 )
g <- ganttAddTask(g, "Add Writeup","2019-10-24","2019-10-27",done=100 )
g <- ganttAddTask(g, "Refine Plot","2019-10-25","2019-10-27",done=100 )
g <- ganttAddTask(g, "Review")
g <- ganttAddTask(g, "Review Tutorial","2019-10-26","2019-10-28",done=80 )
g <- ganttAddTask(g, "Submit Tutorial","2019-10-27","2019-10-28",done=0 )
g <- ganttAddTask(g, "Get Feedback and Update","2019-10-28","2019-10-31",done=0 )

plot(g, ylabel=list(font=ifelse(is.na(g[["start"]]), 2, 1)),
     event.time="2019-10-27", event.label="Report Date",
     main = "Community Contribution Gantt Chart")
legend("topright", pch=22, pt.cex=2, cex=0.9, pt.bg=gray(c(0.3, 0.9)),
       border="black",
       legend=c("Completed", "Not Yet Done"), bg="white", xpd=TRUE)



# add the dependency on other tasks
gt_object <- read.gantt("https://raw.githubusercontent.com/harish-cu/cc19/tasks_file/tasks.csv") 
plot(gt_object,event.label='Report Date',event.time='2019-10-27',
     col.event=c("red"),
     col.done=c("lightblue"),
     col.notdone=c("pink"),
     main="Community Contribution Gantt Chart")
legend("topright", pch=22, pt.cex=2, cex=0.9, pt.bg=c("lightblue", "pink"),
       border="black",
       legend=c("Completed", "Not Yet Done"), bg="white", xpd=TRUE)
