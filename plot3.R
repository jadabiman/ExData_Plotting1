
# loading data
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subpower <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

# reformat date variable
datsub$Date <- as.Date(datsub$date, format="%d/%m/%Y")

#reformat time variable
datsub$Time <- strptime(datsub$time, format="%H:%M:%S")

# create merged time column date + time
datsub[1:1440,"time"] <- format(datsub[1:1440,"time"],"2007-02-01 %H:%M:%S")
datsub[1441:2880,"time"] <- format(datsub[1441:2880,"time"],"2007-02-02 %H:%M:%S")

# building the plot
png("plot3.png", width = 480, height = 480)
plot(subpower$Time,subpower$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
# SUB METER 1
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_1))))
# add SUB METER 2 (red)
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
# add SUB METER 3 (blue)
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
# create legend
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# add title
title(main="Energy sub-metering")
dev.off()