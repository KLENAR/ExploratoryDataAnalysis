fileLine <- file("household_power_consumption.txt", "r")
file_MyData <- file("household_power_consumption_MyData.txt", "w")
tag <- c("^[12]/2/2007")
#read headline
reg<- readLines(fileLine, n=1)  
writeLines(reg, file_MyData)

#read and cheek others lines
repeat {
  reg<- readLines(fileLine, n=1)    
  if (length(reg) == 0) break
  if (regexec(tag, reg) < 1) next
  writeLines(reg, file_MyData)
}
close(fileLine);close(file_MyData)

dataFile <- "household_power_consumption_MyData.txt"
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

globalActivePower <- as.numeric(data$Global_active_power)

subMetering1 <- as.numeric(data$Sub_metering_1)
subMetering2 <- as.numeric(data$Sub_metering_2)
subMetering3 <- as.numeric(data$Sub_metering_3)
png("plot3.png", width=480, height=480)
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()
