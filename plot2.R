## Loading the data from txt file
full_ <- read.csv("C:/Coursera/data/h_power_consumption/household_power_consumption.txt",header = T, sep = ';',                      na.strings = "?", nrows = 2075259, check.names = F, 
                  stringsAsFactors = F, comment.char = "", quote = '\"')
full_$Date <- as.Date(full_$Date, format = "%d/%m/%Y")

## filtering down to the dates we want
data <- subset(full_, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(full_)

## let's convert the strings date to actual date format
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Code to generate Plot Plot 2
plot(data$Global_active_power ~ data$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

## Save plot 2 as .png
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
cat("plot2.png has been saved in", getwd())