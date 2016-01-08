# Question:
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). Which city has seen greater changes over time in motor
# vehicle emissions?


library(ggplot2)

if(!exists("NEI")) {
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

Baltimore_NEI <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD",]
Baltimore_NEI$City <- "Baltimore City"

California_NEI <- NEI[NEI$fips == "06037" & NEI$type == "ON-ROAD",]
California_NEI$City <- "Los Angeles County"

combined_NEI <- rbind(Baltimore_NEI, California_NEI)

# Open PNG device
png('plot6.png', width = 640, height = 480)

g <- ggplot(combined_NEI, aes(factor(year), Emissions, fill = City))
g <- g + geom_bar(stat = "identity", aes(fill=year)) + theme_bw() + 
  facet_grid(.~City, scales = "free", space = "free") +
  labs(fill = "Years") +
  labs(x="Year", y=expression("Total PM2.5 Emission (Tons)")) +
  labs(title=expression("PM2.5 Emissions for Motor Vehicles in Baltimore and LA from 1999 to 2008"))
print(g)

# Close the PNG file device
dev.off()
