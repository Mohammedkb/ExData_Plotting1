## IMPORTANT NOTE BEFORE RUN:
## Please make sure you place the 'unzipped' folder (exdata_data_household_power_consumption)
## under your current working directory. This folder should contain the txt file
## of the household power consumption data. 

## path to the txt file of the household power consumption data
PowerConsumpFiletxt <- "./exdata_data_household_power_consumption/household_power_consumption.txt"

## read the power consumption data into R
powerData<-read.table(PowerConsumpFiletxt,header = TRUE, sep=";",na.strings = "?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

## subset the data to get the 1st & 2nd of Feb 2007 data
febData<-powerData[powerData$Date == "1/2/2007" | powerData$Date == "2/2/2007",]

## combine Date column and Time column into datetime new column then
## convert them to date/time format

febData$datetime<-paste(febData$Date,febData$Time)
febData$datetime<-strptime(febData$datetime,"%d/%m/%Y %H:%M:%S")

## plot the fourth graph (plot4) to a PNG file and
## place it under your current working directory

png(file="plot4.png")

par(mfrow = c(2,2))

with(febData,{
        ## create the top-left plot
        plot(datetime,Global_active_power,type = "l",xlab = "",ylab = "Global Active Power")

        ## create the top-right plot
        plot(datetime,Voltage,type = "l",xlab = "datetime",ylab = "Voltage")

        ## create the bottom-left plot
        plot(datetime,Sub_metering_1,type="l",xlab = "", ylab = "Energy sub metering")
        lines(febData$datetime,febData$Sub_metering_2,type="l",col="red")
        lines(febData$datetime,febData$Sub_metering_3,type="l",col="blue")
        legend("topright",pch=NA,lwd=1,lty=1,bty="n",cex=.9,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

        ## create the bottom-right plot
        plot(datetime,Global_reactive_power,type = "l",xlab = "datetime",ylab = "Global_reactive_power")
})

dev.off()