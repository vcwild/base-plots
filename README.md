Exploratory Data Analysis
================
> This is an exploratory data analysis on individual household electric
> power consumption by using the [UC Irvine Machine Learning
> Repository](http://archive.ics.uci.edu/ml/index.php)

## Tools Used

- R language compiler
- R base graphic devices

## Files

  - **raw data set**: [Individual household electric power
    consumption](http://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption)
  - **CODEBOOK.md**: step-by-step on how to get from the raw data to the
    tidy data set.
  - **analysis.R**: a script able to process and clean the raw data into a
    fine tidy data set
  - **plotn.R**: the scripts that plot the graphs

### Note

In order for the **analysis.R** script to work, you need to download the
raw data set library and extract as \*.txt file inside the project root
folder.

# Codebook

### Cleaning the Data Set

  - Setting the search interval

<!-- end list -->

    initialDate <- as.Date("01/02/2007", format = "%d/%m/%Y")
    finalDate <- as.Date("02/02/2007", format = "%d/%m/%Y")

  - Loading the data into data variable

<!-- end list -->

    hpc <- read.table(file = "household_power_consumption.txt", 
                    sep=";",
                    na.strings = "?",
                    header = TRUE,
                    colClasses = c('character',
                                   'character',
                                   'numeric',
                                   'numeric',
                                   'numeric',
                                   'numeric',
                                   'numeric',
                                   'numeric',
                                   'numeric'))

    object.size(hpc)
    str(hpc$Date)
    class(hpc$Date)

  - Removing NAs

<!-- end list -->

    hpc <- hpc[complete.cases(hpc),]

  - Interpreting DATE from STRING character

<!-- end list -->

    hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
    
    head(hpc$Date)

  - Subsetting the raw data into date interval

<!-- end list -->

    shpc <- subset(hpc, Date >= initialDate & Date <= finalDate)

  - Combining Date and Time columns into a vector

<!-- end list -->

    dateTime <- paste(shpc$Date, shpc$Time)
    dateTime <- setNames(dateTime, "DateTime")
    dateTime <- as.POSIXct(dateTime)

  - Removing Date and Time from data frame and adding dateTime as
    substitute

<!-- end list -->

    shpc <- shpc[ ,!(names(shpc) %in% c("Date","Time"))]
    
    shpc <- cbind(dateTime, shpc)

  - Checking the new tidy data set

<!-- end list -->

    head(shpc$Date)
    tail(shpc$Date)
    str(shpc)

  - Removing old dataframe cache

<!-- end list -->

    rm(hpc)

  - Saving the tidy data set into a csv file

<!-- end list -->

    write.csv(shpc, "tidyHouseholdPowerConsumption.csv")

### Plotting

#### Plot 1

  - Import csv from the root directory

<!-- end list -->

    shpc <- read.table("tidyHouseholdPowerConsumption.csv", 
                      sep=";", 
                      header = TRUE, 
                      colClasses = c('POSIXct',
                                     'numeric',
                                     'numeric',
                                     'numeric',
                                     'numeric',
                                     'numeric',
                                     'numeric',
                                     'numeric'))

  - Create histogram & see current device

<!-- end list -->

    par(mfrow = c(1, 1))
    hist(shpc$Global_active_power, 
         xlab = "Global Active Power (kilowats)", 
         main = "Global Active Power", 
         col = "red") 
    dev.cur()

  - Saving the plot and closing the device

<!-- end list -->

    dev.copy(png, "./images/plot1.png", height = 480, width = 480); 
    dev.off()

#### Plot 2

  - Import csv from the root directory

<!-- end list -->

``` 
shpc <- read.table("tidyHouseholdPowerConsumption.csv", 
                  sep=";", 
                  header = TRUE, 
                  colClasses = c('POSIXct',
                                 'numeric',
                                 'numeric',
                                 'numeric',
                                 'numeric',
                                 'numeric',
                                 'numeric',
                                 'numeric'))

dateTime <- as.POSIXct(shpc$dateTime) 
```

  - Generate plot

<!-- end list -->

``` 
par(mfrow = c(1, 1))
with(shpc, plot(Global_active_power ~ dateTime, 
                type = "l", 
                main = "Global Active Power", 
                xlab = "", 
                ylab = "Global Active Power (kilowats)"))
                
```

  - Saving the plot and closing the device

<!-- end list -->

    dev.copy(png, "./images/plot2.png", height = 480, width = 480)
    dev.off()

#### Plot 3

  - Import csv from the root directory

<!-- end list -->

    shpc <- read.table("tidyHouseholdPowerConsumption.csv", 
                      sep=";", 
                      header = TRUE, 
                      colClasses = c('POSIXct',
                                     'numeric',
                                     'numeric',
                                     'numeric',
                                     'numeric',
                                     'numeric',
                                     'numeric',
                                     'numeric'))

  - Setting main variables

<!-- end list -->

    dateTime <- as.POSIXct(shpc$dateTime) 
    sub1 <- shpc$Sub_metering_1
    sub2 <- shpc$Sub_metering_2
    sub3 <- shpc$Sub_metering_3

  - Plot

<!-- end list -->

    par(mfrow = c(1, 1))
    with(shpc, {
        plot(sub1 ~ dateTime, type = "l", ylab = "Global Active Power (kW)", xlab = "")
        lines(sub2 ~ dateTime, col = "red")
        lines(sub3 ~ dateTime, col = "blue")
    })
    legend("topright", col = c("black", "red", "blue"), lwd = 1, 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

  - Saving file

<!-- end list -->

    dev.copy(png, file="./images/plot3.png", height=480, width=480)
    dev.off()

#### Plot 4

  - Import csv from the root directory

<!-- end list -->

    shpc <- read.table("tidyHouseholdPowerConsumption.csv", 
                      sep=";", 
                      header = TRUE, 
                      colClasses = c('POSIXct',
                                     'numeric',
                                     'numeric',
                                     'numeric',
                                     'numeric',
                                     'numeric',
                                     'numeric',
                                     'numeric'))

  - Setting variables

<!-- end list -->

    dateTime <- as.POSIXct(shpc$dateTime) 
    sub1 <- shpc$Sub_metering_1
    sub2 <- shpc$Sub_metering_2
    sub3 <- shpc$Sub_metering_3

  - Plotting

<!-- end list -->

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

  - Saving
    file

<!-- end list -->

    dev.copy(png, file = "./images/plot4.png", height = 480, width = 480)
    dev.off()
