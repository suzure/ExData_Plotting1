########## Plot1 ###########
# ! data file is suppposed to be in the wd
# ! requires data.table package
library(data.table)

#load txt with "?" as na
dt<-fread("household_power_consumption.txt",na.strings = "?")
#convert dates
dt[,datetime:=as.Date(dt$Date,format = "%d/%m/%Y")]
#subset rows with dates 2007-02-01 and 2007-02-02
dt<-dt[dt$datetime=="2007-02-01" | dt$datetime=="2007-02-02",]
#convert Global_active_power to num
dt<-transform(dt,Global_active_power=as.numeric(Global_active_power))

#plot and save as png
png("plot1.png", width=480, height=480)
hist(dt$Global_active_power,col="red", main="Global Active Power",xlab = "Global Active Power (kilowatts)",ylab = "Frequency")
dev.off()