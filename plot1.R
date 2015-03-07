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

## plot the first graph (plot1) to a PNG file and
## place it under your current working directory

png(file="plot1.png")
hist(febData$Global_active_power,col="red",main="Global Active Power",xlab = "Global Active Power (kilowatts)")
dev.off()