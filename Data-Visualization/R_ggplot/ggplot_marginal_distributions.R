# CREATED BY: DANIEL KUHMAN
# CONTACT: DANIEL.KUHMAN@KUHMANTECH.COM
# PURPOSE: CREATE SCATTER PLOT WITH MARGINAL HISTOGRAMS

# LIBRARIES
library('tidyverse')
library('ggExtra')

# DATA
data(mpg, package = 'ggplot2')
mydata <- as.data.frame(mpg)

# PLOT
myplot <- ggplot(mydata,
       aes(x = cty,
           y = hwy)) +
  geom_jitter(shape = 21,
              color = 'white',
              size = 3,
              fill = 'blue',
              alpha = 0.5) +
  ylab('Highway Mileage (mpg)') +
  xlab('City Mileage (mpg)') +
  theme_bw() +
  theme(
    axis.title.y = element_text(size = 20,
                              color = 'black',
                              face = 'bold',
                              margin = margin(t=0,r=15,b=0,l=0)),
    axis.title.x = element_text(size = 20,
                                color = 'black',
                                face = 'bold',
                                margin = margin(t=15,r=0,b=0,l=0)),
    axis.text = element_text(size = 16,
                             color = 'black')
  )

ggMarginal(myplot,
           type = 'histogram',
           fill = 'blue',
           color = 'white',
           alpha = 0.5)
