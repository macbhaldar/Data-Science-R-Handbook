## Introduction
ggplot2 is a powerful and a flexible R package, implemented by Hadley Wickham, for producing elegant graphics.

The concept behind ggplot2 divides plot into three different fundamental parts: Plot = data + Aesthetics + Geometry.

The principal components of every plot can be defined as follow:
- data is a data frame
- Aesthetics is used to indicate x and y variables. It can also be used to control the color, the size or the shape of points, the height of bars, etc…..
- Geometry defines the type of graphics (histogram, box plot, line plot, density plot, dot plot,…)

There are two major functions in ggplot2 package: qplot() and ggplot() functions.
- qplot() stands for quick plot, which can be used to produce easily simple plots.
- ggplot() function is more flexible and robust than qplot for building a plot piece by piece.
