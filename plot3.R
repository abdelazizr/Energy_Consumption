## Loading the data from txt file
full_ <- read.csv("/Coursera/data/h_power_consumption/household_power_consumption.txt",header = T, sep = ';',                      na.strings = "?", nrows = 2075259, check.names = F, 
                  stringsAsFactors = F, comment.char = "", quote = '\"')
full_$Date <- as.Date(full_$Date, format = "%d/%m/%Y")

## filtering down to the dates we want
data <- subset(full_, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(full_)

## let's convert the strings date to actual date format
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

#plot and generate png for plot 3
with(data, {
  plot(Sub_metering_1 ~ Datetime, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})

legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
cat("plot3.png has been saved in", getwd())