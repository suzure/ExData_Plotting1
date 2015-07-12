########## Plot3 ###########
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

#convert submetrings to num
dt<-transform(dt,Sub_metering_1=as.numeric(Sub_metering_1))
dt<-transform(dt,Sub_metering_2=as.numeric(Sub_metering_2))
dt<-transform(dt,Sub_metering_3=as.numeric(Sub_metering_3))

#plot and save as png
png("plot3.png", width=480, height=480)
plot(x=dt$datetime, y=dt$Sub_metering_1, type = "l", xlab="", ylab = "Energy sub metering")
lines(x=dt$datetime, y=dt$Sub_metering_2, type = "l", col="red")
lines(x=dt$datetime, y=dt$Sub_metering_3, type = "l", col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
dev.off()