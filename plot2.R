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

png("plot2.png")
plot(x=plotdata$datetime, y=plotdata$Global_active_power, type="l",
     ylab = "Global Active Power (kilowatts)",
     xlab=NA)
dev.off()
