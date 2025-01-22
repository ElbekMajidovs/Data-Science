# 1. Data reading/set-up/loading packages##################################################################

# loading the necessary packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load("arules", "arulesViz", "arulesCBA", "readxl", "networkD3")

# Setting the working directory and reading the dataset(transactions) in sparse format
setwd("C:\\Users\\Majidovs\\Desktop\\UW\\Unsupervised in R\\Association rules")
shopping<-read.transactions("cart.csv", sep = ",")
shopping




# 1019 transactions (rows) and
# 155 items (columns)

# 2. Descriptive statistics/summary/inspection###################################################################

summary(shopping)

inspect(shopping)

size(shopping) 

length(shopping)

LIST(head(shopping))

itemFrequency(shopping, type="relative")
itemFrequency(shopping, type="absolute")

# Cross-table analysis

ctab<-crossTable(shopping, sort=TRUE) 
ctab<-crossTable(shopping, measure="count", sort=TRUE) 
ctab

stab<-crossTable(shopping, measure="support", sort=TRUE)
round(stab, 3)

ptab<-crossTable(shopping, measure="probability", sort=TRUE) 
round(ptab,3)

ltab<-crossTable(shopping, measure="lift", sort=TRUE)
round(ltab,2)

# co-occurence test (independence test)

chi2tab<-crossTable(shopping, measure="support", sort=TRUE)
round(chi2tab,2)

# Calculate confidence
confidence_tab <- crossTable(shopping, measure = "support", sort = TRUE)
round(confidence_tab, 2)

# 3. Vizualization########################################################################################

# set the minimum support at 15%

itemFrequencyPlot(shopping, support = 0.15)

# limit the plot to a specific number of items (e.g. 25 ones)
itemFrequencyPlot(shopping, topN = 25)

# Visualize the sparse matrix for the first 5 items using a different color scheme and grid
image(as(shopping[1:5,], "matrix"), 
      col = terrain.colors(100), 
      main = "Sparse Matrix Visualization - First 5 Items", 
      xlab = "Items", 
      ylab = "Transactions")

# Sample 100 transactions from the 'groceries' sparse matrix
sampled_shopping <- sample(1:nrow(shopping), 100)
sampled_matrix <- shopping[sampled_shopping,]

# Convert the sparse matrix to a dense matrix for visualization
dense_sampled_matrix <- as(sampled_matrix, "matrix")

# Visualize the sampled dense matrix with a different color scheme and grid
image(dense_sampled_matrix, 
      col = topo.colors(100), 
      main = "Sparse Matrix Visualization - Sample of 100 Items", 
      xlab = "Items", 
      ylab = "Transactions")

# random selection of 20 transactions
image(sample(shopping, 20))


# 4. Associate Rule Minging################################################################################

# ECLAT

#I'll keep the max length of items in the set to 18 

# freq.prod<-eclat(shopping, parameter=list(supp=0.10, maxlen=10)) 
# inspect(freq.prod)

freq.items<-eclat(shopping, parameter=list(supp=0.006, maxlen=15)) 
inspect(freq.items)

#Support: The support values indicate the proportion of transactions in the dataset that contain each item. 
#For example, "rice" appears in 32.48% of the transactions, which is relatively high compared to other items 
#like "beef" (10.99%).
#Count: This shows the absolute number of transactions in which the item appears. Higher counts indicate 
#higher occurrence in the dataset.

#The dataset contains a variety of common items, with "rice" being the most frequent. Other items like 
#"vegetables" and "noodles" also appear frequently.
#Items like "beef" and "canned beer" have much lower support, indicating they are less common in the dataset.



# vector of support values

round(support(items(freq.items), shopping) , 2) 

#These values provide a clearer picture of the relative frequency of the items in your dataset.
#The higher the support value, the more commonly the item appears in the transactions.

# basic statistics with reference to confidence
freq.rules <- ruleInduction(freq.items, shopping, confidence = 0.5)
freq.rules

plot(freq.rules, method="matrix", measure="lift")

plot(freq.items, method="graph")

plot(freq.items, method="paracoord", control=list(reorder=TRUE))

# For top 10 rules
# Paralel cordinates plot for 20 rules
top_rules <- head(freq.items, 10)
plot(top_rules, method="paracoord", control=list(reorder=TRUE))
plot(top_rules, method="graph", control=list(reorder=TRUE))


# For top 20 rules
# Parralel cordinates plot for 10 rules 
top_rules <- head(freq.items, 20)
plot(top_rules, method="paracoord", control=list(reorder=TRUE))
plot(top_rules, method="graph", control=list(reorder=TRUE))


