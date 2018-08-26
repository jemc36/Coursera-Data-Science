##########################################################################
######                        WEEK 4 Quiz                            #####
##########################################################################
##  The data are measured at a network of federal, state, and local     ##
##  monitors and assembled by the EPA. In this dataset,                 ##
## the "Arithmetic Mean" column provides the level of the indicated     ##
## chemical constituent and the "Parameter.Name" column provides the    ##
## name of the chemical constituent. The combination of a "State Code"  ##
## a "County Code", and a "Site Num", uniquely identifies a monitoring  ##
## site (the location of which is provided by the "Latitude" and        ##
## "Longitude" columns).                                                ##
##########################################################################

install.packages(c("dplyr", "tidyr", "readr", "readxl"))
library(dplyr)
library(tidyr)
library(readr)
library(readxl)
library(stringr)

setwd("C:/Users/ychang/Desktop/R/The R Programming Environment")
daily_spec <- read_csv("daily_SPEC_2014.csv.bz2")
names(daily_spec)
head(daily_spec)

## Question 1: What is average Arithmetic.Mean for "Bromine PM2.5 LC" 
## in the state of Wisconsin in this dataset?

q1 <- daily_spec %>%
  filter(`State Name` == "Wisconsin" & `Parameter Name` == "Bromine PM2.5 LC") %>%
  summarize(ave_arithmetic_mean = mean(`Arithmetic Mean`, na.rm = TRUE))

# Answer 1: 0.003960482

## Question 2: Calculate the average of each chemical constituent 
## across "all" states, monitoring sites and "all" time points.
## Which constituent Parameter.Name has the highest average level(Arithemtic Mean)?
## Tips from the forum: 
## 1. It looks like not need to group by states, monitoring sites and time points bc across "all" means using all the data.
## 2. Only calculate the pollutant ones which have chemical names

q2 <- daily_spec %>%
  group_by(`Parameter Name`) %>%
  summarize(ave_arithmetic_mean = mean(`Arithmetic Mean`, na.rm = TRUE)) %>%
  arrange(desc(ave_arithmetic_mean))

q2_c <- q2[grepl("PM",q2$`Parameter Name`),]
head(q2_c,1)

# Answer 2: OC CSN Unadjusted PM2.5 LC TOT

## Question 3: Which monitoring site has the highest average level of "Sulfate PM2.5 LC" across all time?
## Indicate the state code, county code, and site number.

daily_spec$Monitor <- paste('State',daily_spec$`State Code`,'County',daily_spec$`County Code`,'Site',daily_spec$`Site Num`)
q3 <- daily_spec %>%
  filter(`Parameter Name` == "Sulfate PM2.5 LC") %>%
  group_by(Monitor) %>%
  summarize(ave_arithmetic_mean = mean(`Arithmetic Mean`, na.rm = TRUE)) %>%
  arrange(desc(ave_arithmetic_mean)) %>% head(1)

# Answer 3: State 39 County 081 Site 0017

## Question 4: What is the absolute difference in the average levels of "EC PM2.5 LC TOR" 
## between the states California and Arizona, across all time and all monitoring sites?

q4 <- daily_spec %>%
  filter(`Parameter Name` == "EC PM2.5 LC TOR" & (`State Name` == "California" | `State Name` == "Arizona" )) %>%
  group_by(`State Name`) %>%
  summarize(ave_arithmetic_mean = mean(`Arithmetic Mean`, na.rm = TRUE)) %>%
  spread(`State Name`,ave_arithmetic_mean) %>%
  mutate(abs_state <- abs(Arizona-California))

# Answer 4: 0.0186

## Question 5: What is the median level of "OC PM2.5 LC TOR" in the western United States, across all time? 
## Define western as any monitoring location that has a Longitude LESS THAN -100.

q5 <- daily_spec %>%
  filter(`Parameter Name` == "OC PM2.5 LC TOR" & Longitude < -100) %>%
  select(`Arithmetic Mean`) %>%
  summary(med_arithmetic_mean = median(`Arithmetic Mean`, na.rm = TRUE))

