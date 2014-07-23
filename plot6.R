## load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Baltimore Emissions from motor vehicle sources
BmorMotor_NEI <- subset(NEI, (fips == "24510") & (NEI$type=="ON-ROAD"))
BmorMotor_NEI_sum <- aggregate(Emissions ~ year, data = BmorMotor_NEI, FUN=sum)
BmorMotor_NEI_sum$Country <- "Baltimore City, MD" 

## Los Angeles Emissions from motor vehicle sources
LAmotor_EMI <- subset(NEI, (fips == "06037") & (NEI$type=="ON-ROAD"))
LAmotor_NEI_sum <- aggregate(Emissions ~ year, data = LAmotor_EMI, FUN=sum)
LAmotor_NEI_sum$Country <- "Los Angeles County, CA"

both_EMI <- rbind(BmorMotor_NEI_sum, LAmotor_NEI_sum)


## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037").
## Which city has seen greater changes over time in motor vehicle emissions?
library(ggplot2)
png(file = "plot6.png", width=550, height=650)
ggplot(both_EMI, aes(x = factor(year), y = Emissions)) +
  geom_bar(stat="identity", aes(fill = Country)) + 
  facet_grid(Country  ~ ., scales="free") +
  geom_text(mapping = aes(label = round(Emissions)), vjust=-.25, size = 4) +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emission")) +
  ggtitle(expression("PM"[2.5]*" from motor vehicle sources in baltimore"))
dev.off()
