## load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## grep coal-combustion related sources
combustion_coal <- SCC[grep("[Cc]omb.*[Cc]oal", SCC$EI.Sector), ]  # "*" means repeated any number of times

## Emissions from coal-combustion related sources
coal_NEI <- NEI[(NEI$SCC %in% combustion_coal$SCC), ]

## total emissions grouped by year
coal_EMI_sum <- aggregate(Emissions ~ year, data = coal_NEI, FUN = sum)


## Across the United States, how have emissions from coal combustion-related sources 
## changed from 1999-2008?
library(ggplot2)
png(file = "plot4.png", width=480, height=480)
ggplot(coal_EMI_sum, aes(x = factor(year), y=Emissions)) +
  geom_bar(stat="identity", fill = "steelblue") +
  geom_text(mapping = aes(label = round(Emissions)), vjust=-.25, size = 4) +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" Emission")) +
  ggtitle(expression("PM"[2.5]*" from coal combustion-related sources"))
dev.off()


