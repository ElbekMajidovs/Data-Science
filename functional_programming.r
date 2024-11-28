install.packages("readxl")
library("readxl")
location<-setwd("C:\\Users\\majidel1\\OneDrive - Alcon\\Desktop\\UW\\R\\data\\data\\dataset - customer personality analysis")
getwd()
clients<-read.csv("marketing_campaign.csv", sep = "\t", header = TRUE)
View(clients)
str(clients)
clients[!complete.cases(clients),]
colSums(is.na(clients))    # So it's the Income column which includes NA's 
class(clients$Income)
clients$Income[is.na(clients$Income)]<-median(clients$Income, na.rm = TRUE)
colSums(is.na(clients))        
class(clients$Income)
#mean(clients$Year_Birth, na.rm = TRUE)   # I would probably get the mean value of Yea_Birth and replace NA values with that mean value 
#clients$Year_Birth[is.na(clients$Year_Birth)]<-1968
clients[!complete.cases(clients),]        # I would use this code to show the rows still with missing values
colSums(is.na(clients))                   # This one to show the columns still with NA's
str(clients)
allvariables<-colnames(clients)
lapply(clients[,allvariables], function(x){summary(factor(x))})   # This will be the function to check all the attributes of variables(observation) of the Data Frame.
# (factor) Education, Marital Status, Kidhome, Teenhome, NumDealsPurchases, NumwebPurchases, NumCatalogpurchases, NumWebVisitsMonths, AcceptedCmp1, AcceptedCmp2, AcceptedCmp3, AcceptedCmp4, AcceptedCmp5, Responses... 
clients$Marital_Status<-factor(clients$Marital_Status)   # 5B
class(clients$Marital_Status)
summary(factor(clients$Marital_Status))
# (ordered factor) Education, Kidhome, Teenhome, NumDealsPurchases, NumwebPurchases, NumCatalogpurchases, NumWebVisitsMonths, Complain, Response
summary(factor(clients$Education))
class(clients$Education)
clients$Education<-factor(clients$Education, levels = c("2n Cycle", "Basic", "Graduation", "Master", "PhD"),
                          labels = c("Middle School", "High School", "Bachelor's", "Master's", "Doctoral"),
                          ordered = TRUE)
class(clients$Education)
summary(factor(clients$Education))
class(clients$Marital_Status)
class(clients$Education)
#save.image(file = "clientsinR")

# (factor) Education, Marital Status, Kidhome, Teenhome, NumDealsPurchases, NumwebPurchases, NumCatalogpurchases, NumWebVisitsMonths, AcceptedCmp1, AcceptedCmp2, AcceptedCmp3, AcceptedCmp4, AcceptedCmp5, Responses... 
str(clients)
lapply(clients[,colnames(clients)], function(x){summary(factor(x))})
summary(factor(clients$Kidhome))
clients$Kidhome<-factor(clients$Kidhome, levels = c(0, 1, 2),
                        labels = c("Childless", "Only Child", "Two children"),
                        ordered=TRUE)
class(clients$Kidhome)
summary(factor(clients$Kidhome))
class(clients$Teenhome)
summary(factor(clients$Teenhome))
clients$Teenhome<-factor(clients$Teenhome, levels = c(0, 1, 2),
                         labels = c("No teenager", "Single Teenager", "Two Teenagers"),
                         ordered = TRUE)
class(clients$Teenhome)
summary(factor(clients$Teenhome))

class(clients$NumDealsPurchases)
summary(factor(clients$NumDealsPurchases))
clients_num_1<-c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,15)
clients_labels_1<-paste0("Customer_", clients_num)
clients$NumDealsPurchases<-factor(clients$NumDealsPurchases, 
                                  levels = clients_num,
                                  labels = clients_labels,
                                  ordered = TRUE)
class(clients$NumDealsPurchases)
summary(factor(clients$NumDealsPurchases))

class(clients$NumWebPurchases)
summary(factor(clients$NumWebPurchases))
clients_num_2<-c(0,1,2,3,4,5,6,7,8,9,10,11,23,25,27)
clients_labels_2<-paste0("Customer_", clients_num_2)
clients$NumWebPurchases<-factor(clients$NumWebPurchases, 
                                levels = clients_num_2,
                                labels = clients_labels_2,
                                ordered = TRUE)
class(clients$NumWebPurchases)
summary(factor(clients$NumWebPurchases))




class(clients$NumCatalogPurchases)
summary(factor(clients$NumCatalogPurchases))
clients_num_3<-c(0,1,2,3,4,5,6,7,8,9,10,11,22,28)
clients_labels_3<-paste0("Customer_", clients_num_3)
clients$NumCatalogPurchases<-factor(clients$NumCatalogPurchases,
                                    levels = clients_num_3,
                                    labels = clients_labels_3,
                                    ordered = TRUE)
class(clients$NumCatalogPurchases)
summary(factor(clients$NumCatalogPurchases))




summary(factor(clients$NumStorePurchases))
clients_num_4<-c(0,1,2,3,4,5,6,7,8,9,10,11,12,13)
clients_labels_4<-paste0("Customer_", clients_num_4)
clients$NumStorePurchases<-factor(clients$NumStorePurchases,
                                  levels = clients_num_4,
                                  labels = clients_labels_4,
                                  ordered = TRUE)
summary(factor(clients$NumStorePurchases))




class(clients$NumWebVisitsMonth)
summary(factor(clients$NumWebVisitsMonth))
clients_num_5<-c(0,1,2,3,4,5,6,7,8,9,10,13,14,17,19,20)
clients_labels_5<-paste0("Customer_", clients_num_5)
clients$NumWebVisitsMonth<-factor(clients$NumWebVisitsMonth,
                                  levels = clients_num_5,
                                  labels = clients_labels_5,
                                  ordered = TRUE)
summary(factor(clients$NumWebVisitsMonth))
str(clients)

save.image(file = "Homework6.RData")































