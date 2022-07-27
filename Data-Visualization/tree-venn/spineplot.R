# Data 
dat <- apply(Titanic, c(1, 4), sum)

spineplot(dat)

# Transpose the variables
spineplot(t(dat))

# Fill color
spineplot(dat, col = c("#07798D", "#7BCB9F"))

# Border color
spineplot(dat, col = c("#07798D", "#7BCB9F"),
          border = c("#07798D", "#7BCB9F"))

# Spinogram
spineplot(dat, off = 0)
