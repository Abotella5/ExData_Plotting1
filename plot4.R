# Plot the graphic 4


# Trying read the txt file faster specifying colClasses and comment.char 
# arguments in read.table function.
#First we find out the classes of the dataset columns
roughData5 <- read.table ( "household_power_consumption.txt", header = TRUE, 
                           sep = ";", na.strings = "?", nrows = 5)
classes <- sapply (roughData5, class)

# Now, we read the dataset        
roughData <- read.table ("household_power_consumption.txt", header = TRUE,
                         sep = ";", na.strings = "?", colClasses = classes, 
                         comment.char = "")

# Subset the "1/2/2007", "2/2/2007" rows in the "twodaysPower" dataset
index <- which (roughData$Date %in% c ("1/2/2007", "2/2/2007"))
twodaysPower <- roughData [index, ]
rm (roughData5, roughData) # Clean the large dataset

# Creating a new Data/time variable. POSIX class
fecha_hora <- paste (twodaysPower$Date, twodaysPower$Time, sep =" ")
twodaysPower$date_time <- strptime (fecha_hora, format = "%d/%m/%Y %H:%M:%S")

# Creating a new Data variable. Date class
twodaysPower$DateP <- as.Date (twodaysPower$Date, format= "%d/%m/%Y")

# Making Plot 4
png (file = "plot4.png")  # Open png device, and create "plot4.png" in my wd

# Create the plot and send it to a file

par (mfrow = c (2, 2))
with (twodaysPower, {
      plot (date_time, Global_active_power, type = "l", xlab = "",
            ylab = "Global Active Power (kilowatts)")
      plot (date_time, Voltage, type = "l")
      plot (date_time, Sub_metering_1, type = "s", xlab = "",
            ylab = "Energy sub metering")
      lines (date_time, Sub_metering_2, type = "s", col = "red")        
      lines (date_time, Sub_metering_3, type = "s", col = "blue")      
      legend ("topright", lty = 1, col = c ("black", "red", "blue"), 
              legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
              bty = "n", cex = 0.7)
      plot (date_time, Global_reactive_power, type = "l")
})

dev.off ()  # Close the png device

# Note: In the graphic, the words "jue", "vie" and "sáb" in the X axis, are 
# the abbreviated spanish names of thursday, friday and saturday