library(lubridate)

zipfn<-"househol_power_consumption.zip"
if (!file.exists(zipfn)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile=zipfn)
}
raw<-read.table(unz(zipfn, "household_power_consumption.txt"), 
           sep=";", 
           header = TRUE,
           na.strings = "?",
           stringsAsFactors = FALSE)

raw$date<-dmy(raw$Date)
raw$datetime<-dmy_hms(paste(raw$Date, raw$Time))
raw$Date<-NULL
raw$Time<-NULL

plotdata<-raw[raw$date %within% interval(ymd("20070201"),ymd("20070202")),]

png("plot4.png")
par(mfrow=c(2,2))

#1
plot(x=plotdata$datetime, y=plotdata$Global_active_power, type="l",
     ylab = "Global Active Power",xlab=NA)

#2
plot(x=plotdata$datetime, y=plotdata$Voltage, type="l", col="black", xlab="datetime")

#3
plot(x=plotdata$datetime, y=plotdata$Sub_metering_1, 
     type="l", col="black",
     ylab = "Energy sub metering", xlab=NA)
lines(x=plotdata$datetime,y=plotdata$Sub_metering_2,type="l", col="red")
lines(x=plotdata$datetime,y=plotdata$Sub_metering_3,type="l", col="blue")
legend(legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), x="topright", col=c("black","red","blue"), lty=1)

#4
plot(x=plotdata$datetime, y=plotdata$Global_reactive_power, type="l",xlab="datetime")

dev.off()
