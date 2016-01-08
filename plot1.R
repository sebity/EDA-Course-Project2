# Question:
# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

if(!exists("NEI")) {
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# aggregate by sum the total emissions by year for the United States
total_pm <- aggregate(Emissions ~ year, NEI, FUN=sum)

# Open PNG device
png('plot1.png', width = 640, height = 480)

# Plot a barchart
barplot((total_pm$Emissions)/10^5,
        names.arg = total_pm$year,
        xlab = "Year",
        ylab = "PM2.5 Emissions (10^5 Tons)",
        main = "Total Emissions for United States from 1999 to 2008")

# Close the PNG file device
dev.off()
