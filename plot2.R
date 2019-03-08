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

## plot2
plot(df$Global_active_power~df$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## saving png
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()