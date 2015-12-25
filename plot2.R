## This first line will likely take a few seconds. Be patient!
# To avoid unnecessary read.
if (!exists("PM25")) {
    PM25 <- readRDS("summarySCC_PM25.rds") }
if (!exists("SSC")) {
    SSC  <- readRDS("Source_Classification_Code.rds") }

# glance the PM25 data
summary(PM25)

# Chose the data, for Baltimore City, Maryland
# by  (fips == "24510") 
subsetPM25 <- subset(PM25, PM25$fips=="24510", select=c(Emissions,year))

# sum Emissions group by year
TotalByYear <- with(subsetPM25, tapply(Emissions, year, sum))

barplot(TotalByYear, 
        main = "Total PM25 Emission by Year\n in Baltimore City, Maryland", 
        xlab = "Year", ylab = "Total PM25")

rm(subsetPM25)
savePlot("plot2.png")
