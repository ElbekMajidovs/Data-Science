install.packages("readxl")
library("readxl")
location<-setwd("C:\\Users\\majidel1\\OneDrive - Alcon\\Desktop\\UW\\R\\data\\data")
clients<-read.csv("clients.csv", header = TRUE)
View(clients)
str(clients)            
lapply(clients, function(x){class(x)})
colSums(is.na(clients))
clients[!complete.cases(clients),]
clients$Year_Birth[!complete.cases(clients$Year_Birth)]<-median(clients$Year_Birth, na.rm = TRUE)
clients$MntWines[!complete.cases(clients$MntWines)]<-median(clients$MntWines, na.rm = TRUE)
clients$Response[!complete.cases(clients$Response)]<-median(clients$Response, na.rm = TRUE)
clients[!complete.cases(clients),]
lapply(clients, function(x){summary(factor(x))})

### decided on the factorization of variables ###############################################

clients$education      # ordered factor
clients$Marital_Status # factor
clients$AcceptedCmp4   # ordered factor
clients$AcceptedCmp5   # ordered factor
clients$AcceptedCmp1   # ordered factor
clients$AcceptedCmp2   # ordered factor
clients$Complain       # ordered factor and 3 to be converted to 1 
clients$Response       # ordered factor and 11 to be converted to 1 

class(clients$Education)
summary(factor(clients$Education))
clients$Education<-factor(clients$Education, 
                          levels = c("2n", "Basic", "Graducation", "Master", "PhD"),
                          labels = c("High school", "College", "Bachelor's", "Mater's", "Doctoral"),
                          ordered = TRUE)
class(clients$Education)


class(clients$Marital_Status)
summary(factor(clients$Marital_Status))
clients$Marital_Status<-factor(clients$Marital_Status,
                               levels = c("Absurd", "Alone", "Cycle", "Divorced", "Married", "Single", "Together", "Widow", "YOLO"),
                               labels = c("Absurd", "Alone", "Cycle", "Divorced", "Married", "Single", "Together", "Widow", "YOLO"))
class(clients$Marital_Status)

class(clients$AcceptedCmp5)
summary(factor(clients$AcceptedCmp5))
clients$AcceptedCmp5<-factor(clients$AcceptedCmp5,
                             levels = c(0,1),
                             labels = c("Accepted at 5th campaign", "Not in 5th campaign"),
                             ordered = TRUE)
summary(factor(clients$AcceptedCmp5))

class(clients$Complain)
summary(factor(clients$Complain))
clients$Complain[(clients$Complain==3)]<-1
View(clients)
summary(factor(clients$Complain))
clients$Complain<-factor(clients$Complain,
                         levels = c(0,1),
                         labels = c("Complained in the last 2 years", "No any complaints in the last two years"),
                         ordered = TRUE)        
class(clients$Complain)
summary(factor(clients$Complain))
class(clients$Response)
summary(factor(clients$Response))
clients$Response[(clients$Response==11)]<-1
summary(factor(clients$Response))
clients$Response<-factor(clients$Response,
                         levels = c(0,1),
                         labels = c("Accepted the offer from last Campaign", "Didn't accept even in the last Campaign"),
                         ordered = TRUE)
summary(factor(clients$Response))
