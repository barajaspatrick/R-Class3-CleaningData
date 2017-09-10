## download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "GDP.csv")
## download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "ED.csv")

library(data.table)
library(dplyr)

coln <- c("CountryCode", "Rank", "Economy", "Total")

## select the first 190 rowa of countries
gdp <- fread("GDP.csv", skip = 4, nrow = 190, select = c(1, 2, 4, 5), col.names = coln)
## we will organize the table by gdp
ed <- fread("ED.csv")                                        

mergeDat <-  merge(ed, gdp, by = "CountryCode")
## we code by country code because this is the one with 190 rows

print(nrow(mergeDat))

## arange data by gdp rank
mergeDat <- arrange(mergeDat, desc(Rank))

## create two tables based on income level
highinc <- filter(mergeDat, mergeDat$`Income Group` == "High income: OECD")
lowinc <- filter(mergeDat, mergeDat$`Income Group` == "High income: nonOECD")

mean(highinc$Rank)
mean(lowinc$Rank)


## add row with quartile for seperating later
mergeDat <- mergeDat %>% mutate(quartile = ntile(Rank, 5))

lowmid <- filter(mergeDat, mergeDat$quartile == 1, mergeDat$`Income Group` == "Lower middle income")
print(lowmid)
