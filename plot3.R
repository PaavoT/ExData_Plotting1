
#setwd("D:/coursera/ExData_Plotting1")
#URL      <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#setInternet2(use = TRUE) # https requirement on Windows
#destfile <- "exdata_data_household_power_consumption.zip"
#download.file(URL, destfile, mode="wb") # binary file
#unzip("exdata_data_household_power_consumption.zip")


# Read the data file. In this file missing values are coded as "?".
DT <- read.csv("household_power_consumption.txt", na.strings="?", sep=";")
# Convert datatype from "Factor" to "Date".
DT[, "Date"]  <- as.Date(DT[, "Date"], "%d/%m/%Y") 
# Use only data from the dates 2007-02-01 and 2007-02-02.
DT <- subset(DT,Date>="2007-02-01" & Date<="2007-02-02")
# We want to see the day of the week in English: locale "C" reflects North-American usage.
Sys.setlocale(category = "LC_ALL", locale = "C")
DT$weekday <- as.factor(weekdays(as.Date(DT$Date)))
DT$weekday <- factor(DT$weekday, 
  levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
DT$weekday_no <- as.numeric(DT$weekday)
day <- levels(DT$weekday)

day_name1 <- substr(day[min(DT$weekday_no)+0], 1, 3)
day_name2 <- substr(day[max(DT$weekday_no)+0], 1, 3)
day_name3 <- substr(day[max(DT$weekday_no)+1], 1, 3)

# Open PNG file
png(filename = "plot3.png", width = 480, height = 480, units = "px")
# Make the plot
plot(DT$Sub_metering_1, type="l", ylab="Energy sub metering", xaxt = "n", xlab="", col="black")
with(DT,points(Sub_metering_2, type="l", col="red"))
with(DT,points(Sub_metering_3, type="l", col="blue"))
axis(side = 1, at = c(0,nrow(DT)/2,nrow(DT)), labels = c(day_name1,day_name2,day_name3))
legend("topright", lwd = 2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Close the PNG file
dev.off()
