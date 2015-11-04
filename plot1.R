
setwd("D:/coursera/ExData_Plotting1")
URL      <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
setInternet2(use = TRUE) # https requirement on Windows
destfile <- "exdata_data_household_power_consumption.zip"
download.file(URL, destfile, mode="wb") # binary file
system("unzip.exe -d ./ -o exdata_data_household_power_consumption.zip")


# Read the data file. In this file missing values are coded as "?".
# NB: fread() has a bug: it does not interpret na.strings correctly.
DT <- read.csv("household_power_consumption.txt", na.strings="?", sep=";")
# Convert datatype from "Factor" to "Date".
DT[, "Date"]  <- as.Date(DT[, "Date"], "%d/%m/%Y") 
# Use only data from the dates 2007-02-01 and 2007-02-02.
DT <- subset(DT,Date>="2007-02-01" & Date<="2007-02-02")
# Open PNG file
png(filename = "plot1.png", width = 480, height = 480, units = "px")
# Make the plot
with(DT, hist(DT$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red"))
# Close the PNG file
dev.off()
