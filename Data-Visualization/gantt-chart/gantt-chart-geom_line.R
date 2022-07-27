library(tidyverse)
library(plan)

df <- data.frame(task=c("Explore Ideas", "Finalize Idea", "Make Plots with\n geom_line", 
                        "Make Plots with\n Plan Package", "Add Writeups", "Refine Plots", 
                        "Review Tutorial", "Submit Tutorial", "Get Feedback\n and Update"), 
                 start=c("2019-10-15", "2019-10-18", "2019-10-19", "2019-10-22", "2019-10-24", 
                         "2019-10-25", "2019-10-26", "2019-10-27", "2019-10-28"),
                 end=c("2019-10-18", "2019-10-19", "2019-10-24", "2019-10-26", "2019-10-27", 
                       "2019-10-27", "2019-10-28", "2019-10-28", "2019-10-31"), 
                 owner=c("Harish", "Phani", "Harish", "Phani", "Phani", "Harish", "Phani", 
                         "Harish", "Phani"))

head(df)


# Converting the dates from factor type to date type:
df <- df %>% 
  mutate(start = as.Date(start), end = as.Date(end))

# add another column that indicates whether the date is the start date or the end date.
df_tidy <- df %>% 
  gather(key=date_type, value=date, -task, -owner)


# adjust the size parameter to get a bar instead of a line
ggplot() +
  geom_line(data=df_tidy, mapping=aes(x=task, y=date), size=10) +
  coord_flip() 

# color
ggplot() +
  geom_line(data=df_tidy, mapping=aes(x=fct_rev(fct_inorder(task)), 
                                      y=date, color=owner), size=10) +
  coord_flip() 

# add labels
ggplot() +
  geom_line(data=df_tidy, mapping=aes(x=fct_rev(fct_inorder(task)), 
                                      y=date, color=owner), size=10) +
  geom_hline(yintercept=as.Date("2019-10-27"), 
             colour="black", linetype="dashed") +
  coord_flip() +
  labs(title="Community Contribution Gantt Chart",
       x = "Task",
       y = "Date",
       colour = "Owner") 

# 
ggplot() +
  geom_line(data=df_tidy, mapping=aes(x=fct_rev(fct_inorder(task)), 
                                      y=date, color=owner), size=10) +
  geom_hline(yintercept=as.Date("2019-10-27"), colour="black", linetype="dashed") +
  coord_flip() +
  scale_y_date(date_breaks = "1 day") +
  labs(title="Community Contribution Gantt Chart",
       x = "Task",
       y = "Date",
       colour = "Owner") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90),
        panel.grid.minor = element_line(colour="white", size=0.5),
        legend.position="right",
        plot.title = element_text(hjust = 0.5))



# final code
df_completed <- df %>% 
  mutate(completed = factor(c(rep(1, 6), rep(0, 3))))

df_tidy <- df_completed %>% 
  gather(key=date_type, value=date, -task, -owner, -completed)


ggplot() +
  geom_line(data=df_tidy, mapping=aes(x=fct_rev(fct_inorder(task)), 
                                      y=date, color=owner, alpha=completed), size=10) +
  geom_hline(yintercept=as.Date("2019-10-27"), colour="black", linetype="dashed") +
  coord_flip() +
  scale_alpha_discrete(range=c(1, 0.2), guide="none") +
  scale_y_date(date_breaks = "1 day") +
  labs(title="Community Contribution Gantt Chart",
       x = "Task",
       y = "Date",
       colour = "Owner") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90),
        panel.grid.minor = element_line(colour="white", size=0.5),
        legend.position="right",
        plot.title = element_text(hjust = 0.5))
