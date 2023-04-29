library(tidyverse)
library(gt)

res_log <- read_csv("https://raw.githubusercontent.com/kathoffman/steroids-trial-emulation/main/output/res_log.csv")
res <- read_csv("https://raw.githubusercontent.com/kathoffman/steroids-trial-emulation/main/output/res.csv")

res <- res_log |>
  rename_with(~str_c("log.", .), estimate:conf.high) |>
  select(-p.value) |>
  full_join(res)

glimpse(res)

p <- 
  res |>
  ggplot(aes(y = fct_rev(model))) + 
  theme_classic()
p

p <- p +
  geom_point(aes(x=log.estimate), shape=15, size=3) +
  geom_linerange(aes(xmin=log.conf.low, xmax=log.conf.high)) 
p

p <- p +
  geom_vline(xintercept = 0, linetype="dashed") +
  labs(x="Log Hazard Ratio", y="")
p

p <- p +
  coord_cartesian(ylim=c(1,11), xlim=c(-1, .5))
p

p <- p +
  annotate("text", x = -.32, y = 11, label = "Corticosteroids protective") +
  annotate("text", x = .3, y = 11, label = "Corticosteroids harmful")
p

p_mid <- p + 
  theme(axis.line.y = element_blank(),
        axis.ticks.y= element_blank(),
        axis.text.y= element_blank(),
        axis.title.y= element_blank())
p_mid


# wrangle results into pre-plotting table form
res_plot <- res |>
  # round estimates and 95% CIs to 2 decimal places for journal specifications
  mutate(across(
    c(estimate, conf.low, conf.high),
    ~ str_pad(
      round(.x, 2),
      width = 4,
      pad = "0",
      side = "right"
    )
  ),
  # add an "-" between HR estimate confidence intervals
  estimate_lab = paste0(estimate, " (", conf.low, "-", conf.high, ")")) |>
  # round p-values to two decimal places, except in cases where p < .001
  mutate(p.value = case_when(
    p.value < .001 ~ "<0.001",
    round(p.value, 2) == .05 ~ as.character(round(p.value,3)),
    p.value < .01 ~ str_pad( # if less than .01, go one more decimal place
      as.character(round(p.value, 3)),
      width = 4,
      pad = "0",
      side = "right"
    ),
    TRUE ~ str_pad( # otherwise just round to 2 decimal places and pad string so that .2 reads as 0.20
      as.character(round(p.value, 2)),
      width = 4,
      pad = "0",
      side = "right"
    )
  )) |>
  # add a row of data that are actually column names which will be shown on the plot in the next step
  bind_rows(
    data.frame(
      model = "Model",
      estimate_lab = "Hazard Ratio (95% CI)",
      conf.low = "",
      conf.high = "",
      p.value = "p-value"
    )
  ) |>
  mutate(model = fct_rev(fct_relevel(model, "Model")))

glimpse(res_plot)

p_left <-
  res_plot  |>
  ggplot(aes(y = model))
p_left

p_left <- 
  p_left +
  geom_text(aes(x = 0, label = model), hjust = 0, fontface = "bold")
p_left

p_left <- 
  p_left +
  geom_text(
    aes(x = 1, label = estimate_lab),
    hjust = 0,
    fontface = ifelse(res_plot$estimate_lab == "Hazard Ratio (95% CI)", "bold", "plain")
  )

p_left

p_left <-
  p_left +
  theme_void() +
  coord_cartesian(xlim = c(0, 4))

p_left

# right side of plot - pvalues
p_right <-
  res_plot  |>
  ggplot() +
  geom_text(
    aes(x = 0, y = model, label = p.value),
    hjust = 0,
    fontface = ifelse(res_plot$p.value == "p-value", "bold", "plain")
  ) +
  theme_void() 

p_right

