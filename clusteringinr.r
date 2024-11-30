install.packages("readxl")
library("readxl")
location<-setwd("C:\\Users\\majid\\OneDrive\\Desktop\\UW\\R\\data\\data")
water<-read.csv("graphics - water quality\\water_potability.csv", header = TRUE)
View(water)
set.seed(123)

# k-means function has problems with missing data, let's put them aside
waterNoMiss <- water[complete.cases(water),]

View(waterNoMiss)

clustering <- kmeans(waterNoMiss, 4)
summary(clustering)
View(clustering)
str(clustering)
clustering$centers

# let's add clustering vector to our data
clustering$cluster # vector with assignment to k-means groups of each observations
waterNoMiss$kmeans <- clustering$cluster #creating a new variable with clusters

# Getting the mean of water Hardness in each group
tapply(waterNoMiss$Hardness, waterNoMiss$kmeans, mean)



### Small spoiler:
# 1. Getting the mean for groups with tidyverse

# library(tidyverse)
# waterNoMiss %>% group_by(kmeans) %>% summarize(mean = mean(Hardness))

# 2. Graphics - using the clustering result as a "coloring" factor 
