# Survival analysis deals with predicting the time when a specific event is going to occur. 
# It is also known as failure time analysis or analysis of time to death. 
# For example predicting the number of days a person with cancer will survive 
# or predicting the time when a mechanical system is going to fail.

install.packages("survival")

# Load the library.
library("survival")

# Print first few rows.
print(head(pbc))

# Create the survival object. 
survfit(Surv(pbc$time,pbc$status == 2)~1)

# Plot the graph. 
plot(survfit(Surv(pbc$time,pbc$status == 2)~1))
