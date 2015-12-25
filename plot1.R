## This first line will likely take a few seconds. Be patient!
# To avoid unnecessary read.
if (!exists("PM25")) {
    PM25 <- readRDS("summarySCC_PM25.rds") }
if (!exists("SSC")) {
    SSC  <- readRDS("Source_Classification_Code.rds") }

# glance the PM25 data
summary(PM25)

# sum Emissions group by year
TotalByYear <- with(PM25, tapply(Emissions, year, sum))

barplot(TotalByYear, main = "Total PM25 Emission by Year", 
        xlab = "Year", ylab = "Total PM25")

savePlot("plot1.png")
