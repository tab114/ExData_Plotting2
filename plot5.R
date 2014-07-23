## load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Baltimore emissions from motor vehicle sources
BmorMotor_NEI <- subset(NEI, (NEI$fips=="24510") & (NEI$type=="ON-ROAD"))

## Total Baltimore emissions from motor vehicle sources by year
BmorMotor_NEI_sum <- aggregate(Emissions ~ year, data = BmorMotor_NEI, FUN=sum)


## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
library(ggplot2)
png(file = "plot5.png", width=480, height=480)
ggplot(BmorMotor_NEI_sum, aes(x = factor(year), y=Emissions)) +
  geom_bar(stat="identity", fill = "steelblue") +
  geom_text(mapping = aes(label = round(Emissions)), vjust=-.25, size = 4) +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emission")) +
  ggtitle(expression("PM"[2.5]*" from motor vehicle sources in baltimore"))
dev.off()