# The same
q5 <- daily_spec %>%
  filter(`Parameter Name` == "OC PM2.5 LC TOR") %>%
  group_by(Monitor) %>%
  filter(Longitude < -100) %>%
  select(`Arithmetic Mean`,Monitor) %>%
  summary(med_arithmetic_mean = median(`Arithmetic Mean`, na.rm = TRUE))

# Answer 5:  0.430


##########################################################################
## Use the readxl package to read the file aqs_sites.xlsx into R        ##
## (you may need to install the package first). This file contains      ##
## metadata about each of the monitoring sites in the EPA's monitoring  ##
## system. In particular, the "Land Use" and "Location Setting"         ##
## variables contain information about what kinds of areas the monitors ##
## are located in (i.e. "residential" vs. "forest").                    ##
##########################################################################

aqs_sites <- read_excel("aqs_sites.xlsx")
# warning messages -> need to specify col_type 
names(aqs_sites)

## Question 6: How many monitoring sites are labelled as both RESIDENTIAL 
## for "Land Use" and SUBURBAN for "Location Setting"?

q6 <- aqs_sites %>%
  filter(`Land Use` == "RESIDENTIAL" & `Location Setting` == "SUBURBAN") %>%
  nrow()

# Answer 6: 3527

## Question 7: What is the median level of "EC PM2.5 LC TOR" amongst monitoring sites that 
## are labelled as both "RESIDENTIAL" and "SUBURBAN" in the eastern U.S., where eastern is 
## defined as Longitude greater than or equal to -100?

daily_spec$`State Code2` <- as.numeric(daily_spec$`State Code`)
daily_spec$`County Code2` <- as.numeric(daily_spec$`County Code`)
daily_spec$`Site Num2` <- as.numeric(daily_spec$`Site Num`)
daily_spec$Monitor <- paste('State',daily_spec$`State Code2`,'County',daily_spec$`County Code2`,'Site',daily_spec$`Site Num2`)

aqs_sites$Monitor <- paste('State',aqs_sites$`State Code`,'County',aqs_sites$`County Code`,'Site',aqs_sites$`Site Number`)

q7 <- aqs_sites %>%
  filter(`Land Use` == "RESIDENTIAL" & `Location Setting` == "SUBURBAN" & Longitude >= -100)

q77 <- inner_join(daily_spec, q7, by="Monitor") %>%
  filter(`Parameter Name` == "EC PM2.5 LC TOR") %>%
  summarise(med_arithmetic_mean = median(`Arithmetic Mean`, na.rm = TRUE))

# Answer 7: 0.610

## Question 8: Amongst monitoring sites that are labeled as COMMERCIAL for "Land Use", 
## which month of the year has the highest average levels of "Sulfate PM2.5 LC"?

q8 <- inner_join(daily_spec, aqs_sites, by="Monitor") %>%
  filter(`Parameter Name` == "Sulfate PM2.5 LC" & `Land Use` == "COMMERCIAL") %>%
  mutate(month = months(`Date Local`)) %>%
  group_by(month) %>%
  summarise(mean_arithmetic_mean = mean(`Arithmetic Mean`, na.rm = TRUE)) %>%
  arrange(desc(mean_arithmetic_mean)) %>%
  head(1)

# Answer 8: February

## Question 9: Take a look at the data for the monitoring site identified by State Code 6, County Code 65, and Site Number 8001 
## (this monitor is in California). At this monitor, for how many days is the sum of "Sulfate PM2.5 LC" and "Total Nitrate PM2.5 LC" 
## greater than 10?
## For each of the chemical constituents, there will be some dates that have multiple `Arithmetic Mean` values at this monitoring
## site. When there are multiple values on a given date, take the average of the constituent values for that date.
# Tip from Forum: find the average values per chemical if that day has multiple values
# then sum two of chemicals
# Code 1:
q9 <- inner_join(daily_spec, aqs_sites, by="Monitor") %>%
  filter((`Parameter Name` == "Sulfate PM2.5 LC" | `Parameter Name` == "Total Nitrate PM2.5 LC") & Monitor == "State 6 County 65 Site 8001") %>%
  group_by(`Parameter Name`,`Date Local`) %>%
  summarise(mean_arithmetic_mean = mean(`Arithmetic Mean`, na.rm = TRUE)) 

