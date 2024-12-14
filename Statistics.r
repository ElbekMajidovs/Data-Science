location<-setwd("C:\\Users\\majidel1\\OneDrive - Alcon\\Desktop\\UW\\R\\data\\data")
install.packages("readxl")
library("readxl")
water<-read.csv("graphics - water quality\\water_potability.csv", header = TRUE)
head(water)
str(water)
summary(factor(water$ph))
lapply(water, function(x){summary(factor(x))})
View(water)
colSums(is.na(water))
min(water$ph, na.rm = TRUE)
max(water$ph, na.rm = TRUE)
range(water$ph, na.rm = TRUE)
mean(water$ph, na.rm = TRUE)
median(water$ph, na.rm = TRUE)
IQR(water$ph, na.rm = TRUE)
summary(water$ph)
quantile(water$ph, 0.25, na.rm = TRUE)
quantile(water$ph, 0.5, na.rm = TRUE)
quantile(water$ph, 0.75, na.rm = TRUE)
quantile(water$ph, 0.75, na.rm = TRUE) - quantile(water$ph, 0.25, na.rm = TRUE) == IQR(water$ph, na.rm = TRUE)
sd(water$ph, na.rm = TRUE)
var(water$ph, na.rm = TRUE)
str(water)
lapply(water[,c(4:7)], mean, na.rm = TRUE) 
lapply(water[,c(3:9)], median, na.rm = TRUE)
IQR(water$ph,na.rm = TRUE)
quantile(water$ph, 0.25, na.rm = TRUE)



#################################################################

# summarizing the dataset
summary(water)

# additional function with statistical summary 
install.packages("pastecs")
library(pastecs)

stat.desc(water) # issue with readability of the data

options(scipen = 999) # turning off the matematical notation
stat.desc(water)
