library(readr)
library(ggplot2)
library(cluster)
library(mclust) 
library(dbscan) 

setwd("C:\\Users\\majidel1\\OneDrive - Alcon\\Desktop\\UW\\Microeconomics\\Data codes\\Data codes")

sample_2024 <- read_csv("sample_2024.csv")

# I applied clustering methods (K-Means, GMM, DBSCAN, and PAM) before bootstrapping to improve sample 
# representation. Instead of purely random sampling, I drew proportional samples from each cluster. 
# Then, I performed multiple bootstrap regressions on these refined samples and computed the average regression
# coefficients. Finally, I compared the new estimated α, β values against the true relationship
# and your bootstrap-only method to assess improvements. 



###################### Clustering methods K-Means, PAM, GMM, DBSCAN are to be used##############################
## K-means
k <- 3  
kmeans_result <- kmeans(sample_2024, centers = k)
sample_2024$kmeans_cluster <- as.factor(kmeans_result$cluster)

## PAM Clustering
pam_result <- pam(sample_2024[, c("x", "y")], k)
sample_2024$pam_cluster <- as.factor(pam_result$clustering)

## Gaussian Mixture Model Clustering
gmm_result <- Mclust(sample_2024[, c("x", "y")], G=k)
sample_2024$gmm_cluster <- as.factor(gmm_result$classification)

## DBSCAN Clustering
dbscan_result <- dbscan(sample_2024[, c("x", "y")], eps = 50, minPts = 5)
sample_2024$dbscan_cluster <- as.factor(dbscan_result$cluster)


clustered_bootstrap <- function(data, cluster_col, B = 1000) {
  alfa_b <- numeric(B)
  beta_b <- numeric(B)
  n <- nrow(data)
  
  for (i in 1:B) {
    sampled_data <- do.call(rbind, lapply(split(data, data[[cluster_col]]), function(cluster) {
      cluster[sample(nrow(cluster), size = round(nrow(cluster) * 350 / n), replace = TRUE), ]
    }))
    
    mnk_b <- lm(y ~ x, data = sampled_data)
    alfa_b[i] <- coef(mnk_b)[1]
    beta_b[i] <- coef(mnk_b)[2]
  }
  
  return(list(alfa_b = alfa_b, beta_b = beta_b))
}

## Let's run clustered bootstrap for all clustering methods
bootstrap_kmeans <- clustered_bootstrap(sample_2024, "kmeans_cluster")
bootstrap_pam <- clustered_bootstrap(sample_2024, "pam_cluster")
bootstrap_gmm <- clustered_bootstrap(sample_2024, "gmm_cluster")
bootstrap_dbscan <- clustered_bootstrap(sample_2024, "dbscan_cluster")

## Mean estimates for K-Means
mean_alfa_kmeans <- mean(bootstrap_kmeans$alfa_b)
mean_beta_kmeans <- mean(bootstrap_kmeans$beta_b)

## Mean estimates for PAM
mean_alfa_pam <- mean(bootstrap_pam$alfa_b)
mean_beta_pam <- mean(bootstrap_pam$beta_b)

## Mean estimates for GMM
mean_alfa_gmm <- mean(bootstrap_gmm$alfa_b)
mean_beta_gmm <- mean(bootstrap_gmm$beta_b)

## Mean estimates for DBSCAN
mean_alfa_dbscan <- mean(bootstrap_dbscan$alfa_b)
mean_beta_dbscan <- mean(bootstrap_dbscan$beta_b)

## Plot results
par(mfrow=c(2,2))
hist(bootstrap_kmeans$alfa_b, main="Histogram of a (K-Means)", col="aquamarine3", breaks=50, probability=TRUE)
lines(density(bootstrap_kmeans$alfa_b), lwd=3)
hist(bootstrap_kmeans$beta_b, main="Histogram of b (K-Means)", col="aquamarine3", breaks=50, probability=TRUE)
lines(density(bootstrap_kmeans$beta_b), lwd=3)

## Scatter plot 
plot(bootstrap_kmeans$alfa_b, bootstrap_kmeans$beta_b, pch=20, col=rgb(0,0,1,0.5),
     main=paste("XY plot of K-Means bootstrapped estimators\n[mean_a =", round(mean_alfa_kmeans,1), ", mean_b =", round(mean_beta_kmeans,2), "]"))
abline(h=mean_beta_kmeans, v=mean_alfa_kmeans, lwd=2)

