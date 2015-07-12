########## Plot1 ###########
# ! data file is suppposed to be in the wd
# ! requires data.table package
library(data.table)

#this is for printing english dates
Sys.setlocale("LC_TIME", "C")

#load txt with "?" as na
#before fread() replaces "?" with NA it recognises every column as "character"
dt<-fread("household_power_consumption.txt",na.strings = "?")

#convert dates (as.Date is for the sake of speed)
dt[,datetime:=as.Date(dt$Date,format = "%d/%m/%Y")]
#subset rows with dates 2007-02-01 and 2007-02-02
dt<-dt[dt$datetime=="2007-02-01" | dt$datetime=="2007-02-02",]
#convert dates to datetime
dt[,datetime:=as.POSIXct(paste(dt$Date,dt$Time,sep = "-"),format="%d/%m/%Y-%H:%M:%S")]

#convert gap,grp,subs,voltage
dt<-transform(dt,Global_active_power=as.numeric(Global_active_power))
dt<-transform(dt,Global_reactive_power=as.numeric(Global_reactive_power))
dt<-transform(dt,Sub_metering_1=as.numeric(Sub_metering_1))
dt<-transform(dt,Sub_metering_2=as.numeric(Sub_metering_2))
dt<-transform(dt,Sub_metering_3=as.numeric(Sub_metering_3))
dt<-transform(dt,Voltage=as.numeric(Voltage))

#plot 4 and save as 1 png
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

#1. Global_active_power
plot(x=dt$datetime, y=dt$Global_active_power, type = "l", xlab="", ylab = "Global Active Power (kilowatts)")
#2. Voltage
plot(x=dt$datetime, y=dt$Voltage, type = "l", xlab="datetime", ylab = "Voltage")
#3. Three submetrings
plot(x=dt$datetime, y=dt$Sub_metering_1, type = "l", xlab="", ylab = "Energy sub metering")
lines(x=dt$datetime, y=dt$Sub_metering_2, type = "l", col="red")
lines(x=dt$datetime, y=dt$Sub_metering_3, type = "l", col="blue")
#3. Legend: 3 lines with titles and colors, no border
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),bty = "n")
#4. Global_reactive_power
plot(x=dt$datetime, y=dt$Global_reactive_power, type = "l", xlab="datetime", ylab = "Global_reactive_power")

dev.off()