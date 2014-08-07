# Plot the graphic 2


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

# Making Plot 2
png (file = "plot2.png")  # Open png device, and create "plot2.png" in my wd

# Create the plot and send it to a file
plot (twodaysPower$date_time, twodaysPower$Global_active_power, type = "l",
      xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off ()  # Close the png device

# Note: In the graphic, the words "jue", "vie" and "sáb" in the X axis, are 
# the abbreviated spanish names of thursday, friday and saturday


