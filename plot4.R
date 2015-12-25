## This first line will likely take a few seconds. Be patient!
# To avoid unnecessary read.
if (!exists("PM25SSC")) {
    if (!exists("PM25")) {
        PM25 <- readRDS("summarySCC_PM25.rds") }
    if (!exists("SSC")) {
        SSC  <- readRDS("Source_Classification_Code.rds") }
    #merge the PM25 and SSC with 
    PM25SSC <- merge(PM25,SSC,by="SCC") 
    rm(PM25, SSC)}


coalMatch <- grepl("coal", PM25SSC$Short.Name, ignore.case = T)

coalPM25 <- PM25SSC[coalMatch,]

coalTotalByYear <- with(coalPM25, tapply(Emissions, year, sum))

barplot(coalTotalByYear, 
        main = "Total PM25 Emission from coal combustion-related source by Year",
        xlab = "Year", ylab = "Total PM25")

#remove to save mem
rm(coalMatch, coalPM25, coalTotalByYear)
savePlot("plot4.png")

