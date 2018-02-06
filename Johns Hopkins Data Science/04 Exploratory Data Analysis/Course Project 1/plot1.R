# Exploratory Data Analysis - Electric Power Consumption
setwd("C:/Users/ychang/Desktop/Other/Johns Hopkins Data Science/Exploratory Data Analysis")
epc <- read.table("household_power_consumption.txt", sep=";", header=T, stringsAsFactors=FALSE, dec=".")

# Convert to Date and Time
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")

# Subset only from "2007-02-01" to "2007-02-02" 
epcdat <- subset(epc, epc$Date >= "2007-02-01" & epc$Date <= "2007-02-02")
epcdat$Global_active_power <- as.numeric(epcdat$Global_active_power)

# Plot 1: histogram for Global Active Power
png("plot1.png", width=480, height=480)
hist(epcdat$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()


