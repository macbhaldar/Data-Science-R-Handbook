# CREATED BY: DANIEL KUHMAN
# DATE CREATED: 2021-01-11
# CONTACT: DANIEL.KUHMAN@KUHMANTECH.COM
# GITHUB: https://github.com/dkuhman

library('tidyverse')

# LOAD DATA
mydata_path <- file.choose(new = FALSE)
mydata <- read.csv(mydata_path)
rm(mydata_path)

# PLOT REGULAR GROUPED BAR PLOT
ggplot(mydata,
       aes(x = Country,
           y = Height,
           fill = Gender)) +
  geom_bar(stat = 'identity',
           position = position_dodge()) +
  coord_flip()+
  theme_classic() +
  theme(
    axis.title = element_text(size = 20,
                              color = 'black',
                              face = 'bold'),
    axis.text = element_text(size = 14,
                             color = 'black',
                             face = 'bold'),
    axis.line = element_line(size = 1.5),
    legend.position = 'right',
    legend.title = element_text(size = 16,
                                color = 'black',
                                face = 'bold'),
    legend.text = element_text(size = 16,
                               color = 'black',
                               face = 'bold')
  )

# PREP DATA FOR DIVERGENT BARS
mydata <- mydata %>% 
  mutate(Height = ifelse(Gender == 'Male',
                         Height,
                         -1*Height))

y_breaks <- pretty(mydata$Height)


# PLOT DIVERGENT BAR PLOTS
ggplot(mydata, 
       aes(x = Country,
           y = Height,
           fill = Gender)) +
  geom_bar(stat = 'identity',
           color = 'white',
           lwd = 2)+
  coord_flip()+
  scale_y_continuous(breaks = y_breaks,
                     labels = abs(y_breaks))+
  ylab('Height (cm)') +
  theme_classic() +
  theme(
    axis.title = element_text(size = 20,
                              color = 'black',
                              face = 'bold'),
    axis.text = element_text(size = 14,
                             color = 'black',
                             face = 'bold'),
    axis.line = element_line(size = 1.5),
    legend.position = 'right',
    legend.title = element_text(size = 16,
                                color = 'black',
                                face = 'bold'),
    legend.text = element_text(size = 16,
                               color = 'black',
                               face = 'bold')
  )







