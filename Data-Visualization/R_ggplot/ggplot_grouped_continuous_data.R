# CREATED BY: DANIEL KUHMAN
# CONTACT: DANIEL.KUHMAN@KUHMANTECH.COM

# LIBRARIES
library('tidyverse')

# CLEAR WORKSPACE AND IMPORT DATA
{
  rm(list=ls())
  mydata_path <- file.choose(new = FALSE)
  mydata <- read.csv(mydata_path)
}

# PLOT
{
  # CREATE COLOR SCHEME
  mycolors <- c('#006633',
               "#cc0000",
               '#000066')
  
  # PLOT MEAN GRF AGAINST TIME, WITH STANDARD DEV RIBBONS, COLORED BY GROUP
  ggplot(mydata,
         aes(x = time,
             y = means,
             color = group)) +
    geom_ribbon(aes(ymin = means - stds,
                    ymax = means + stds,
                    fill = group),
                alpha = 0.2,
                color = NA) +
    geom_line(size = 1.5) + 
    theme_classic() + 
    geom_hline(yintercept = 0) + 
    xlab('Time (sec.)') + 
    ylab('AP GRF (N)') +
    scale_x_continuous(expand = c(0, 0)) + 
    theme(axis.title.x = element_text(size = 25, 
                                      face = 'bold', 
                                      margin = margin(t=10,r=0,b=0,l=0)),
          axis.title.y = element_text(size = 20,
                                      face = 'bold',
                                      margin = margin(t=0,r=10,b=0,l=0)),
          axis.text = element_text(size = 20,
                                   color ='#000000'),
          axis.line = element_line(size =1),
          plot.margin = unit(c(1,1,1,1),"cm")) + 
    scale_color_manual(values = mycolors, 
                       guide = FALSE) +
    scale_fill_manual(values = mycolors,
                      guide = FALSE) 
}
