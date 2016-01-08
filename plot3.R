# Question:
# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999–2008 for Baltimore City? Which have seen increases in
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
# answer this question.

library(ggplot2)

if(!exists("NEI")) {
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

Baltimore_NEI <- NEI[NEI$fips == "24510",]

# aggregate by sum the total emissions by year for Baltimore City, Maryland
baltimore_total_pm <- aggregate(Emissions ~ year, Baltimore_NEI, FUN=sum)

# Open PNG device
png('plot3.png', width = 640, height = 480)

g <- ggplot(Baltimore_NEI, aes(factor(year), Emissions, fill = type))
g <- g + geom_bar(stat = "identity", aes(fill=year)) + theme_bw() + 
  facet_grid(.~type, scales = "free", space = "free") +
  labs(fill = "Years") +
  labs(x="Year", y=expression("Total PM2.5 Emission (Tons)")) +
  labs(title=expression("PM2.5 Emissions for Baltimore City from 1999 to 2008 by Source Type"))
print(g)

# Close the PNG file device
dev.off()