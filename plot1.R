# plot1.R

# Get files
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

# Create plot
png("./data/plot1.png", width = 480, height = 480, units = "px")
hist(hpc$gap, col = "red", main = "Global Active Power",
     ylab="Frequency", xlab="Global Active Power (kilowatts)")
dev.off()
