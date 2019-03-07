# load data
dat <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(dat) <- c("date", "time", "activepower_khz", "reactivepoewr_khz", "voltage", "intensity", "submeter1", "submeter2", "submeter3")
datsub <- subset(dat,dat$date=="1/2/2007" | dat$date =="2/2/2007")

# reformat date variable
datsub$Date <- as.Date(datsub$date, format="%d/%m/%Y")

#reformat time variable
datsub$Time <- strptime(datsub$time, format="%H:%M:%S")

# create merged time column date + time
datsub[1:1440,"time"] <- format(datsub[1:1440,"time"],"2007-02-01 %H:%M:%S")
datsub[1441:2880,"time"] <- format(datsub[1441:2880,"time"],"2007-02-02 %H:%M:%S")

# plot
png("plot2.png", width = 480, height = 480)
plot(datsub$Time,as.numeric(as.character(datsub$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)", main = "Global Active Power Vs Time")
dev.off()