
library(tidyr)
library(dplyr)
library(lubridate)

# read data
colNames <- c("date", "time", "activepower_khz", "reactivepoewr_khz", "voltage", "intensity", "submeter1", "submeter2", "submeter3")
dat <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", skip = 1)
colnames(dat) <- colNames

# reformat date column
dat$date <- dmy(dat$date)

# subset desired dates: 2007-02-01 and 2007-02-02
dat2 <- dat[dat$date == "2007-02-01" | dat$date == "2007-02-02",]

# generate plot
png("plot1.png", width = 480, height = 480)
hist(dat2$activepower_khz, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
