# loading the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="electricity.zip", method = 'curl')
unzip("electricity.zip")

elec <- read.csv("household_power_consumption.txt", header = T, stringsAsFactors = F, sep = ";")

# paste the date and time
elec$DateTime<-paste(elec$Date, elec$Time)
elec_paste<-elec[,-c(1,2)]

# then convert the datetime with strptime() function.
elec_paste$DateTime <- strptime(elec_paste$DateTime, "%d/%m/%Y %H:%M:%S")

# using data from the dates 2007-02-01 and 2007-02-02
electric <- elec_paste[format(elec_paste$DateTime, "%Y-%m-%d") %in% c('2007-02-01', '2007-02-02'),]

# create PNG
png("plot1.png", width = 480, height = 480)

electric$Global_active_power <- as.numeric(electric$Global_active_power)

# create plot
with(electric, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))

# off
dev.off()