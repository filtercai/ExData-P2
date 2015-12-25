
## This first line will likely take a few seconds. Be patient!
# To avoid unnecessary read.
if (!exists("PM25")) {
    PM25 <- readRDS("summarySCC_PM25.rds") }
if (!exists("SSC")) {
    SSC  <- readRDS("Source_Classification_Code.rds") }

# glance the PM25 data
#summary(PM25)

# Chose the data, for Baltimore City, Maryland
# by  (fips == "24510") 
subsetPM25 <- subset(PM25, PM25$fips=="24510")

# aggregate the data by type and year
TotalByYearType <- aggregate(Emissions ~ type + year, subsetPM25, sum)
summary(TotalByYearType)


library(ggplot2)

g <- ggplot(TotalByYearType, aes(year, Emissions))  + geom_point()+ geom_line() + facet_grid(.~type) 
g <- g + xlab("Year") + ylab("Total PM25 Emissions")
g <- g + ggtitle("Total PM25 Emission by Year and Type\n in Baltimore City, Maryland")

print(g)

#ggsave("plot3.png",width=8,height=4)

