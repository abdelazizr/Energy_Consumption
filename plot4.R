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

## plot all 4 plots on same png
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data, {
  plot(Global_active_power ~ Datetime, type = "l", 
       ylab = "Global Active Power", xlab = "")
  plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
       xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ Datetime, type = "l", 
       ylab = "Global_rective_power", xlab = "datetime")
})

## save plot as png
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
cat("plot4.png has been saved in", getwd())