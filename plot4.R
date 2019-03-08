df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

## formatting date
df$Date <- as.Date(df$Date, "%d/%m/%Y")

## filtering 1 Feb 2007 to 2 Feb 2007
df <- subset(df,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## checking data
head(df)
summary(df)
### No NA's around. So we can continue

## combining date and time
df$dateTime <- as.POSIXct(paste(df$Date, df$Time, sep=" "))

## removing unnecessary old date and time columns
head(df[,-(1:2)])
df <- df[,-(1:2)]

#####

## plot4
dev.off()
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(df, plot(Global_active_power~dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="") )
with(df, plot(Voltage~dateTime, type="l",  ylab="Voltage (volt)", xlab="") )
with(df, plot(Sub_metering_1~dateTime, type="l",  ylab="Global Active Power (kilowatts)", xlab="") )
with(df, lines(Sub_metering_2~dateTime,col='Red') )
with(df, lines(Sub_metering_3~dateTime,col='Blue') )
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
with(df, plot(Global_reactive_power~dateTime, type="l", ylab="Global Rective Power (kilowatts)",xlab="") )


## saving png
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()