library(countrycode)
library(plotly)

rankings.df <- read.csv(paste("resources/world_heatmap/business_rankings.csv", sep=""))
kable(head(rankings.df))

rankings.df$code <- countrycode(rankings.df$Economy,'country.name','iso3c')

rankings.df$avg <- (rankings.df$Ease.of.Doing.Business.Rank+rankings.df$Starting.a.Business+rankings.df$Dealing.with.Construction.Permits+rankings.df$Protecting.Minority.Investors)/4

l <- list(color = toRGB("grey"), width = 0.5)

g <- list(
  showframe = TRUE,
  showcoastlines = TRUE,
  projection = list(type = 'Mercator'))

scale1 <- list(
  visible=TRUE,
  showlegend=FALSE,
  title="Rank",
  reversescale = TRUE
)

p <- plot_geo(rankings.df) %>%
  #Code for plotting the maps for the different attributes.
  add_trace(
    z = ~avg, color = ~avg,name='Average of all Rankings',
    text = ~Economy, locations = ~code, marker = list(line = l),colorbar=list(title='Rank'),visible=TRUE
  ) %>%
  add_trace(
    z = ~Ease.of.Doing.Business.Rank, color = ~Ease.of.Doing.Business.Rank,name='Ease of doing Business',
    text = ~Economy, locations = ~code, marker = list(line = l),colorbar=list(title='Rank'),visible=FALSE
  ) %>%
  add_trace(
    z = ~Starting.a.Business, color = ~Starting.a.Business,name='Starting a  Business',
    text = ~Economy, locations = ~code, marker = list(line = l),colorbar=list(title='Rank'),visible=FALSE
  ) %>%
  add_trace(
    z = ~Dealing.with.Construction.Permits, color = ~Dealing.with.Construction.Permits,name='Dealing with Construction Permits',
    text = ~Economy, locations = ~code, marker = list(line = l),colorbar=list(title='Rank'),visible=FALSE
  ) %>%
  add_trace(
    z = ~Protecting.Minority.Investors, color = ~Protecting.Minority.Investors,name='Protecting Minority Investors',
    text = ~Economy, locations = ~code, marker = list(line = l),colorbar=list(title='Rank'),visible=FALSE
  ) %>% 
  colorbar(title = 'Rank') %>%
  #Code for the dropdown.
  layout(
    title = "Various Business Rankings (Hover over a country for its Rank)",
    geo=g,
    updatemenus = list(
      list(
        buttons = list(
          list(method = "restyle",
               args = list("visible",list(TRUE, FALSE, FALSE, FALSE, FALSE)),
               label = "Average of All Rankings"),
          
          list(method = "restyle",
               args = list("visible", list(FALSE, TRUE, FALSE, FALSE, FALSE)),
               showscale=scale1,
               label = "Ease of Doing Business"),
          
          list(method = "restyle",
               args = list("visible", list(FALSE, FALSE, TRUE, FALSE, FALSE)),
               showscale=scale1,
               label = "Starting a Business"),
          
          list(method = "restyle",
               args = list("visible", list(FALSE, FALSE, FALSE, TRUE, FALSE)),
               showscale=scale1,
               label = "Dealing With Construction Permits"),
          
          list(method = "restyle",
               args = list("visible", list(FALSE, FALSE, FALSE, FALSE, TRUE)),
               showscale=scale1,
               label = "Protecting Minority Investors")
        ))
    ))

p
