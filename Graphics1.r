### Preparing for graphics creation ############################################

# Reading the data
getwd() # is the path set right?
#setwd() # change if necessary
setwd("C:\\Users\\Desktop\\UW\\R\\data\\data")
life<-read.csv("dataset - life expectancy\\Life Expectancy Data.csv", header = TRUE)
View(life)


life <- read.csv("data/dataset - life expectancy/Life Expectancy Data.csv")
head(life)


lifePL<-subset(life, Country=="Poland")
View(lifePL)

# set with observations regarding Poland

lifePL<-subset(life, Country=="Poland")

# overview of the whole dataset

View(lifePL)

# set with observations regarding Poland and Germany




life[life$Country=="Poland" & life$Country=="Germany"]


lifePLDE <- subset(life, Country == "Poland" | Country == "Germany")
head(lifePLDE)

View(lifePLDE)



### Graphics with plot function ################################################

?plot
plot(lifePL$Life.expectancy) # point plot, subsequent values of the variable

lifePL[,c("Year", "Life.expectancy")] # year - descending

plot(x = lifePL$Year, y = lifePL$Life.expectancy) # year - ascending


# line plot
plot(lifePL$Year, lifePL$Life.expectancy, type = "l") 


# line plot with points
plot(lifePL$Year, lifePL$Life.expectancy, type = "b") 


# step plot
plot(lifePL$Year, lifePL$Life.expectancy, type = "s") 


# changing the range of x variable  
plot(lifePL$Year, lifePL$Life.expectancy, type = "b", xlim = c(2005, 2010)) 


# changing the range of x and y (zooming the plot) 
plot(lifePL$Year, lifePL$Life.expectancy, type = "b", 
     xlim = c(2005, 2010), ylim = c(75, 76.5)) 



### GDP plot - modifying the plot details ######################################

plot(lifePL$Year, lifePL$GDP, type = "b")

# adding a title
plot(lifePL$Year, lifePL$GDP, type = "b", main = "GDP in Poland")


# using logarithmic transformation of y variable 
plot(lifePL$Year, lifePL$GDP, type = "b", log = "y") 
plot(lifePL$Year, log(lifePL$GDP), type = "b") # second version


# adding a title and subtitle
plot(lifePL$Year, lifePL$GDP, type = "b", log = "y", main = "GDP in Poland", 
     sub = "GDP values are log-transformed") 


# adding the axis titles
plot(lifePL$Year, lifePL$GDP, type = "b", log = "y", main = "GDP in Poland", 
     sub = "GDP values are log-transformed",
     xlab = "Year", ylab = "log GDP") 



### Density plot ###############################################################

density(lifePL$Life.expectancy)
plot(density(lifePL$Life.expectancy))



### Bar plot ###################################################################

barplot(lifePL$Life.expectancy)
barplot(lifePL$Life.expectancy, ylim = c(0, 80))
barplot(lifePL$Life.expectancy, ylim = c(0, 80), 
        col = "aquamarine") #changing colors



### Histogram ##################################################################
?hist()

hist(lifePL$Life.expectancy) # frequency representation
hist(lifePL$Life.expectancy, freq = TRUE)  

hist(lifePL$Life.expectancy, 
     freq = FALSE) # probability representation (area of histogram = 1)

hist(lifePL$Life.expectancy, breaks = c(50, 60, 70, 80, 90))
hist(lifePL$Life.expectancy, breaks = seq(70,80, 2))


# function lines allows to add new lines to the plot 
# function points is for adding points

# histogram and density plot combined
hist(lifePL$Life.expectancy, freq = TRUE)
lines(density(lifePL$Life.expectancy)) 
# unmatched scale - we need to compare the same units 

# correction - comparing probabilities 
hist(lifePL$Life.expectancy, freq = FALSE)
lines(density(lifePL$Life.expectancy))

# changing the scale of the plot
hist(lifePL$Life.expectancy, freq = FALSE, breaks = seq(70,80, 1))
lines(density(lifePL$Life.expectancy))



### Box plot ###################################################################

summary(lifePLDE$Life.expectancy)

boxplot(lifePLDE$Life.expectancy)



### Summarizing data with group comparison #####################################

boxplot(lifePLDE$Life.expectancy ~ lifePLDE$Country)

boxplot(lifePLDE$Life.expectancy ~ lifePLDE$Country, names = c("DE", "PL")) # labels for groups

boxplot(lifePLDE$Life.expectancy ~ lifePLDE$Country, names = c("Germany", "Poland"),
        xlab = "Country", ylab = "Life expectancy", 
        main = "Comparison of life expectancy in Poland and in Germany",
        sub = "Values for 2000-2015")


boxplot(lifePLDE$Life.expectancy ~ lifePLDE$Country, names = c("Germany", "Poland"),
        xlab = "Country", ylab = "Life expectancy", 
        main = "Comparison of life expectancy in Poland and in Germany",
        sub = "Values for 2000-2015", 
        col = "lightgreen") # color change



### Violin plot ################################################################

#install.packages("vioplot")
library(vioplot)

vioplot(lifePLDE$Life.expectancy)

vioplot(lifePLDE$Life.expectancy ~ lifePLDE$Country) # syntax like in boxplot

vioplot(lifePLDE$Life.expectancy ~ lifePLDE$Country,
        col = "lightgray")



### Dotchart - identification of the outliers ##################################

dotchart(lifePL$Life.expectancy)

dotchart(lifePL$BMI) # identification of the outlier

# Division into groups (grouping variable must be a factor) 
dotchart(lifePLDE$BMI, groups = factor(lifePLDE$Country))




### Investigating the relations between variables ############################## 

plot(lifePL)

str(lifePL)

pairs(lifePL[, c("Life.expectancy", "GDP", "Population", "Schooling")])
names(lifePL)

pairs(lifePL[, c(4,17:18, 22)])

pairs(lifePL[, c(4,17:18, 22)], panel = panel.smooth)



### Correlation plot ###########################################################

install.packages("PerformanceAnalytics")
library("PerformanceAnalytics")
chart.Correlation(lifePL[, c(4,17:18, 22)], histogram = TRUE, pch = 19)

install.packages("corrplot")
library(corrplot)

#corrplot(lifePL[, c(4,17:18, 22)], type = "upper", order = "hclust")

corrplot(cor(lifePL[, c(4,17:18, 22)]))
corrplot(cor(lifePL[, c(4,17:18, 22)]), type = "lower", order = "hclust")
corrplot(cor(lifePL[, c(4,17:18, 22)]), type = "upper", order = "hclust",
         method = "number", add = TRUE)

?corrplot.mixed
corrplot.mixed(cor(lifePL[, c(4,17:18, 22)]), upper = "number", 
               lower = "circle", order = "alphabet")
