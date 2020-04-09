# Import csv from the root directory
# shpc <- read.table("tidyHouseholdPowerConsumption.csv", 
#                    sep=";", 
#                    header = TRUE, 
#                    colClasses = c('POSIXct',
#                                   'numeric',
#                                   'numeric',
#                                   'numeric',
#                                   'numeric',
#                                   'numeric',
#                                   'numeric',
#                                   'numeric'))

#dateTime <- as.POSIXct(shpc$dateTime) 

# Plot
par(mfrow = c(1, 1))
with(shpc, plot(Global_active_power ~ dateTime, 
                type = "l", 
                main = "Global Active Power", 
                xlab = "", 
                ylab = "Global Active Power (kilowats)"))
dev.copy(png, "./images/plot2.png", height = 480, width = 480)
dev.off()