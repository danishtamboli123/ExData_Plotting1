# Check for if Zip has been Downloaded,else to download.
if(!file.exists("Electricity_Power_Consumptipon.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","Electricity_Power_Consumptipon.zip")
}
# Check for if Zip has been Unzipped,else to unzip.
if(!file.exists("Electricity_Power_Consumptipon")){
  unzip("Electricity_Power_Consumptipon.zip")
}

# Load the Enhanced data.frame library (Aka data.table)
library(data.table)

# Read and store the Household Power Consumption Data.
household_power_consumption <- fread("household_power_consumption.txt")

# Converting charachter representation of Data field in Table to Date of class Date
household_power_consumption$Date <- as.Date(household_power_consumption$Date,'%d/%m/%Y')

# Subsetting the required dates for analysis.
required_hpc <- subset(household_power_consumption,household_power_consumption$Date >= "2007-02-01" & household_power_consumption$Date <= "2007-02-02")


# Load the lubridate library.
library(lubridate)


days <- with(required_hpc,paste(Date,Time))
days <- strptime(days, "%Y-%m-%d %H:%M:%S")

# Plotting The three Engergy Sub metering readings across different Days.
png(width= 480,height = 480,filename = "plot3.png")
with(required_hpc,{
  plot(days,Sub_metering_1,type = "n",ylab = "Energy Sub metering",xlab = "")
  lines(days,Sub_metering_1,col = "black")
  lines(days,Sub_metering_2,col = "red")
  lines(days,Sub_metering_3, col = "blue")
  legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lty = 1)
})
dev.off()