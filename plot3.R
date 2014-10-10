## plot3.R

## Creates plot3.png based on Course Project description

## Load required packages
library(sqldf)
library(dplyr)

## Read relevant rows from data table. The data file must be in the working directory
## to load.
data <- read.csv.sql("household_power_consumption.txt", 
                     sql = "SELECT * from file WHERE Date in ('1/2/2007','2/2/2007')", 
                     sep = ";", 
                     header = TRUE)

## Add new column that combines Date and Time for plotting

data <- mutate(data, DateTime = paste(Date, Time, sep = ' '))
data$DateTime <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")


## Plot line graph to png in working directory
png(filename = "plot3.png", width = 480, height = 480, units = "px")
with(data, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "", yaxt = "n", 
                ylim = c(0,40)))
par(new = TRUE)
with(data, plot(DateTime, Sub_metering_2, type = "l", xlab = "", ylab = "",
                col = "red", yaxt = "n", ylim = c(0,40)))
par(new = TRUE)
with(data, plot(DateTime, Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering",
                col = "blue", yaxt = "n", ylim = c(0,40)))
par(new = TRUE)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))
par(new = TRUE)
axis(2, at = c(0, 10, 20, 30))

dev.off()