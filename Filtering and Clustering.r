lokation<-setwd("C:\\Users\\majidel1\\OneDrive - Alcon\\Desktop\\UW\\R\\data\\data")
life<-read.csv("dataset - life expectancy\\Life Expectancy Data.csv", header = TRUE)    # 1a
str(life)          # 1b
summary(life)      # 1b
summary(life[(life$Year==2013),])        # 1c
life[(life$Status=="Developing"),][median(life$Life.expectancy(life[(life$Status=="Developing")]))]
median(life$Life.expectancy(life[(life$Status=="Developing")]), na.rm = TRUE)


life[(life$Status=="Developing"),][median(life$Life.expectancy[life$Status=="Developing"], na.rm = TRUE),]


median(life$Life.expectancy[develing], na.rm = TRUE)

median(life$Life.expectancy[life$Status=="Developing"], na.rm = TRUE)   # 1

median(life$Life.expectancy[life$Status=="Developing" & life$Year==2010], na.rm = TRUE)              # 1d

median(life$Life.expectancy[life$Status=="Developing" & life$Year==2010], na.rm = TRUE)         # 1d

median(life$Life.expectancy[life$Status=="Developing" & life$Year==2010], na.rm = TRUE)    # 1d





mean(life$Polio[life$Year==2014], na.rm = TRUE)     # 1e





summary(life[(life$Year==2013),])
median(life$Life.expectancy[life$Status=="Developing" & life$Year==2010], na.rm = TRUE)
mean(life$Polio[life$Year==2014], na.rm = TRUE)
model2008<-lm(GDP ~ Polio + Alcohol + infant.deaths, data = life2008)
summary(model2008)
str(model2008)
model2008[[1]][4]
model2008$coefficients[("infant.deaths")]


life[(life$Status=="Developing" & life$Year==2010),]#################################################################

median(life$Life.expectancy[life[life(life$Status=="Developing") & (life$Year=="2010")]], na.rm = TRUE)


median(life[(life$Life.expectancy=="Developing") & (life$Year==2010),], na.rm = TRUE)

median(life$Life.expectancy(life[(life$Status=="Developing") & (life$Year==2010)]), na.rm = TRUE)

life[(life$Status=="Developing"),][median(life$Life.expectancy[life$Status=="Developing"], na.rm = TRUE),]

median(life$Life.expectancy, na.rm = TRUE)


median(life$Life.expectancy[life$Status=="Developing"], na.rm = TRUE)


CO2[(CO2$Type=="Quebec"),][order(CO2$conc[CO2$Type=="Quebec"]),]
