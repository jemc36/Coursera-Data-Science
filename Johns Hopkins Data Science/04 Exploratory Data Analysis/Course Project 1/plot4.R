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
epcdat$Global_active_power <- as.numeric(epcdat$Global_active_power)

# Plot 4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(x=epcdat$weekday, y=epcdat$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")

plot(x=epcdat$weekday, y=epcdat$Voltage, xlab="datatime", ylab="Voltage", type="l")

plot(x=epcdat$weekday, y=epcdat$Sub_metering_1, xlab="", ylab="Energing sub metering", col="black", type="l")
lines(x=epcdat$weekday, y=epcdat$Sub_metering_2, type="l", col="red")
lines(x=epcdat$weekday, y=epcdat$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, lwd=2.5, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(x=epcdat$weekday, y=epcdat$Global_reactive_power, xlab="datatime", ylab="Global_reactive_power", type="l")
dev.off()