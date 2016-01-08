# Question:
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


library(ggplot2)

if(!exists("NEI")) {
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

Baltimore_NEI <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD",]

# aggregate by sum the total emissions by year for Baltimore City, Maryland
baltimore_total_pm <- aggregate(Emissions ~ year, Baltimore_NEI, FUN=sum)

# Open PNG device
png('plot5.png', width = 640, height = 480)

g <- ggplot(Baltimore_NEI, aes(factor(year), Emissions, fill = type))
g <- g + geom_bar(stat = "identity", aes(fill=year)) + theme_bw() + 
  guides(fill = FALSE) +
  labs(x="Year", y=expression("Total PM2.5 Emission (Tons)")) +
  labs(title=expression("PM2.5 Emissions for Motor Vehicles in Baltimore City from 1999 to 2008"))
print(g)

# Close the PNG file device
dev.off()