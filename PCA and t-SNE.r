install.packages("readxl")
install.packages("htmltools")
install.packages("yaml")
install.packages("plotly")
install.packages("ggplot2")
install.packages("Rtsne")
install.packages("htmlwidgets")
library("htmlwidgets")
library("Rtsne")
library("plotly")
library("yaml")
library("readxl")
library("htmltools")
library("ggplot2")
setwd("C:\\Users\\majidel1\\OneDrive - Alcon\\Desktop\\UW")
Global<-read_excel("Unsupervised in R\\PCA Homework\\DataBank. World Development Indicators_Unsupervised_Learning.xlsx")
#   View(Global)
#### replacing NA values ###
colSums(is.na(Global))
Global$`Exports of goods and services (annual % growth) [NE.EXP.GNFS.KD.ZG]`[is.na(Global$`Exports of goods and services (annual % growth) [NE.EXP.GNFS.KD.ZG]`)]<-mean(Global$`Exports of goods and services (annual % growth) [NE.EXP.GNFS.KD.ZG]`, na.rm = TRUE)  
summary(Global)
str(Global)
Global[,c(6:18)]<-lapply(Global[,c(6:18)], function(x){ifelse(is.na(x), mean(x, na.rm = TRUE), x)})
colSums(is.na(Global))
#   View(Global)
### Standardizing the Data ###
lapply(Global, class)
Global[,c(5:18)]<-scale(Global[,c(5:18)])
summary(Global)
dim(Global)
View(Global)
### Keeping only relevant(numeric) columns ### removes the first 4 columns numeric and year ###
Global<-Global[,-c(1:4)]    
#   View(Global)
### PCA Internal standardisation ###
pca_performed<-prcomp(Global, center = TRUE, scale. = TRUE)
summary(pca_performed)
pca_top_3<-pca_performed$x[,1:3]
### Plotting the explained variance ###
plot(cumsum(pca_performed$sdev^2 / sum(pca_performed$sdev^2)),
     type = "b",
     xlab = "Number of Components",
     ylab = "Cumulative Proportion of Variance",
     main = "Explained Variance by Principal Components")
### Analyse Loadings ###
loadings<-pca_performed$rotation[,1:3]
print(loadings)
### Visualization//executing the plot ###
plot(pca_performed, type="lines", main="scree Plot")
### 3D Scattered ###
pca_rotating<-plot_ly(x=pca_top_3[,1],
              y=pca_top_3[,2],
              z=pca_top_3[,3],
              type = "scatter3d",
              mode = "markers")
### please use this function if the plot doesn't rotate ### 
htmlwidgets::saveWidget(pca_rotating, "pca_plot.html")
browseURL("pca_plot.html")
### Applying t-SNE ###
tsne_data<-pca_top_3 
tsne_performed<-Rtsne(tsne_data, dims = 3, perplexity = 30, pca = TRUE, check_duplicates = FALSE)
tsne_coordinates<-tsne_performed$Y
print(tsne_coordinates)
### t-SNE result 3D ###
tsne_rotating<-plot_ly(x = tsne_coordinates[, 1],
               y = tsne_coordinates[, 2],
               z = tsne_coordinates[, 3],  
               type = "scatter3d",
               mode = "markers")
### please use this function if the plot doesn't rotate ### 
htmlwidgets::saveWidget(tsne_rotating, "pca_plot_.html")
browseURL("pca_plot_.html")



