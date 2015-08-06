# plot3.R

# Get fiels
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/HouseholdPowerConsumption.zip", method="libcurl")
unzip ("./data/household_power_consumption.zip", exdir = "./data")

# Process data
hpc <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";",
                  col.names = c("date", "time", "gap", "grp", "voltage", "gi", "subm1", "subm2", "subm3"),
                  na.strings = "?", stringsAsFactors = FALSE)
dates <- c("1/2/2007", "2/2/2007")
hpc <- hpc[hpc$date %in% dates, ]
hpc <- within(hpc, { datetime=strptime(paste(date, time), "%d/%m/%Y %H:%M:%S") })

# Create plots
png("./data/plot3.png", width = 480, height = 480, units = "px")
lims=range(c(hpc$subm1, hpc$subm2, hpc$subm3))
plot(hpc$datetime, hpc$subm1, typ = "l", ylab="Energy sub metering", xlab="", ylim=lims)
lines(hpc$datetime, hpc$subm2, col = "red")
lines(hpc$datetime, hpc$subm3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), col = c("black", "red", "blue"))
dev.off()
