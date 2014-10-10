## plot2.R

## Creates plot2.png based on Course Project description

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
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(data$DateTime, data$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()