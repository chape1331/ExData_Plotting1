## LOAD DATA
file_path <- file.path("data", "household_power_consumption.txt")
all_data <- read.csv(file_path, sep = ";", 
                 colClasses = c("character", "character", "numeric", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric"), 
                 na.strings = c("?"))

data <- subset(all_data, Date %in% c("1/2/2007", "2/2/2007"))

## CREATE TIMESTAMP COLUMN
library(tidyr)
data <- unite(data, timestamp, c(Date, Time), sep = " ", remove=FALSE)
data$timestamp <- strptime(data$timestamp, format = "%d/%m/%Y %H:%M:%S")


str(data)

## CREATE PLOT
png("plot1.png", width = 480, height = 480, unit = "px")
hist(data$Global_active_power, col = "red", main = "Global Active Power", 
     ylab = "Frequency", xlab = "Global Active Power (kilowatts)")

dev.off()