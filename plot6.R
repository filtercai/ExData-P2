## This first line will likely take a few seconds. Be patient!
# To avoid unnecessary read.

if (!exists("PM25SSC")) {
    if (!exists("PM25")) {
        PM25 <- readRDS("summarySCC_PM25.rds") }
    if (!exists("SSC")) {
        SSC  <- readRDS("Source_Classification_Code.rds") }
    PM25SSC <- merge(PM25,SSC,by="SCC")
    rm(SSC,PM25) }


# Data in Baltimore City, Maryland (fips == "24510") and Los Angeles County, California (fips == "06037"). 
# use Data.Category == "Onroad" for motor vehicle source
motorPM25SSC <- subset(PM25SSC, 
    (PM25SSC$Data.Category=="Onroad" & (PM25SSC$fips=="24510" | PM25SSC$fips=="06037")),
    select=c(fips, Emissions, year))

motorPM25SSC[motorPM25SSC$fips=="24510",]$fips <-"Baltimore"
motorPM25SSC[motorPM25SSC$fips=="06037",]$fips <-"Los Angeles"


motorTotalByYearFips <- 
    aggregate(Emissions ~ fips + year,data=motorPM25SSC, sum)
motorCountByYearFips <- 
    aggregate(!is.na(fips) ~ fips + year,data=motorPM25SSC, sum)
names(motorCountByYearFips)[3] <- "Count"
motorMeanByYearFips <- 
    aggregate(Emissions ~ fips + year,data=motorPM25SSC, mean)


library(ggplot2)
source("multiplot.R")

#png(file="plot6.png",width=600,height=800)
g1 <- ggplot(motorTotalByYearFips, aes(year, Emissions)) +
      geom_point()+ geom_line() + facet_grid(.~fips) +
      xlab("Year") + ylab("Total PM25 Emissions") +
      ggtitle("Total PM25 Emission by Year")

g2 <- ggplot(motorCountByYearFips, aes(year, Count))  +
      geom_point()+ geom_line() + facet_grid(.~fips) +
      xlab("Year") + ylab("Monitor Count") +
      ggtitle("Total PM25 Monitor Count by Year")

g3 <- ggplot(motorMeanByYearFips, aes(year, log10(Emissions))) +
      geom_point()+ geom_line() + facet_grid(.~fips) +
      xlab("Year") + ylab("Log 10 PM25 Emissions Mean") + 
      ggtitle("PM25 Emission Mean (Log10) by Year")

multiplot(g1,g2,g3)

#dev.off()
rm(motorPM25SSC)
savePlot("plot6.png")

