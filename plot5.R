## This first line will likely take a few seconds. Be patient!
# To avoid unnecessary read.
if (!exists("PM25")) {
    PM25 <- readRDS("summarySCC_PM25.rds") }
if (!exists("SSC")) {
    SSC  <- readRDS("Source_Classification_Code.rds") }
if (!exists("PM25SSC")) {
    PM25SSC <- merge(PM25,SSC,by="SCC") }


# chose the data in Baltimore City, Maryland (fips == "24510") 
subsetPM25SSC <- subset(PM25SSC, PM25SSC$fips=="24510")


## use motor keyword searched, but it seems not accurate.
#motorMatch <- grepl("motor", subsetPM25SSC$Short.Name, ignore.case = T)

## use Data.Category == "Onroad" for motor vehicle source
motorPM25SSC <- subset(subsetPM25SSC, subsetPM25SSC$Data.Category=="Onroad")

motorTotalByYear <- with(motorPM25SSC, tapply(Emissions, year, sum))
motorCountByYear <- summary(as.factor((motorPM25SSC[,6])))
motorMeanByYear  <- with(motorPM25SSC, tapply(Emissions, year, mean))

par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
barplot(motorTotalByYear, 
    main = "Total PM25 Emission",
    xlab = "Year", ylab = "Total PM25 Emission")

barplot(motorCountByYear, 
    main = "PM25 Monitor Count ",
    xlab = "Year", ylab = "Monitor Count")

barplot(motorMeanByYear, 
    main = "PM25 Emission Mean ",
    xlab = "Year", ylab = "PM25 Emission Mean")
mtext("PM25 Emission from motor vehicle source in Baltimore by Year",outer=TRUE)

#dev.copy(png, file = "plot5.png")
#dev.off()

