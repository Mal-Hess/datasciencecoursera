#require(chron) don't need this for this chart

t5rows <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", nrows = 5)
classes <- sapply(t5rows, class)
classes[1] <- "character"
classes[2] <- "character"

mydata <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", colClasses = classes)

subsetdata <- subset(mydata, Date=="1/2/2007" | Date=="2/2/2007") #format for date in original data is dd/mm/yyyy
rm(mydata)

#subsetdata$Time <- chron(times=subsetdata$Time)  

hist(subsetdata$Global_active_power, freq=TRUE, col="red", main="Global Active Power", xlab="Global Active Power(kilowatts)")
dev.copy(png, file="plot1.png")
