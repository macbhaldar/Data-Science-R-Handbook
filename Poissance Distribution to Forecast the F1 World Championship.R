pos_func = function(x) {
  
  
  all_data778 = all_data %>% left_join(min_lap, by = c("raceId", "lap")) %>%
    filter(round < x) %>%
    filter(year > 2009) %>%
    mutate(delta = milliseconds/minl-1) %>%
    # filter(year == 2014) %>%
    filter(delta < 2) %>%
    filter(delta < 0.1) %>%
    group_by(code, driverId, year) %>%
    summarise(meandel = mean(delta)) %>%
    left_join(avpos_dri, by = c("code", "year")) %>%
    mutate(roundav = x) %>%
    select(meandel, meanpos, roundav)
  
  return(all_data778)
  
  
}


rac1 = c(2:19)


pace_mes = map_dfr(rac1, pos_func)

pace_mes2 = pace_mes %>% 
  ungroup() %>%
  group_by(roundav) %>%
  nest() %>%
  mutate(mod = map(data, ~lm(meandel ~ meanpos, data = .)), 
         quality = map(mod, glance))  %>%
  unnest(quality) %>%
  select(roundav, r.squared) %>%
  mutate(meas = "racepace")



pos_func2 = function(x){
  
  avpos_dri_2 = results %>% left_join(drivers, by = "driverId") %>%
    left_join(constructors, by ="constructorId") %>%
    ungroup() %>%
    left_join(races, by = "raceId")  %>%
    filter(milliseconds != "\\N")  %>%
    filter(year > 2008) %>%
    ungroup() %>%
    filter(round < x) %>%
    group_by(year, code) %>% 
    summarise(meanpos1 = mean(positionOrder, na.rm = T))  %>%
    left_join(avpos_dri, by = c("code", "year")) %>%
    ungroup() %>%
    mutate(roundav = x) %>%
    ungroup() %>%
    select(roundav, meanpos, meanpos1)
  
  return(avpos_dri_2)
  
  
} 



rac = c(2:19)

pos_sum = map_dfr(rac, pos_func2)




pos_sum2 = pos_sum %>% 
  ungroup() %>%
  group_by(roundav) %>%
  nest() %>%
  mutate(mod = map(data, ~lm(meanpos1 ~ meanpos, data = .)), 
         quality = map(mod, glance))  %>%
  unnest(quality) %>%
  select(roundav, r.squared) %>%
  mutate(meas = "position")



com_sum = pace_mes2 %>%
  bind_rows(pos_sum2)


cols = c("position" = "#2f0094", "racepace" = "#ff8519")

ggplot(com_sum, aes(x = roundav, y = r.squared, col = meas)) + geom_line(size = 2) +
  scale_colour_manual(values = cols) +
  labs(x = "Race No.", y = "R Squared", title = "Average Finishing Position Predition" ) +
  theme(panel.background = element_blank())


set.seed(13) # set seed for reproducibility

n <- 23000 # number of draws
mu <- 7 # mean
sigma <- 3.33 # standard deviation

# generate n random draws from normal distribution
samples <- rnorm(n, mean = mu, sd = sigma)
sample2 = rpois(n, lambda = mu)



samp = tibble(samples)
samp2 = tibble(sample2) 



norm = samp %>% mutate(result = round(samples, 0)) %>%
  group_by(result) %>%
  summarise(n = n() ) %>%
  mutate(prob = n/23000) %>%
  mutate(dist = "norm")


pois = samp2 %>% mutate(result = if_else(sample2 == 0, 1, as.double(sample2))) %>%
  group_by(result) %>%
  summarise(n = n() ) %>%
  mutate(prob = n/23000) %>%
  mutate(dist = "pois")



dist_comp = norm %>% bind_rows(pois)




ave_pos_num2 = avpos_dri %>% mutate(roundpos = round(meanpos, 0))




pos_dri = results %>% left_join(drivers, by = "driverId") %>%
  left_join(constructors, by ="constructorId") %>%
  left_join(races, by = "raceId")  %>%
  filter(milliseconds != "\\N")  %>%
  ungroup() %>%
  left_join(ave_pos_num2, by = c("year", "code")) %>%
  filter(roundpos == 7) %>%
  group_by(positionOrder) %>%
  summarise(n = n()) %>%
  mutate(prob = n/449) %>%
  rename(result = positionOrder) %>%
  mutate(dist = "act")





dist_comp2 = dist_comp %>% bind_rows(pos_dri)




cols = c("pois" = "#ff8519", "norm" = "#2f0094", "act" = "#009c39")


ggplot(dist_comp2, aes(x = result, y = prob, col = dist))+ geom_line(size = 1.5) +
  scale_color_manual(values = cols) +
  labs(x = "Finishing Position", y = "probaility of Finishing", title = "Probability Distributions Compared to Actual") +
  guides(colour = guide_legend(title = "Distribution")) +
  theme(panel.background = element_blank())


dat_create <- function(x) {
  position <- pce23_2 %>% filter(driverId == x)
  mu <- position[[5]]
  sample2 <- rpois(10000000, lambda = mu)
  samp2 <- tibble(sample2)
  
  samp_ver <- samp2 %>%
    mutate(sample3 = if_else(sample2 == 0, 1, as.double(sample2))) %>%
    group_by(sample3) %>%
    summarise(n = n()) %>%
    uncount(n) %>%
    mutate(driverId = x)
  
  return(samp_ver)
}

driver <- c(1,4,807,815,822,825,830,832,839,840,842,844,846,847,848,852,855,856,857,858)
dri_23 <- map_dfr(driver, dat_create)

# Create a function to sample positions and rename columns
sample_and_rename <- function(data, position) {
  data %>% filter(sample3 == position) %>%
    sample_n(size = 100000) %>%
    select(driverId) %>%
    rename(!!paste0("pos_", position) := driverId)
}

# Loop through positions and bind columns
all_pos <- tibble()
for (i in 1:10) {
  all_pos <- all_pos %>% bind_cols(sample_and_rename(dri_23, i))
}



doParallel::registerDoParallel()

all_pos2 = data.frame(all_pos)

race_res_sim <- function(x) {
  pos_ssel <- sample(all_pos2$pos_1, 1)
  fil_sel <- all_pos2[, -1]
  result <- c(pos_ssel, numeric(9))
  for (i in 2:10) {
    pos_i <- paste0("pos_", i)
    filt <- fil_sel[[pos_i]] != pos_ssel & !is.na(fil_sel[[pos_i]])
    pos_is <- sample(fil_sel[filt, pos_i], 1)
    fil_sel <- fil_sel[fil_sel[[pos_i]] != pos_is, ]
    result[i] <- pos_is
  }
  c(result, race = x)
}

raceid <- 1:23000
res3 <- t(replicate(length(raceid), race_res_sim(raceid)))

res3 <- as.data.frame(res3)

re3 = res3 %>% select(contains("V"))



re4 = re3 %>% rename("Pos_1" = V1, "Pos_2" = V2, "Pos_3" = V3, "Pos_4" = V4, "Pos_5" = V5, "Pos_6" = V6, "Pos_7" = V7, "Pos_8" = V8, "Pos_9" = V9,
                     "Pos_10" = V10)
