library(stringr)
library(tidyr)
library(lubridate)
library(DescTools)
library(beepr)

detection_info <- read.csv("detection_info.csv")
counts <- read.csv("image_capuchin_count.csv")
tool_tides_zoe <- read.csv("ZoeGold-tooltides-ee46156/tooltides.csv")
str(detection_info) ##bbox
str(counts)
# note that videos are in orignal data set, need to compare with vids removed in original analysis

##load zoe data

TidesLow <- read.csv("TidesLow.csv")

counts$uniqueloctag <- sapply(str_split(counts$image_name, "__"), "[", 1)
counts$seq_start <- paste(sapply(str_split(counts$image_name, "__"), "[", 2), sapply(str_split(counts$image_name, "__"), "[", 3), " ")
counts$seq_start <- as.POSIXct(sapply(str_split(counts$seq_start, "\\."), "[", 1), tz = "America/Panama", format = "%Y-%m-%d %H-%M-%S")
counts$hour <- hour(counts$seq_start)
counts$month <- month(counts$seq_start)
counts$seasonF <- as.factor(ifelse(counts$month == 12 | counts$month == 1 | counts$month == 2 | counts$month == 3 | 
                                        counts$month == 4, "Dry", "Wet"))

# load TidesLow dataframe for tide times
# subset counts to uniqueloctags %in% tooltides.csv
# counts <- counts[counts$uniqueloctag %in% tool_tides_zoe$uniqueloctag,]
# counts$tidedif <- NA
# for (i in 1:nrow(counts)) {
#      counts$tidedif[i] <- Closest((as.vector(difftime(counts$seq_start[i], TidesLow$TIDE_TIME,   units = "hours"))), 0)
# }
# beep(3)
# 
# str(counts)
# write.csv( counts , "counts_long_calc_tide_bind.csv")

counts2 <- read.csv("counts_long_calc_tide_bind.csv")
# the ones below here get by matching uniqueloctag between counts and tooltides.csv
counts$locationfactor 
counts$dep_length
counts$toolusers
counts$distcoast


