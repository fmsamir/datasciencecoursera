## The goal of this script is to create a plot using UCI household energy usage
## data. The data pertaining to the relevant dates is read into a data frame,
## adjustments are made to the data, and then a histogram of the global active
## power is created and saved to a PNG file. To read the files, an approximate
## 8.8 megabytes of memory are required.

# The first line of the data is read to extract the column names to label the
# final data frame.
cols <- read.table("./household_power_consumption.txt", header = TRUE, 
                   sep = ";", nrows = 1)
colnames <- names(cols)

# The first column of the data containing dates is read to create an index of
# the dates February 1, 2007 and February 2, 2007.
dates <- read.table("./household_power_consumption.txt", header = TRUE,
                    sep = ";", colClasses = c(NA, rep("NULL", ncol(cols) - 1)))
dateindex <- which(dates == "1/2/2007" | dates == "2/2/2007")

# All rows with the two dates is read for further examination. The date and
# time columns are combined and converted to a POSIXlt time class for future
# ease of plotting.
hpc <- read.table("./household_power_consumption.txt", header = TRUE,
                  sep = ";", skip = dateindex[1] - 1, 
                  nrows = length(dateindex), col.names = colnames)
combdatetime <- paste(hpc$Date, hpc$Time)
datetime <- strptime(combdatetime, format = "%d/%m/%Y %H:%M:%S", 
                     tz = "America/Los_Angeles")
plothpc <- cbind(datetime, hpc[, !names(hpc) %in% c("Date", "Time")])



# A PNG file is created with the required dimensions containing a plot of
# the three sub meterings. A line type and a label for the y-axis is specified,
# along with colors for each of the three sub meterings and a supporting
# legend.
png(file = "plot3.png", width = 480, height = 480, units = "px")
with(plothpc, plot(datetime, Sub_metering_1, type = "l", xlab = "", 
                   ylab = "Energy sub metering"))
with(plothpc, lines(datetime, Sub_metering_2, type = "l", col = "red"))
with(plothpc, lines(datetime, Sub_metering_3, type = "l", col = "blue"))
with(plothpc, legend("topright", lty = c(1, 1, 1), 
                     col = c("black", "red", "blue"), 
                     legend = names(plothpc)
                     [grep("Sub_metering", names(plothpc))]))
dev.off()