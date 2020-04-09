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

# Setting main variables
dateTime <- as.POSIXct(shpc$dateTime) 
sub1 <- shpc$Sub_metering_1
sub2 <- shpc$Sub_metering_2
sub3 <- shpc$Sub_metering_3

# Plot
par(mfrow = c(1, 1))
with(shpc, {
    plot(sub1 ~ dateTime, type = "l", ylab = "Global Active Power (kW)", xlab = "")
    lines(sub2 ~ dateTime, col = "red")
    lines(sub3 ~ dateTime, col = "blue")
})
legend("topright", col = c("black", "red", "blue"), lwd = 1, 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Saving file
dev.copy(png, file="./images/plot3.png", height=480, width=480)
dev.off()

