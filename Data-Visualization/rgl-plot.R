library("rgl")
data(iris)
head(iris)

x <- sep.l <- iris$Sepal.Length
y <- pet.l <- iris$Petal.Length
z <- sep.w <- iris$Sepal.Width

rgl.open() # Open a new RGL device
rgl.points(x, y, z, color ="lightgray") # Scatter plot

# Change the background and point colors
rgl.open()# Open a new RGL device
rgl.bg(color = "white") # Setup the background color
rgl.points(x, y, z, color = "blue", size = 5) # Scatter plot

# Change the shape of points
rgl.open()# Open a new RGL device
rgl.bg(color = "white") # Setup the background color
rgl.spheres(x, y, z, r = 0.2, color = "grey") 

# rgl_init(): A custom function to initialize RGL device
rgl_init <- function(new.device = FALSE, bg = "white", width = 640) { 
  if( new.device | rgl.cur() == 0 ) {
    rgl.open()
    par3d(windowRect = 50 + c( 0, 0, width, width ) )
    rgl.bg(color = bg )
  }
  rgl.clear(type = c("shapes", "bboxdeco"))
  rgl.viewpoint(theta = 15, phi = 20, zoom = 0.7)
}

# Add a bounding box decoration
rgl_init()
rgl.spheres(x, y, z, r = 0.2, color = "yellow")  # Scatter plot
rgl.bbox(color = "#333377") # Add bounding box decoration

rgl_init()
rgl.spheres(x, y, z, r = 0.2, color = "yellow")  
# Add bounding box decoration
rgl.bbox(color=c("#333377","black"), emission="#333377",
         specular="#3333FF", shininess=5, alpha=0.8 ) 

# Add axis lines and labels
# Make a scatter plot
rgl_init()
rgl.spheres(x, y, z, r = 0.2, color = "yellow") 
# Add x, y, and z Axes
rgl.lines(c(min(x), max(x)), c(0, 0), c(0, 0), color = "black")
rgl.lines(c(0, 0), c(min(y),max(y)), c(0, 0), color = "red")
rgl.lines(c(0, 0), c(0, 0), c(min(z),max(z)), color = "green")

# Scale the data
x1 <- (x - min(x))/(max(x) - min(x))
y1 <- (y - min(y))/(max(y) - min(y))
z1 <- (z - min(z))/(max(z) - min(z))
# Make a scatter plot
rgl_init()
rgl.spheres(x1, y1, z1, r = 0.02, color = "yellow") 
# Add x, y, and z Axes
rgl.lines(c(0, 1), c(0, 0), c(0, 0), color = "black")
rgl.lines(c(0, 0), c(0,1), c(0, 0), color = "red")
rgl.lines(c(0, 0), c(0, 0), c(0,1), color = "green")

# Use c(-max, max)
lim <- function(x){c(-max(abs(x)), max(abs(x))) * 1.1}
# Make a scatter plot
rgl_init()
rgl.spheres(x, y, z, r = 0.2, color = "yellow") 
# Add x, y, and z Axes
rgl.lines(lim(x), c(0, 0), c(0, 0), color = "black")
rgl.lines(c(0, 0), lim(y), c(0, 0), color = "red")
rgl.lines(c(0, 0), c(0, 0), lim(z), color = "green")

# lim <- function(x){c(-max(abs(x)), max(abs(x))) * 1.1}
# Make a scatter plot
rgl_init()
rgl.spheres(x, y, z, r = 0.2, color = "yellow") 
# Add x, y, and z Axes
rgl.lines(lim(x), c(0, 0), c(0, 0), color = "black")
rgl.lines(c(0, 0), lim(y), c(0, 0), color = "red")
rgl.lines(c(0, 0), c(0, 0), lim(z), color = "green")

rgl_init()
rgl.spheres(x, y, z, r = 0.2, color = "yellow") 
rgl_add_axes(x, y, z)

# Show scales: tick marks
##The function axis3d() can be used as follow:
rgl_init()
rgl.spheres(x, y, z, r = 0.2, color = "yellow") 
rgl_add_axes(x, y, z)
# Show tick marks
axis3d('x', pos=c( NA, 0, 0 ), col = "darkgrey")
axis3d('y', pos=c( 0, NA, 0 ), col = "darkgrey")
axis3d('z', pos=c( 0, 0, NA ), col = "darkgrey")

rgl_init()
rgl.spheres(x, y, z, r = 0.2, color = "yellow") 
rgl_add_axes(x, y, z, show.bbox = TRUE)



# Create a movie of RGL scene
rgl_init()
rgl.spheres(x, y, z, r = 0.2, color = "#D95F02") 
rgl_add_axes(x, y, z, show.bbox = TRUE)
# Compute and draw the ellipse of concentration
ellips <- ellipse3d(cov(cbind(x,y,z)), 
                    centre=c(mean(x), mean(y), mean(z)), level = 0.95)
wire3d(ellips, col = "#D95F02",  lit = FALSE)
aspect3d(1,1,1)
# Create a movie
movie3d(spin3d(axis = c(0, 0, 1)), duration = 3,
        dir = getwd())