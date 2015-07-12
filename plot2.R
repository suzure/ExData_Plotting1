########## Plot2 ###########
# ! data file is suppposed to be in the wd
# ! requires data.table package
library(data.table)

#this is for printing english dates.
Sys.setlocale("LC_TIME", "C")

#load txt with "?" as na. 
#before fread() replaces "?" with NA it recognises every column as "character"
dt<-fread("household_power_consumption.txt",na.strings = "?")

#convert dates (as.Date is for the sake of speed)
dt[,datetime:=as.Date(dt$Date,format = "%d/%m/%Y")]
#subset rows with dates 2007-02-01 and 2007-02-02
dt<-dt[dt$datetime=="2007-02-01" | dt$datetime=="2007-02-02",]
#convert dates to datetime
dt[,datetime:=as.POSIXct(paste(dt$Date,dt$Time,sep = "-"),format="%d/%m/%Y-%H:%M:%S")]

#convert Global_active_power to num
dt<-transform(dt,Global_active_power=as.numeric(Global_active_power))

#plot and save as png
png("plot2.png", width=480, height=480)
plot(x=dt$datetime, y=dt$Global_active_power, type = "l", xlab="", ylab = "Global Active Power (kilowatts)")
dev.off()