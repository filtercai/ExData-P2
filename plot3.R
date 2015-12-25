## This first line will likely take a few seconds. Be patient!
# To avoid unnecessary read.
if (!exists("PM25")) {
    PM25 <- readRDS("summarySCC_PM25.rds") }
if (!exists("SSC")) {
    SSC  <- readRDS("Source_Classification_Code.rds") }

# Chose the data, for Baltimore City, Maryland
# by  (fips == "24510") 
subsetPM25 <- subset(PM25, PM25$fips=="24510", select = c(Emissions, year, type))

# aggregate the data by type and year
TotalByYearType <- aggregate(Emissions ~ type + year, subsetPM25, sum)
meanByYearType  <- aggregate(Emissions ~ type + year, subsetPM25, mean)

library(ggplot2)
source("multiplot.R")

g1 <- ggplot(TotalByYearType, aes(year, Emissions)) + 
    geom_point()+ geom_line() + facet_grid(.~type) +
    xlab("Year") + ylab("Total PM25 Emissions") + 
    ggtitle("Total PM25 Emission by Year and Type\n in Baltimore City, Maryland")

g2 <- ggplot(meanByYearType, aes(year, Emissions)) + 
    geom_point()+ geom_line() + facet_grid(.~type) +
    xlab("Year") + ylab("Mean PM25 Emissions") + 
    ggtitle("Mean PM25 Emission by Year and Type\n in Baltimore City, Maryland")

multiplot(g1,g2)

#ggsave("plot3.png",width=8,height=4)
rm(subsetPM25)
savePlot("plot3.png")

