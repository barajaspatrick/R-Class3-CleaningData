## week 4 quiz


## question 1 #################################################################

if(!file.exists("./data")){dir.create("./data")}

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
                destfile = "./data/acsurvey.csv")

acsdf <- read.csv("./data/acsurvey.csv")

library(dplyr)
library(tidyr)
library(data.table)
library(lubridate)

acsdf <- tbl_df(acsdf)

## need to split all the names of data
## frame with a 'wgtp'

dfnames <- names(acsdf)
splitwgtp <- split(dfnames, "wgtp")

splitwgtp[115] ## this is for question #1
# 
# ## this is for selecting all name elements starting with "wgtp"
# wgtplist = dfnames[grep("([wgtp][0-9]*)", dfnames)]
#
###############################################################################

## question 2 #################################################################
 
if(!file.exists("./data2")){dir.create("./data2")}
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile = "./data2/gdp2.csv")

gdp <- read.csv("./data2/gdp2.csv", skip = 4, nrows = 190)
gdp <- tbl_df(gdp)

## removes the commas from the gdp column
gdp$X.4 <- gsub(",", "", gdp$X.4)
gdp$X.4 <- as.numeric(gdp$X.4)

## returns the mean of the gdp column
mean(gdp$X.4)
## should return 377652.4

## question 3 #################################################################

# ## Return number of countries that begin with 'United'
# 
# countryNames <- gdp$X.3
# un <- grepl("^United", countryNames)
# 
# summary(un)
# ## three countries should have "'United' in name"

## question 4 #################################################################

## this code wounds the numer of counties with a fiscal year end in june

if(!dir.exists("./data3")){ dir.create("./data3")}
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile = "./data3/gdp2.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
              destfile = "./data3/edu.csv")

gdp2 <- tbl_df(read.csv("./data3/gdp2.csv", skip = 4, nrow = 190))
edu <- tbl_df(read.csv("./data3/edu.csv"))

names(gdp2)[1] <- "ccode"

mergedat <- merge(gdp2, edu, by.x = "ccode", by.y = "CountryCode")
jun <- grep("Fiscal year end: June", mergedat$Special.Notes)
length(jun)
# 
## question 5  ################################################################

## amazon stock price values

library(quantmod)

amzn = getSymbols("AMZN", auto.assign = FALSE)
sampleTimes = index(amzn)


samp_date <- grepl('2012-*', sampleTimes)

samp_datedf <- subset(sampleTimes, samp_date)

day <- format(samp_datedf, '%A')

## sumber of samples taken in 2012
table(samp_date)

## number of days each sample occured
table(day)
















