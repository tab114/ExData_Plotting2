## load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## emissions from PM2.5 decreased in Baltimore City, Maryland
bmore_NEI <- subset(NEI, fips == "24510")

## total emissions
sum_bmore <- aggregate(Emissions ~ year, data = bmore_NEI, sum)

png(file = "plot2.png", width=480, height=480)
barplot(height = sum_bmore$Emissions, names.arg = sum_bmore$year,
        xlab="Years", ylab=expression(paste("Total  ",PM [2],"  Emission")),
        main=expression(paste("Total Emissions from ", PM[2]," decreased in Baltimore")))
text(x = bp, y = sum_bmore$Emissions, labels = round(sum_bmore$Emissions, digits = 0), cex=1, pos=1)
dev.off()