q91 <- q9 %>%
  filter(`Parameter Name` == "Sulfate PM2.5 LC")

q92 <- q9 %>%
  filter(`Parameter Name` == "Total Nitrate PM2.5 LC")

q9all <- inner_join(q91,q92,by="Date Local") %>%
  rowwise() %>% mutate(Sum=sum(c(mean_arithmetic_mean.x, mean_arithmetic_mean.y), na.rm=T)) %>%
  filter(Sum > 10) %>%
  nrow()

# Code 2
q922 <- inner_join(daily_spec, aqs_sites, by="Monitor") %>%
  filter((`Parameter Name` == "Sulfate PM2.5 LC" | `Parameter Name` == "Total Nitrate PM2.5 LC") & Monitor == "State 6 County 65 Site 8001") %>%
  group_by(`Parameter Name`,`Date Local`) %>%
  summarise(mean_arithmetic_mean = mean(`Arithmetic Mean`, na.rm = TRUE)) %>%
  group_by(`Date Local`) %>%
  summarise(sum_arithmetic_mean = sum(mean_arithmetic_mean, na.rm = TRUE)) %>%
  filter(sum_arithmetic_mean > 10) %>%
  nrow()

## Question 10: Which monitoring site in the dataset has the highest correlation between "Sulfate PM2.5 LC" and "Total Nitrate PM2.5 LC" 
## across all dates? Identify the monitoring site by it's State, County, and Site Number code.
## For each of the chemical constituents, there will be some dates that have multiple Sample.Value's at a monitoring site. 
## When there are multiple values on a given date, take the average of the constituent values for that date.
## Correlations between to variables can be computed with the cor() function.
# Code 1:
q10 <- inner_join(daily_spec, aqs_sites, by="Monitor") %>%
  filter(`Parameter Name` == "Sulfate PM2.5 LC" | `Parameter Name` == "Total Nitrate PM2.5 LC") %>%
  group_by(Monitor,`Parameter Name`,`Date Local`) %>%
  summarise(mean_arithmetic_mean = mean(`Arithmetic Mean`, na.rm = TRUE)) 

q101 <- q10 %>%
  filter(`Parameter Name` == "Sulfate PM2.5 LC")

q102 <- q10 %>%
  filter(`Parameter Name` == "Total Nitrate PM2.5 LC")

q10all <- inner_join(q101,q102,by=c("Date Local", "Monitor")) %>%
  group_by(Monitor) %>%
  summarise(cor=cor(mean_arithmetic_mean.x, mean_arithmetic_mean.y)) %>%
  arrange(desc(cor)) %>%
  head(1)

# Code 2:
q1022 <- inner_join(daily_spec, aqs_sites, by="Monitor") %>%
  filter(`Parameter Name` == "Sulfate PM2.5 LC" | `Parameter Name` == "Total Nitrate PM2.5 LC") %>%
  group_by(Monitor,`Parameter Name`,`Date Local`) %>%
  summarise(mean_arithmetic_mean = mean(`Arithmetic Mean`, na.rm = TRUE)) %>%
  spread(`Parameter Name`, mean_arithmetic_mean) %>% # put all the variables excluding group_by
  group_by(Monitor)%>%
  summarise(cor=cor(`Sulfate PM2.5 LC`, `Total Nitrate PM2.5 LC`)) %>%
  arrange(desc(cor)) %>%
  head(1)

# Answer 10: State 2 County 90 Site 35