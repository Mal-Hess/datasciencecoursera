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

plot(subsetdata$Global_active_power~subsetdata$datetime, type="l", xlab="", ylab="Global Active Power(kilowatts)")
axis(side=2, at=c(0:6))


dev.copy(png, file="plot2.png")