layout <- c(
  area(t = 0, l = 0, b = 30, r = 3), # left plot, starts at the top of the page (0) and goes 30 units down and 3 units to the right
  area(t = 1, l = 4, b = 30, r = 9), # middle plot starts a little lower (t=1) because there's no title. starts 1 unit right of the left plot (l=4, whereas left plot is r=3), goes to the bottom of the page (30 units), and 6 units further over from the left plot (r=9 whereas left plot is r=3)
  area(t = 0, l = 9, b = 30, r = 11) # right most plot starts at top of page, begins where middle plot ends (l=9, and middle plot is r=9), goes to bottom of page (b=30), and extends two units wide (r=11)
)
# final plot arrangement
p_left + p_mid + p_right + plot_layout(design = layout)

ggsave("forest-plot.eps", width=9, height=4)



## load up the packages we will need: 
library(tidyverse)
library(gt)
library(patchwork)
## ---------------------------
## load data
# load in results generated from Cox PH hazards models
res_log <- read_csv("model-first-results-log.csv")
res <- read_csv("model-first-results.csv")
res <- res_log |>
  rename_with(~str_c("log.", .), estimate:conf.high) |>
  select(-p.value) |>
  full_join(res)

## plotting
## ---------------------------
# create forest plot on log scale (middle section of figure)
p_mid <-
  res |>
  ggplot(aes(y = fct_rev(model))) +
  theme_classic() +
  geom_point(aes(x=log.estimate), shape=15, size=3) +
  geom_linerange(aes(xmin=log.conf.low, xmax=log.conf.high)) +
  labs(x="Log Hazard Ratio") +
  coord_cartesian(ylim=c(1,11), xlim=c(-1, .5))+
  geom_vline(xintercept = 0, linetype="dashed") +
  annotate("text", x = -.32, y = 11, label = "Corticosteroids protective") +
  annotate("text", x = .3, y = 11, label = "Corticosteroids harmful") +
  theme(axis.line.y = element_blank(),
        axis.ticks.y= element_blank(),
        axis.text.y= element_blank(),
        axis.title.y= element_blank())
# wrangle results into pre-plotting table form
res_plot <- res |>
  mutate(across(c(estimate, conf.low, conf.high), 
                ~str_pad(round(.x, 2), width=4, pad="0", side="right")),
         estimate_lab = paste0(estimate, " (", conf.low, "-", conf.high,")"),
         color = rep(c("gray","white"),5)) |>
  mutate(p.value = case_when(p.value < .01 ~ "<0.01", 
                             TRUE ~ str_pad(as.character(round(p.value, 2)),
                                            width=4,pad="0",side="right"))) |>
  bind_rows(data.frame(model = "Model", estimate_lab = "Hazard Ratio (95% CI)", 
                       conf.low = "", conf.high="",p.value="p-value")) |>
  mutate(model = fct_rev(fct_relevel(model, "Model")))
# left side of plot - hazard ratios
p_left <-
  res_plot  |>
  ggplot(aes(y = model)) + 
  geom_text(aes(x=0, label=model), hjust=0, fontface = "bold") +
  geom_text(aes(x=1, label=estimate_lab), hjust=0, 
            fontface = ifelse(res_plot$estimate_lab == "Hazard Ratio (95% CI)", "bold", "plain")) +
  theme_void() +
  coord_cartesian(xlim=c(0,4))
# right side of plot - pvalues
p_right <-
  res_plot  |>
  ggplot() +
  geom_text(aes(x=0, y=model, label=p.value), hjust=0, 
            fontface = ifelse(res_plot$p.value == "p-value", "bold", "plain")) +
  theme_void() 
# layout design (top, left, bottom, right)
layout <- c(
  area(t = 0, l = 0, b = 30, r = 3),
  area(t = 1, l = 4, b = 30, r = 9),
  area(t = 0, l = 9, b = 30, r = 11)
)
# final plot arrangement
p_left + p_mid + p_right + plot_layout(design = layout)
## save final figure
#ggsave("forest-plot.eps", width=9, height=4)


sessionInfo()