# Creating a matrix of item associations (support)
item_matrix <- itemFrequency(shopping)

# Plot heatmap
heatmap(as.matrix(item_matrix), main = "Item Association Heatmap", scale = "column", col = heat.colors(256))



#Most rules have support values ranging between 0.006 to 0.02, which suggests a decent frequency in the dataset, depending on the total number of transactions.
#Confidence values are mostly above 0.5, indicating that the rules have moderate to strong predictive power.
#Lift values range from about 1.96 to 3.46, suggesting positive associations, with some rules showing strong lifts, particularly those with lift values above 2.
#output set of 0 rules after running the ruleInduction function indicates that no association rules 
#were generated from the frequent itemsets you provided, given the specified confidence level.

inspect(freq.rules) # screening the rules

# Apriori

# creating the rules - standard settings
rules.shopping<-apriori(shopping, parameter=list(supp=0.1, conf=0.5))  

# 5. Advanced Rule Analytics###############################################################################
# digging the rules
#1. in the context of induction - what is the cause / consequence of a given purchase
#2. looking for rules for closed itemsets
#3. finding significant rules
#4. looking for maximal rules
#5. looking for redundant rules
#6. searching subsets and supersets
#7. by searching for transactions that support the rules

# Specialized rule search

# Generate rules where "rice" is on the right-hand side
rules.rice <- apriori(data=shopping, parameter=list(supp=0.001, conf=0.08),
                      appearance=list(default="lhs", rhs="rice"), control=list(verbose=F))

# Sort rules by confidence and display the top ones
rules.rice.byconf <- sort(rules.rice, by="confidence", decreasing=TRUE)
inspect(head(rules.rice.byconf))

# Generate rules where "rice" is on the left-hand side
rules.rice <- apriori(data=shopping, parameter=list(supp=0.001, conf=0.08),
                      appearance=list(default="rhs", lhs="rice"), control=list(verbose=F))

# Sort rules by confidence and display the top ones
rules.rice.byconf <- sort(rules.rice, by="confidence", decreasing=TRUE)
inspect(head(rules.rice.byconf))


# Generate closed frequent itemsets using apriori
closed.itemsets <- apriori(shopping, parameter=list(target="closed frequent itemsets", support=0.25))
inspect(closed.itemsets)

#High Support: The support value of around 25.64% is relatively high, indicating that rice is a common item in the dataset.
#Frequent Item: Since rice appears in 2876 transactions, it can be considered a frequent item and could play a significant role in generating strong association rules.

# Check if the itemsets are closed
is.closed(closed.itemsets)

# Generate closed itemsets using eclat
closed.eclat <- eclat(shopping, parameter=list(supp=0.15, maxlen=15, target="closed frequent itemsets"))
inspect(closed.eclat)

# Generate maximal itemsets using eclat
maximal.eclat <- eclat(shopping, parameter=list(supp=0.15, maxlen=15, target="maximally frequent itemsets"))
inspect(maximal.eclat)


# Significance testing

# Test if the rules related to "rice" are statistically significant (Fisher's exact test)
is.significant(rules.rice, shopping)


# Maximal Rules

# Check if the rules related to "rice" are maximal
is.maximal(rules.rice)

# Inspect only maximal rules
inspect(rules.rice[is.maximal(rules.rice)==TRUE])


# Redundant rules

# Identify and inspect non-redundant rules related to "rice"
is.redundant(rules.rice)
inspect(rules.rice[is.redundant(rules.rice)==FALSE])

# Supersets and subsets

# Check if the rules related to "rice" are supersets or subsets
is.superset(rules.rice)
is.subset(rules.rice)

# Non-sparse check for supersets
is.superset(rules.rice, sparse=FALSE)

# Supporting transactions

# Get the transactions supporting the rules for "rice"
supportingTransactions(rules.rice, shopping)
inspect(supportingTransactions(rules.rice, shopping))


# Similarity and Dissimilarity (Jaccard)

# Selecting transactions with at least 5% item frequency
selected.transactions <- shopping[, itemFrequency(shopping) > 0.05]

# Plotting dendrogram for transactions and items
# plot(hclust(d.jac.t, method="ward.D2"), main="Dendrogram for Transactions")     # unreadable dendogram
plot(hclust(d.jac.i, method="ward.D2"), main="Dendrogram for Items")


