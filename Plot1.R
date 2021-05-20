## Plot 1 is a histogram of global active power (in kilowatts)

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

#Create plot and export to png
png(filename = "Plot1.png", width = 480, height = 480)
hist(data_filtered_noNAs$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)", ylim = c(0,1200))
dev.off()


