# Reading, naming and subsetting power consumption data
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


# create 2x2 area for multiple graphs
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
with(subpower,{
  # build active power in top left (similar to plot2)
  plot(subpower$Time,as.numeric(as.character(subpower$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  # build voltage in top right
  plot(subpower$Time,as.numeric(as.character(subpower$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  # build submeter (similar to plot3) with legend in bottom left
  plot(subpower$Time,subpower$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(subpower,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(subpower,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(subpower,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  # build reactive in bottom right
  plot(subpower$Time,as.numeric(as.character(subpower$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})
dev.off()