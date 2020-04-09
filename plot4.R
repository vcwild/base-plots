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

# Setting variables

dateTime <- as.POSIXct(shpc$dateTime) 
sub1 <- shpc$Sub_metering_1
sub2 <- shpc$Sub_metering_2
sub3 <- shpc$Sub_metering_3


par(mar = c(4, 4, 2, 1), mfrow = c(2, 2))
with(shpc, {
    plot(Global_active_power~dateTime, 
         type = "l", 
         ylab = "Global Active Power (kW)", 
         xlab = "")
    
    plot(Voltage ~ dateTime, 
         type = "l", 
         ylab = "Voltage (V)", 
         xlab = "")
    
    plot(sub1 ~ dateTime, 
         type = "l", 
         ylab = "Global Active Power (kW)", 
         xlab = "")
    
    lines(sub2 ~ dateTime, col = 'red')
    lines(sub3 ~ dateTime,col = 'blue')
    
    legend("topright", col = c("black", "red", "blue"), 
           lty = 1, 
           lwd = 2, 
           bty = "n",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(Global_reactive_power ~ dateTime, 
         type = "l", 
         ylab = "Global Rective Power (kW)",
         xlab = "")
})

# Saving file
dev.copy(png, file = "./images/plot4.png", height = 480, width = 480)
dev.off()