# install.packages("ggparliament")
library(ggparliament)
# install.packages("tidyverse")
library(tidyverse)

# Data
ru <- election_data %>%
  filter(country == "Russia" & year == 2016)


# Semi-Circle parliament
# Create the data frame to be used
ru_semicircle <- parliament_data(election_data = ru,
                                 type = "semicircle", # Parliament type
                                 parl_rows = 10,      # Number of rows of the parliament
                                 party_seats = ru$seats) # Seats per party

ggplot(ru_semicircle, aes(x = x, y = y, colour = party_short)) +
  geom_parliament_seats() + 
  theme_ggparliament() +
  labs(title = "Russia, 2016") +
  scale_colour_manual(values = ru_semicircle$colour, 
                      limits = ru_semicircle$party_short)


# Circle parliament
ru_circle <- parliament_data(election_data = ru,
                             type = "circle",
                             parl_rows = 10,
                             party_seats = ru$seats)

ggplot(ru_circle, aes(x = x, y = y, colour = party_short)) +
  geom_parliament_seats() + 
  theme_ggparliament() +
  labs(title = "Russia, 2016") +
  scale_colour_manual(values = ru_circle$colour, 
                      limits = ru_circle$party_short) 



# Opposing benches parliament
ru_ob <- parliament_data(election_data = ru,
                         type = "opposing_benches",
                         group = ru$government,
                         parl_rows = 10,
                         party_seats = ru$seats)

ggplot(ru_ob, aes(x = x, y = y, colour = party_short)) +
  geom_parliament_seats() + 
  theme_ggparliament() +
  labs(title = "Russia, 2016") +
  scale_colour_manual(values = ru$colour, 
                      limits = ru$party_short) +
  coord_flip()


# Classroom parliament
ru_classroom <- parliament_data(election_data = ru,
                                type = "classroom",
                                parl_rows = 11,
                                party_seats = ru$seats)

ggplot(ru_classroom, aes(x = x, y = y, colour = party_short)) +
  geom_parliament_seats() + 
  theme_ggparliament() +
  labs(title = "Russia, 2016") +
  scale_colour_manual(values = ru$colour, 
                      limits = ru$party_short) 



# Highlight government and draw majority threshold
ru_semicircle <- parliament_data(election_data = ru,
                                 type = "semicircle",
                                 parl_rows = 10,
                                 party_seats = ru$seats)

ggplot(ru_semicircle, aes(x = x, y = y, colour = party_short)) +
  geom_parliament_seats() + 
  geom_highlight_government(government == 1) +
  draw_majoritythreshold(n = 225, label = TRUE, type = "semicircle") +
  theme_ggparliament() +
  labs(title = "Russia, 2016") +
  scale_colour_manual(values = ru_semicircle$colour, 
                      limits = ru_semicircle$party_short) 


# Parliament bar
ru_semicircle <- parliament_data(election_data = ru,
                                 type = "semicircle",
                                 parl_rows = 10,
                                 party_seats = ru$seats)

ggplot(ru_semicircle, aes(x = x, y = y, colour = party_short)) +
  geom_parliament_seats() + 
  geom_highlight_government(government == 1) +
  geom_parliament_bar(colour = colour, party = party_long, label = TRUE) +
  draw_majoritythreshold(n = 225, label = TRUE, type = "semicircle") +
  theme_ggparliament() +
  labs(title = "R") +
  scale_colour_manual(values = ru_semicircle$colour, 
                      limits = ru_semicircle$party_short) 


# Labels
ru_semicircle <- parliament_data(election_data = ru,
                                 type = "semicircle",
                                 parl_rows = 10,
                                 party_seats = ru$seats)

ggplot(ru_semicircle, aes(x = x, y = y, colour = party_short)) +
  geom_parliament_seats() + 
  draw_partylabels(type = "semicircle",
                   party_names = party_long,
                   party_seats = seats,
                   party_colours = colour) + 
  draw_totalseats(n = 450, type = "semicircle") +
  theme_ggparliament() +
  labs(title = "Russia, 2016") +
  scale_colour_manual(values = ru_semicircle$colour, 
                      limits = ru_semicircle$party_short)

