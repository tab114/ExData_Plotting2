## load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Emissions from 1999-2008 for Baltimore City
bmore_NEI <- subset(NEI, fips == "24510")

## Total Emissions grouped by year & type
sum_bemissions_yt <- aggregate(Emissions ~ year + type,
                                  data = bmore_NEI,
                                  FUN = sum)

## which of the four sources indicated by the type variable have seen decreases/increases 
## in emissions from 1999-2008 for Baltimore City?
## Plot that answers the question:
library(ggplot2)
png(file = "plot3.png", width=680, height=480)
ggplot(sum_bemissions_yt, aes(x = factor(year), y=Emissions)) +
  geom_bar(stat="identity", aes(fill = type)) +  ## stat="identity": heights of the bars represent values in the data
  facet_grid(. ~ type) +
  geom_text(mapping = aes(label = round(Emissions)), vjust=-.25, size = 4) +
  ## label is a character vector or expression specifying the text to be written
  ## vjust controls vertical position of the text
  xlab("year") +
  ylab(expression("total PM"[2.5]*" Emission")) +
  ggtitle(expression("PM"[2.5]*" emissions in Baltimore City by source types"))
dev.off()