# Filter to include only the top 20 items based on frequency (or another threshold)
top_items <- shopping[, itemFrequency(shopping) > 0.1]  # Adjust threshold as needed
d.jac.i <- dissimilarity(top_items, which="items")
hclust_plot <- hclust(d.jac.i, method="ward.D2")
plot(hclust_plot, main="Dendrogram for Top Items Similarity")

# Or for transactions:
top_transactions <- shopping[1:100, ]  # Take top 100 transactions, adjust as needed
d.jac.t <- dissimilarity(top_transactions, which="transactions")
hclust_plot_trans <- hclust(d.jac.t, method="ward.D2")
plot(hclust_plot_trans, main="Dendrogram for Top Transactions Similarity")

# Vizualization

# Visualization: Top 10 rules for rice by confidence
top_rules <- head(rules.rice.byconf, 10)
barplot(quality(top_rules)$confidence, names.arg=labels(top_rules), las=2,
        col="skyblue", main="Top 10 Rules for Rice by Confidence", cex.names=0.7)

# Dendrogram visualization for items
d.jac.i <- dissimilarity(selected.transactions, which="items")
hclust_plot <- hclust(d.jac.i, method="ward.D2")
plot(hclust_plot, main="Dendrogram for Item Similarity")

# Dendrogram visualization for transactions
d.jac.t <- dissimilarity(selected.transactions, which="transactions")
hclust_plot_trans <- hclust(d.jac.t, method="ward.D2")

# 6. New Association Algorithm#########################################################################


rules_fp_growth <- apriori(shopping, parameter = list(supp = 0.01, conf = 0.5))
inspect(rules_fp_growth)

plot(rules_fp_growth, method = "graph")

# Similarity 
# 
# itemMatrix <- as(shopping, "transactions")
# 
# library(proxy)
# sim_matrix <- simil(as(itemMatrix, "matrix"), method = "Jaccard")
# print(as.matrix(sim_matrix))
# 
# library(ggplot2)
# heatmap(as.matrix(sim_matrix), main = "Item Similarity (Jaccard Index)")


# 7. Vizualization######################################################################################

# Item Frequency Plot - Absolute and Relative Frequencies for Top 10 Items

itemFrequencyPlot(shopping, topN=15, type="absolute", main="Top 15 Items by Frequency (Absolute)")
itemFrequencyPlot(shopping, topN=15, type="relative", main="Top 15 Items by Frequency (Relative)")


# Generate a data frame of the itemset and their associations
freq.items <- eclat(shopping, parameter=list(supp=0.006, maxlen=15))

# Create the data frame for Sankey diagram
# You need to convert the frequent itemsets into pairs of items for the links
itemsets <- inspect(freq.items)  # Get the itemsets from the frequent itemsets

# Example of a simple data frame for links (each link is an association between two items)
links <- data.frame(
  source = c("rice", "rice", "vegetables", "noodles"),
  target = c("noodles", "vegetables", "noodles", "rice"),
  value = c(100, 50, 70, 90)  # These are just example values for the flows between items
)

# Create nodes data frame
nodes <- data.frame(name = unique(c(links$source, links$target)))

# Map source and target to the node index
links$source <- match(links$source, nodes$name) - 1
links$target <- match(links$target, nodes$name) - 1


# Create the Sankey diagram
sankey <- sankeyNetwork(Links = links, Nodes = nodes, Source = "source", Target = "target", Value = "value", NodeID = "name", units = "TWh")
print(sankey)

# 8. Random transactions################################################################################ 

# random transactions

trans<-random.transactions(nItems=10, nTrans=15, method="independent", verbose=FALSE)
image(trans)

inspect(trans)

# Based on the drawn data, you can create rules (apriori()) and view them (inspect(), sort()), check their length (size()) and how many were created (legnth()), create data sets (eclat())

rules.random<-apriori(trans, parameter=list(supp=0.05, conf=0.3)) 
inspect(rules.random)
rules.by.conf<-sort(rules.random, by="confidence", decreasing=TRUE) 
inspect(rules.by.conf)
size(rules.by.conf)
length(rules.by.conf)
freq.items<-eclat(trans, parameter=list(supp=0.25, maxlen=15)) # basic eclat
inspect(freq.items)


#Positive support values: All the support values are between 0 and 1, indicating the frequency of the
#itemsets in the dataset. Since none of these support values are negative, the itemsets are positively 
#associated.


# 9. Saving Rules#########################################################################################

write(rules.random, file = "random_rules.csv", sep = ",", quote = TRUE, row.names = FALSE)



