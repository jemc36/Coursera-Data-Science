# Exploratory Data Analysis - Electric Power Consumption
library(reshape2)

setwd("C:/Users/ychang/Desktop/Other/Johns Hopkins Data Science/Exploratory Data Analysis")
epc <- read.table("household_power_consumption.txt", sep=";", header=T, stringsAsFactors=FALSE, dec=".")

# convert to Date and Time
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")

# Subset only from "2007-02-01" to "2007-02-02" 
epcdat <- subset(epc, epc$Date >= "2007-02-01" & epc$Date <= "2007-02-02")

# format Date and Time for Weekday
epcdat$weekday <- as.POSIXct(paste(epcdat$Date,epcdat$Time))

# Plot 3: Line Plot for Energy sub metering
png("plot3.png", width=480, height=480)
plot(x=epcdat$weekday, y=epcdat$Sub_metering_1, xlab="", ylab="Energing sub metering", col="black", type="l")
lines(x=epcdat$weekday, y=epcdat$Sub_metering_2, type="l", col="red")
lines(x=epcdat$weekday, y=epcdat$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, lwd=2.5, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()