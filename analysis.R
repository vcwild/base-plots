# Preview of "household_power_consumption.txt" size:
# nrows <- 2075259
# ncols <- 9
# memoryBytes <- nrows * ncols * 8
# print(memoryBytes)

# Setting the search interval
initialDate <- as.Date("01/02/2007", format = "%d/%m/%Y")
finalDate <- as.Date("02/02/2007", format = "%d/%m/%Y")

# Loading the data into data variable
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


# object.size(hpc)
# str(hpc$Date)
# class(hpc$Date)

# Remove NAs
hpc <- hpc[complete.cases(hpc),]

hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")

# head(hpc$Date)

# Subsetting the raw data into date interval
shpc <- subset(hpc, Date >= initialDate & Date <= finalDate)

# Combining Date and Time columns into a vector
dateTime <- paste(shpc$Date, shpc$Time)
dateTime <- setNames(dateTime, "DateTime")
dateTime <- as.POSIXct(dateTime)

# Removing Date and Time from data frame and adding dateTime as substitute
shpc <- shpc[ ,!(names(shpc) %in% c("Date","Time"))]

shpc <- cbind(dateTime, shpc)

# Checking new dataframe
# head(shpc$Date)
# tail(shpc$Date)

# Removing old dataframe cache

# rm(hpc)


# str(shpc)

write.csv(shpc, "tidyHouseholdPowerConsumption.csv")