library(CGPfunctions)

df <- newgdp[16:30, ]

newggslopegraph(dataframe = df,
                Times = Year,
                Measurement = GDP,
                Grouping = Country)

# Adding titles
newggslopegraph(df, Year, GDP, Country,
                Title = "GDP evolution",
                SubTitle = "1970-1979",
                Caption = "By R CHARTS")

# Text sizes and justification
newggslopegraph(df, Year, GDP, Country,
                Title = "GDP evolution",
                SubTitle = "1970-1979",
                Caption = "By R CHARTS",
                XTextSize = 18,    # Size of the times
                YTextSize = 2,     # Size of the groups
                TitleTextSize = 14,
                SubTitleTextSize = 12,
                CaptionTextSize = 10,
                TitleJustify = "right",
                SubTitleJustify = "right",
                CaptionJustify = "left",
                DataTextSize = 2.5) # Size of the data

# Reverse axes
newggslopegraph(df, Year, GDP, Country,
                Title = "GDP evolution",
                SubTitle = "1970-1979",
                Caption = "By R CHARTS",
                ReverseYAxis = TRUE,
                ReverseXAxis = FALSE)

# Colors and lines customization

# Line tickness
newggslopegraph(df, Year, GDP, Country,
                Title = "GDP evolution",
                SubTitle = "1970-1979",
                Caption = "By R CHARTS",
                LineThickness = 0.5)

# Line color (one color)
newggslopegraph(df, Year, GDP, Country,
                Title = "GDP evolution",
                SubTitle = "1970-1979",
                Caption = "By R CHARTS",
                LineColor = 4)

# Line color (several colors)
cols <- c("Finland" = "gray", "Canada" = "gray",
          "Italy" = "gray", "US" = "red",
          "Greece" = "gray", "Switzerland" = "gray",
          "Spain" = "green", "Japan" = "gray")

newggslopegraph(df, Year, GDP, Country,
                Title = "GDP evolution",
                SubTitle = "1970-1979",
                Caption = "By R CHARTS",
                LineColor = cols)

# Labels background color
newggslopegraph(df, Year, GDP, Country,
                Title = "GDP evolution",
                SubTitle = "1970-1979",
                Caption = "By R CHARTS",
                DataLabelPadding = 0.2,
                DataLabelLineSize = 0.5,
                DataLabelFillColor = "lightblue")

# Themes

# “ipsum” theme
newggslopegraph(df, Year, GDP, Country,
                Title = "GDP evolution",
                SubTitle = "1970-1979",
                Caption = "By R CHARTS",
                ThemeChoice = "ipsum")

# “econ” theme
newggslopegraph(df, Year, GDP, Country,
                Title = "GDP evolution",
                SubTitle = "1970-1979",
                Caption = "By R CHARTS",
                ThemeChoice = "econ")

# “wsj” theme
newggslopegraph(df, Year, GDP, Country,
                Title = "GDP evolution",
                SubTitle = "1970-1979",
                Caption = "By R CHARTS",
                ThemeChoice = "wsj")

# “gdocs” theme
newggslopegraph(df, Year, GDP, Country,
                Title = "GDP evolution",
                SubTitle = "1970-1979",
                Caption = "By R CHARTS",
                ThemeChoice = "gdocs")

# “tufte” theme
newggslopegraph(df, Year, GDP, Country,
                Title = "GDP evolution",
                SubTitle = "1970-1979",
                Caption = "By R CHARTS",
                ThemeChoice = "tufte")

# theme_grey
newggslopegraph(df, Year, GDP, Country,
                Title = "GDP evolution",
                SubTitle = "1970-1979",
                Caption = "By R CHARTS") +
  theme_gray() +
  theme(legend.position = "none")
