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
png("plot3.png", width = 480, height = 480, unit = "px")
plot(data$timestamp, data$Sub_metering_1, type="n", ylab = "Energy sub metering", xlab = "")
lines(data$timestamp, data$Sub_metering_1, type="l", col="black")
lines(data$timestamp, data$Sub_metering_2, type="l", col="red")
lines(data$timestamp, data$Sub_metering_3, type="l", col="blue")
legend("topright", lwd = c(2, 2, 2), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()