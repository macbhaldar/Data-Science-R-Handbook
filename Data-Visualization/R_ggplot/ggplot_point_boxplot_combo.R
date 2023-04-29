# CREATED BY: DANIEL KUHMAN
# CONTACT: DANIEL.KUHMAN@KUHMANTECH.COM
# GITHUB: https://github.com/dkuhman

# LOAD LIBRARIES
library("tidyverse")

# CLEAR WORKSPACE
rm(list=ls())

# PREPARE EXAMPLE DATAFRAME
mydata_pre <- data.frame("ID" = 1:25,
                     "TIME" = 1,
                     "SCORE" = sample(100,
                                     size = 25,
                                     replace = TRUE))

mydata_post <- data.frame("ID" = 1:25,
                         "TIME" = 2,
                         "SCORE" = sample(50,
                                          size = 25,
                                          replace = TRUE))

mydata <- rbind(mydata_pre, mydata_post)

rm(mydata_post, mydata_pre)

mydata$ID <- as.factor(mydata$ID)
mydata$TIME <- as.factor(mydata$TIME)

# ESTABLISH THEME
mytheme <- theme(
  plot.margin = margin(t = 15, r = 15, b = 15, l = 15),
  legend.position = 'none',
  axis.title.x = element_text(size = 14,
                              face = 'bold',
                              color = 'black',
                              margin = margin(t=15,r=0,b=0,l=0)),
  axis.title.y = element_text(size = 14,
                              face = 'bold',
                              color = 'black',
                              margin = margin(t=0,r=15,b=0,l=0)),
  axis.text = element_text(size = 12,
                           color = 'black',
                           face = 'bold'),
  axis.line = element_line(size = 1,
                           color = 'black'),
  axis.ticks = element_line(size = 1,
                            color = 'black')
)

# PLOT
ggplot(mydata,
       aes(x = TIME,
           y = SCORE)) +
  geom_boxplot(data = mydata %>% 
                 filter(TIME == '1'),
               fill = '#006699',
               color = 'black',
               lwd = 1,
               outlier.shape = NA,
               width = 0.4,
               position = position_nudge(-0.2)) +
  geom_boxplot(data = mydata %>% 
                 filter(TIME == '2'),
               fill = '#cc0000',
               color = 'black',
               lwd = 1,
               outlier.shape = NA,
               width = 0.4,
               position = position_nudge(0.2)) +
  geom_line(aes(group = ID),
            color = '#006699',
            lwd = 0.7,
            alpha = 0.5,
            position = position_nudge(x = c(0.1,-0.1))) +
  geom_point(data = mydata %>% 
               filter(TIME == '1'),
             fill = '#006699',
             shape = 21,
             size = 6.5,
             color = 'white',
             width = 0.2,
             alpha = 0.7,
             position = position_nudge(x=0.1))+
  geom_point(data = mydata %>% 
               filter(TIME == '2'),
             fill = '#cc0000',
             shape = 21,
             size = 6.5,
             color = 'white',
             width = 0.2,
             alpha = 0.7,
             position = position_nudge(x=-0.1))+
  scale_fill_manual(values = c('#006699', '#cc0000')) +
  scale_x_discrete(labels=c("1" = "PRE",
                            "2" = "POST")) +
  xlab('Observation') +
  ylab('Value') +
  theme_classic()+
  mytheme
