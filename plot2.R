# Question:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make 
# a plot answering this question.

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
png('plot2.png', width = 640, height = 480)

# Plot a barchart
barplot(baltimore_total_pm$Emissions,
        names.arg = baltimore_total_pm$year,
        xlab = "Year",
        ylab = "PM2.5 Emissions (Tons)",
        main = "Total Emissions for Baltimore City from 1999 to 2008")

# Close the PNG file device
dev.off()