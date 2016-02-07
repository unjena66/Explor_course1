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

# convert data type of global active power
electric$Global_active_power <- as.numeric(electric$Global_active_power)

# create PNG

png("plot4.png", width = 480, height = 480)

# create plot
par(mfrow = c(2,2))
with(electric, plot(DateTime,Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power'))
with(electric, plot(DateTime,Voltage, type = 'l', xlab = 'datetime', ylab = 'Voltage'))
with(electric, plot(DateTime, Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy sub metering'))
with(electric, lines(DateTime, Sub_metering_2, col = 'red'))
with(electric, lines(DateTime, Sub_metering_3, col = 'blue'))
legend('topright', lwd = 1, col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
with(electric, plot(DateTime,Global_reactive_power, type = 'l', xlab = 'datetime'))



# off
dev.off()