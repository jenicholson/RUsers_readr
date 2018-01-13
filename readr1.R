##############################################
##
## Getting your data into R with readr
## KC R Users Group January Beginners meeting
## 
## Author: Janae.Nicholson@hrblock.com
## Date: January 13, 2017
##
#############################################

library(dplyr)
library(readr)
library(tictoc)

#first the csv.
#the old way, don't do this
setClass("MyDate")
setAs("character", "MyDate", function(from) as.Date(from, format = "%b %d %Y"))
super_bowl1 <- read.csv(file = "Super_Bowl.csv",
                        colClasses = c("MyDate", rep("character", 2),
                                       "numeric", "character", "numeric",
                                       rep("character", 4)),
                        stringsAsFactors = FALSE)

#the readr way
super_bowl2 <- read_csv("Super_Bowl.csv")
spec(super_bowl2)
super_bowl3 <- read_csv(file = "Super_Bowl.csv",
                        skip = 1,
                        col_names = c("Date", "SB", "Winner",
                                      "Winner_Pts", "Loser", "Loser_Pts",
                                      "MVP", "Stadium", "City", "State"),
                        col_types = cols(
                          Date = col_date("%b %d %Y"),
                          SB = col_character(),
                          Winner = col_character(),
                          Winner_Pts = col_integer(),
                          Loser = col_character(),
                          Loser_Pts = col_integer(),
                          MVP = col_character(),
                          Stadium = col_character(),
                          City = col_character(),
                          State = col_character()
                        ))

#read a fixed width file
SST <- read_fwf(
  file = "http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for",   
  col_positions = fwf_widths(c(12, 7, 4, 9, 4, 9, 4, 9, 4), c("Week", "SST12", "SSTA12", "SST3", "SSTA3",
             "SST34", "SSTA34", "SST4", "SSTA4")),
  col_types = cols(
    Week = col_date("%d%b%Y"),
    SST12 = col_double(),
    SSTA12 = col_double(),
    SST3 = col_double(),
    SSTA3 = col_double(),
    SST34 = col_double(),
    SSTA34 = col_double(),
    SST4 = col_double(),
    SSTA4 = col_double()
  ),
  skip = 4)

#read a file
pride_prejudice1 <- read_file(file = "https://www.gutenberg.org/files/1342/1342.txt")
str(pride_prejudice1)
pride_prejudice2 <- read_lines(file = "https://www.gutenberg.org/files/1342/1342.txt")
str(pride_prejudice2)

## reading large files
tic("Read Data with read.csv")
#data from https://s3.amazonaws.com/h2o-airlines-unpacked/airlines_all.05p.csv
airlines1 <- read.csv(file = "C:/Users/janae/Documents/RProj/datasets/airlines_all.05p.csv", 
                     stringsAsFactors = FALSE)
toc()

tic("Read Data with read_csv")
airlines2 <- read_csv(file = "C:/Users/janae/Documents/RProj/datasets/airlines_all.05p.csv")
toc()