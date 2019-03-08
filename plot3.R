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

## plot3
dev.off()
with(df, plot(Sub_metering_1~dateTime, type="l", col="black", xlab="", ylab="Energy sub metering"))
with(df, lines(Sub_metering_2~dateTime, col="red") )
with(df, lines(Sub_metering_3~dateTime, col="blue") )
legend("topright", col=c("black", "red", "blue"), text.width=50999, y.intersp=0.2, x.intersp=2, lty=1, lwd=2, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## saving png
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()