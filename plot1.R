# Import csv from the root directory
# shpc <- read.table("tidyHouseholdPowerConsumption.csv", 
#                  sep=";", 
#                  header = TRUE, 
#                  colClasses = c('POSIXct',
#                                 'numeric',
#                                 'numeric',
#                                 'numeric',
#                                 'numeric',
#                                 'numeric',
#                                 'numeric',
#                                 'numeric'))

# Create histogram & see current device
par(mfrow = c(1, 1))
hist(shpc$Global_active_power, 
     xlab = "Global Active Power (kilowats)", 
     main = "Global Active Power", 
     col = "red") 
# dev.cur()

# Saving the plot and closing the device
dev.copy(png, "./images/plot1.png", height = 480, width = 480); 
dev.off()