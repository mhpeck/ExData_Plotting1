## Plot 2 is a line graph of global active power over time 

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

data_filtered_noNAs <- filter(data_filtered, Global_active_power != "?")
data_filtered_noNAs$Global_active_power <- as.numeric(data_filtered_noNAs$Global_active_power)
#add datetime column
data_filtered_noNAs$Date <- as.POSIXct(paste(data_filtered_noNAs$Date, data_filtered_noNAs$Time), format="%Y-%m-%d %H:%M:%S")

#Create plot and export to png
png(filename = "Plot2.png", width = 480, height = 480)
plot(y=data_filtered_noNAs$Global_active_power, x = data_filtered_noNAs$Date, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()


