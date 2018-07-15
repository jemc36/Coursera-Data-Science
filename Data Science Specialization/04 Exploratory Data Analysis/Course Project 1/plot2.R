# Exploratory Data Analysis - Electric Power Consumption
setwd("C:/Users/ychang/Desktop/Other/Johns Hopkins Data Science/Exploratory Data Analysis")
epc <- read.table("household_power_consumption.txt", sep=";", header=T, stringsAsFactors=FALSE, dec=".")

# Convert to Date and Time
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")

# Subset only from "2007-02-01" to "2007-02-02" 
epcdat <- subset(epc, epc$Date >= "2007-02-01" & epc$Date <= "2007-02-02")

# format Date and Time for Weekday
epcdat$weekday <- as.POSIXlt(paste(epcdat$Date,epcdat$Time))

# Plot 2: Line Plot for Global Active Power
png("plot2.png", width=480, height=480)
plot(x=epcdat$weekday, y=epcdat$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
dev.off()