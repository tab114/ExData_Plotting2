## load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## total PM2.5 emission from all sources grouped by year
sum_emissions <- aggregate(Emissions ~ year, data = NEI, sum)

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
png(file = "plot1.png", width=480, height=480)
bp <- barplot(height = sum_emissions$Emissions, names.arg = sum_emissions$year,
        xlab = "Years", ylab = expression(paste("Total  ",PM [2],"  Emission")),
        main = expression(paste("Total Emissions from ", PM[2]," decreased in the U.S.")))
text(x = bp, y = sum_emissions$Emissions, labels = round(sum_emissions$Emissions, digits = 0), cex=1, pos=1)
dev.off()
