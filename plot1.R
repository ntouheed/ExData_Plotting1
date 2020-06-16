# Script written for producing plot1.png is plot1.R

rm(list = ls()) # To start afresh

setwd("E:/Coursera/04 Exploratory Data Analysis/Week 1/Peer-graded Assignment Course Project 1")

if(!file.exists("./dataProj")){dir.create("./dataProj")}

# Let us download the data for the project:

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url, destfile="./dataProj/dataSet.zip")

# Unzip dataSet to /dataProj directory

unzip(zipfile="./dataProj/dataSet.zip",exdir="./dataProj")

# Let us preserve the headers and three rows for future use and to examine the data trend

threeRow <- read.table("./dataProj/household_power_consumption.txt", header = TRUE, sep = ";", nrows = 3)

timeMins <- difftime("2007-02-01 00:00:00","2006-12-16 17:24:00",units="mins") 

skip = timeMins + 1 # This value is 66637 - there are 66636 (= timeMins) minutes 
                    # before 2007-02-01, and we have one row for each minute, 
                    # one header is also there, so skip 66637 rows 

nrows <- difftime("2007-02-03 00:00:00","2007-02-01 00:00:00",units="mins") 
                                                                # this value is 2880
skip     # Print skip
nrows    # Print nrows

# We are directed to use data from the dates 2007-02-01 and 2007-02-02 (a 2-day period in 
# February, 2007), so we need to skip first 66637 (as calculated above in skip) rows and pick
# next 2880 rows (as calculated above in nrows))

eData <- read.table("./dataProj/household_power_consumption.txt", header = FALSE, sep = ";", skip = skip ,nrows = nrows)

str(eData) # see the nature of the required data

head(eData)  # Make sure that we are starting at 1/2/2007 00:00:00
tail(eData)  # Make sure that we are ending   at 2/2/2007 23:59:00

# Let us combine Date, a Factor with 2 levels "1/2/2007","2/2/2007" and
# Time, a Factor with 1440 levels "00:00:00","00:01:00",.. variables to Date/Time 
# classes in R using the strptime() functions

date <- gsub("200", "", eData[,1]) # Replaces all occurrences of 2007 by 7 
time <- as.character(eData[,2])

dateTime = strptime(paste(date, time), "%d/%m/%y %H:%M:%S") # combine date and time 

names(eData) <- names(threeRow)    # Have meaning full names of the columns

eData <- cbind(eData, dateTime)    # The newly constructed column

head(eData)   # Loot at few initial records
tail(eData)   # Loot at few final records

## Plot 1

png("plot1.png", width=480, height=480)    # Please open the graphic device

hist(eData$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()          # Please close the graphic device

