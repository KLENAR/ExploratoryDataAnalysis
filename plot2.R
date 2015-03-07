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
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
