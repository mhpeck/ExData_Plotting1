## Plot 3 is a line graph showing each submeter over time 

## First read in data and clean (and filter to relevant date range)
library(dplyr)

ProjectfileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFile <- "HouseholdPowerConsumption.zip"
if(!file.exists(destFile)){
  download.file(ProjectfileURL, destFile, method = "curl")
  unzip(destFile)
}

data <- read.table("household_power_consumption.txt", header = TRUE, sep=";")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- format(strptime(data$Time, "%H:%M:%S"),"%H:%M:%S")

#Filter to relevant date range 
data_filtered <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")
data_filtered$Sub_metering_1 <- as.numeric(data_filtered$Sub_metering_1)
data_filtered$Sub_metering_2 <- as.numeric(data_filtered$Sub_metering_2)
data_filtered$Sub_metering_3 <- as.numeric(data_filtered$Sub_metering_3)

#add datetime column
data_filtered_noNAs$Date <- as.POSIXct(paste(data_filtered_noNAs$Date, data_filtered_noNAs$Time), format="%Y-%m-%d %H:%M:%S")

# Create the plot, one line at a time, and then add a legend
png(filename = "Plot3.png", width = 480, height = 480)
plot(y=data_filtered_noNAs$Sub_metering_1, x=data_filtered_noNAs$Date, type = "l", xlab = "", ylab = "Energy sub metering")
lines(y=data_filtered_noNAs$Sub_metering_2, x=data_filtered_noNAs$Date, type = "l", col = "red")
lines(y=data_filtered_noNAs$Sub_metering_3, x=data_filtered_noNAs$Date, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1, cex=0.8)
dev.off()
