library(tidyverse)
library(readxl)
library(waffle)
library(sysfonts)
library(showtext)
library(tidymodels)
library(tidyquant)

df_migration <- read_excel("data/migration.xlsx") %>% 
  na.omit()

#loading Google fonts
#font_add_google("Roboto Slab")
#To support and make Google fonts work 
showtext_auto()

#Proportions of foreign-born populations in the given countries
df_migration %>% 
  mutate(country = fct_reorder(country, migrants_rate)) %>% 
  group_by(year) %>% 
  ggplot(aes(fill = country, values = migrants_rate)) + 
  geom_waffle(color = "white",
              size = 0.5,
              n_rows = 3,
              flip = TRUE,
              make_proportional = TRUE) +
  facet_wrap(~year, nrow = 1, strip.position = "bottom") +
  scale_x_discrete(breaks = scales::pretty_breaks()) +
  labs(title = "Proportions of foreign-born populations in the given countries",
       caption = "Source: United Nations Department of Economic and Social Affairs (UN DESA)") +
  theme_minimal(base_family = "Roboto Slab")  +
  theme(
    axis.text.y = element_blank(),
    panel.grid = element_blank(),
    legend.title = element_blank(),
    text = element_text(size=15),
    plot.title = element_text(hjust = 0.5, 
                              size = 14,
                              face = "bold"),
    plot.caption = element_text(size = 10,
                                color = "blue",
                                face = "bold"),
    plot.caption.position = "plot"
  )

#Comparing employment rates of the given countries
df_employment <- read_excel("foreign_born_employment.xlsx")


df_employment %>% 
  mutate(country = fct_reorder(country, employment_rate)) %>% 
  ggplot(aes(year, employment_rate, fill = country)) + 
  geom_bar(stat="identity", position="dodge") + 
  scale_y_continuous(breaks = c(seq(0, 75, 25)))+
  labs(
    caption = "Source: OECD",
    title="Foreign-born employment aged 15-64\nin total foreign-born population of that same age ") +
  theme_minimal(base_family = "Roboto Slab") +
  theme(
    axis.ticks.y  = element_line(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.title = element_blank(),
    text = element_text(size=15),
    plot.title = element_text(hjust = 0.5, 
                              size = 14, 
                              face = "bold"),
    plot.caption = element_text(size = 12,
                                color = "blue",
                                face = "bold"),
    plot.caption.position = "plot"
  )

df_conflict <- read_excel("conflict_toll.xlsx")


df_conflict <- 
  df_migration %>% 
  #Using the VLOOKUP function of excel to match the relevant time values
  #with the help of tidyquant package
  mutate(deaths = VLOOKUP(df_migration$year, df_conflict, year, deaths)) %>%
  #the cumulative sum of deaths corresponds to the cumulative sum of the number 
  #of immigrants for the interested years
  mutate(deaths = cumsum(deaths))


#Simple linear regression model with interaction terms
model_lm <- 
  linear_reg() %>% 
  set_engine("lm")


model_fit <- 
  model_lm %>% 
  fit(migrants_rate ~ country:deaths, data = df_conflict)


#Comparing the countries to their p-values for the cause-effect 
model_fit %>% 
  tidy() %>% 
  #simplifying the term names
  mutate(term= case_when(
    str_detect(term, "France") ~ "France",
    str_detect(term, "Germany") ~ "Germany",
    str_detect(term, "Greece") ~ "Greece",
    str_detect(term, "Turkey") ~ "Turkey",
    str_detect(term, "United Kingdom") ~ "United Kingdom"
  )) %>% 
  .[-1,] %>% #removing the intercept
  ggplot(aes(term, p.value)) +
  geom_point(aes(color = term) , size = 3) +
  geom_hline(yintercept = 0.05, 
             linetype = "dashed",
             alpha = 0.5,
             size = 1,
             color = "red") +
  labs(title ="Comparing the countries to their p-values\nat a significance level of 0.05 (red dashed line)" , 
       color = "", 
       x = "", 
       y = "") +
  theme_minimal(base_family = "Roboto Slab") + 
  theme(
    panel.grid = element_blank(),
    axis.text = element_blank(),
    panel.background = element_rect(fill = "lightgrey", color = NA),
    text = element_text(size = 15),
    plot.title = element_text(
      hjust = 0.5,
      face = "bold",
      size = 14
    )
  )
