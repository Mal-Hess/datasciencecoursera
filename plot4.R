require(chron) 

t5rows <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", nrows = 5)
classes <- sapply(t5rows, class)
classes[1] <- "character"
classes[2] <- "character"

mydata <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", colClasses = classes)

subsetdata <- subset(mydata, Date=="1/2/2007" | Date=="2/2/2007") #format for date in original data is dd/mm/yyyy
rm(mydata)

subsetdata$Time <- chron(times=subsetdata$Time)
subsetdata$Date <- as.Date(subsetdata$Date, "%d/%m/%Y")
subsetdata["datetime"] <- as.POSIXct(paste(subsetdata$Date, subsetdata$Time), format= "%Y-%m-%d %H:%M:%S")

par(mfrow=c(2,2))
#first plot
plot(subsetdata$Global_active_power~subsetdata$datetime, type="l", xlab="", ylab="Global Active Power(kilowatts)")
axis(side=2, at=c(0:6))

#second plot
plot(subsetdata$Voltage~subsetdata$datetime, type="l", xlab="datetime", ylab="Voltage")
axis(side=2, at=c(234:246))

#Third plot

plot(subsetdata$Sub_metering_1~subsetdata$datetime, type="n", xlab="", ylab="Energy sub metering")
lines(subsetdata$Sub_metering_1~subsetdata$datetime, type="l", col="black")
lines(subsetdata$Sub_metering_2~subsetdata$datetime, type="l", col="red")
lines(subsetdata$Sub_metering_3~subsetdata$datetime, type="l", col="blue")

legend("topright", lty=c(1,1,1), cex=0.7,  col=c("black","red", "blue"), legend= c("Sub_metering_1", "Sub_metering_2", "Sub_Metering_3"))

#fourth plot
plot(subsetdata$Global_reactive_power~subsetdata$datetime, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file="plot4.png")