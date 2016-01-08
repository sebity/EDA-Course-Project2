# Question:
# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

library(ggplot2)

if(!exists("NEI")) {
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# extract combustion related data
combustion_related <- grepl("Comb", SCC$SCC.Level.One, ignore.case = TRUE)

# extract coal related data
coal_related <- grepl("Coal", SCC$SCC.Level.Four, ignore.case = TRUE)

# combine combustion and coal related data
combustion_coal <- (combustion_related & coal_related)
combustion_scc <- SCC[combustion_coal,]$SCC

# extract data from NEI based on SCC related data filtered by Combustion and Coal
combustion_nei <- NEI[NEI$SCC %in% combustion_scc,]

# Open PNG device
png('plot4.png', width = 640, height = 480)

g <- ggplot(combustion_nei, aes(factor(year), (Emissions/10^4)))
g <- g + geom_bar(stat = "identity", aes(fill=year)) + theme_bw() +
  labs(fill = "Years") +
  labs(x="Year", y=expression("Total PM2.5 Emission (10^4 Tons)")) +
  labs(title=expression("PM2.5 Coal Combustion Emissions for United States from 1999 to 2008"))
print(g)

# Close the PNG file device
dev.off()