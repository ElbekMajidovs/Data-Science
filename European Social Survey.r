---
title: "European Social Survey"
author: "Elbek_Majidov"
date: "4 February 2025"
output: 
  html_document:
    toc: true
    toc_float:
      toc_collapsed: true
    toc_depth: 3
    number_sections: false
    theme: readable
---
**Unsupervised Learning in R**  
**Faculty of Economic Sciences**  
**Department of Data Science**  
**University of Warsaw**  
**dr hab. prof. Jacek Lewkowicz**


## Introduction 
  The European Social Survey (ESS) provides high-quality open access data measuring public attitudes, beliefs and behaviour. In today's paper I'll be inspecting the whole dataset and the special variable **"hincfel"** feeling about households income nowadays.These results provide insight into economic well-being across European populations, highlighting disparities in perceived financial security.

  I'll use only Apriori algorithm to uncover some patters, keeping **"hincfel"** as a rule consequent. Later, there will be appropriate vizualizations such as parallel coordinates plot, bar chart, scatter plot, network graph and lastly sankey diagram.
  
  
## Plan of the Paper:
1. Access the European Social Survey(round 11) https://ess.sikt.no/en/
[ESS](https://ess.sikt.no/en/)
2. Keep the broadest possible geographical coverage
3. Inspect the variable *"hincfel"*  Feeling about household's income nowadays (hincfel)
4. Develop association rules with hincfel as a rule consequent
5. Analyze the obtained rules and interpret the outcome
6. Provide appropriate visualization

## 1. Access the European Social Survey

```{r}
if (!require("pacman")) install.packages("pacman")
pacman::p_load("yaml", "plotly", "ggplot2", "arules", "arulesViz", "caret", "GGally", "networkD3", "htmlwidgets")

setwd("C:\\Users\\majidel1\\OneDrive - Alcon\\Desktop\\UW\\Unsupervised in R\\ESS11_R2")
Survey<-read.csv("ESS11.csv")
str(Survey) 
dim(Survey)
head(summary(Survey), 5)
```

The dataset is quite large with as many as 640 different columns (dimentions) and 40156 rows, respectively. 
Now I'll move onto next tasks which includes first inspecting and later developing association rules with the variable "*hincfel*" as a rule consuquent

## 3. Inspect the variable *"hincfel"*  Feeling about household's income nowadays (hincfel)

```{r}
summary(Survey$hincfel) # summary
class(Survey$hencifel) # class 
sum(is.na(Survey$hincfel)) # missing values
head(Survey$hincfel) # few first values
table(Survey$hincfel) # frequency of values
```

Counting the occurance of variable

```{r}
hincfel_df <- as.data.frame(table(Survey$hincfel))

counts <- as.data.frame(table(Survey$hincfel))

p <- ggplot(counts, aes(x = Var1, y = Freq, fill = Freq)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = paste0(round((Freq / sum(Freq)) * 100, 1), "%")), 
            vjust = -0.5, size = 3.5, fontface = "bold") + 
  scale_fill_gradient(low = "yellow", high = "green") +
  theme_minimal() +
  labs(
    title = "Distribution of Income Feeling in Europe",
    x = "Income Feeling (hincfel)",
    y = "Count"
  ) +
  theme(
    axis.text.x = element_text(angle = 0, hjust = 0.5),
    plot.margin = margin(20, 150, 20, 20),  
    legend.position = "none"  
  )
```

```{r}
Survey$hincfel <- as.factor(Survey$hincfel)


counts <- as.data.frame(table(Survey$hincfel))

counts$Var1 <- as.numeric(as.character(counts$Var1))

p + annotate(
  "text",
  x = max(counts$Var1) + 1, y = max(counts$Freq) * 0.8,
  label = paste(
    "Options:",
    "1. Living comfortably",
    "2. Coping on income",
    "3. Difficult on income",
    "4. Very difficult",
    "7. Refusal",
    "8. Don't know",
    "9. No answer",
    sep = "\n"
  ),
  hjust = 0, vjust = 1, size = 4, fontface = "italic"
)
```

It's visible from the chart that The majority of respondents report are barely making a living with their income (Category 2: 18.11k), making it the most frequent response. A significant proportion of individuals also state that they are living comfortably (Category 1: 14.31k), suggesting a relatively large segment of financial stability. Around 5.86k respondents report difficulty managing their income (Category 3), while 1.43k individuals indicate that they find it very difficult (Category 4) to make ends meet. The remaining categories (7, 8, and 9) represent refusals, "don't know" responses, or no answers, each with a notably lower frequency.
Very interestingly, the number of respondents coping on their income (18.11k) is 26% higher than those who feel comfortable (14.31k). Financial hardship (categories 3 and 4 combined) affects approximately 7.29k people, which is 40% of those who report living comfortably. A small minority of respondents (fewer than 1k) either refused to answer or were unsure about their income situation.

## 4. Develop association rules with hincfel as a rule consequent

```{r}
hincfel_df <- as.data.frame(table(Survey$hincfel))
```

Discretize and Convert Data to Factors

Ensure relevant columns are factors for association rule mining

```{r}
Survey$hincfel <- as.factor(Survey$hincfel)
Survey$gndr <- as.factor(Survey$gndr)
Survey$edulvlb <- as.factor(Survey$edulvlb)
Survey$cntry <- as.factor(Survey$cntry)
```

Select the relevant columns for association rule mining

```{r}
variables <- Survey[, c("hincfel", "cntry", "polintr", "agea", "gndr", "edulvlb", "hinctnta")]
```

Discretizing continuous variables

```{r}
variables$agea <- discretize(variables$agea, method = "interval", breaks = 4)
variables$hinctnta <- discretize(variables$hinctnta, method = "frequency", breaks = 4)
```

Convert the dataset to transaction format

```{r}
transactions <- as(variables, "transactions")
```

Checking item labels in transactions

```{r}
itemLabels(transactions)  
```

Ensure 'hincfel' is represented correctly in transactions

```{r}
hincfel_levels <- paste0("hincfel=", unique(Survey$hincfel))  # Correct format for item labels in r
```

Apply the Apriori algorithm with 'hincfel' as the consequent (rhs)

```{r}
rules <- apriori(transactions,
                 parameter = list(supp = 0.01, conf = 0.8),
                 appearance = list(rhs = hincfel_levels),  # Ensure 'hincfel' is the consequent
                 control = list(verbose = TRUE))
```

```{r}
inspect(rules)
```


Both rules suggest a strong relationship between people in the Netherlands (cntry=NL), in the income range [7,10), (hinctnta=[7,10)), and the outcome hincfel=1. The rules indicate that when these conditions are present, there's a very high probability (around 81%) of hincfel=1 occurring.
Support and coverage are very low, which suggests that these rules apply to a small proportion of
your total dataset (around 1-1.2%).

The lift value is relatively high (around 2.27), indicating that hincfel=1 is significantly more likely to occur under the given conditions than by chance. The second rule includes an additional condition, agea=[15,261), which doesn't significantly change the overall support, confidence, or lift, suggesting that age within this range (15 to 261) does not drastically alter the likelihood of the outcome (hincfel=1).

Country and Income Level (Rule 1):
There seems to be a significant relationship between individuals in the Netherlands (cntry=NL) with an income range of [7,10) and their likelihood of reporting hincfel=1. The lift of 2.27 indicates that this association is stronger than random chance, which suggests that these characteristics (cntry=NL and hinctnta=[7,10)) are good predictors for hincfel=1.
  
Adding Age (Rule 2):
Including age (agea=[15,261)) doesn't significantly change the strength or support of the rule. The confidence, lift, and support values remain almost identical, which suggests that age does not substantially impact the relationship between the antecedents and hincfel=1 in this case. Therefore, age might not be a key factor in predicting hincfel=1 compared to income and country.
    
Interpretation of Lift:
Both rules have a lift of 2.27, meaning the likelihood of hincfel=1 increases significantly when these combinations of country, income level, and possibly age are present. This reinforces that the factors combined (cntry=NL, hinctnta=[7,10), and optionally agea=[15,261)) are very predictive of hincfel=1.
      
Application of the Rules:
The rules are useful for identifying patterns in the data where certain socio-demographic conditions (like country and income) are strongly associated with a specific outcome (hincfel=1). These insights could be used for targeted interventions or analysis, particularly for individuals with the given socio-demographic characteristics.

## 6. Provide appropriate visualization

```{r}
rule_df <- as(rules, "data.frame")
rule_df <- rule_df[, c("support", "confidence", "lift")]
```

Melt the dataframe to make it suitable for ggplot

```{r}
rule_df_melt <- reshape2::melt(rule_df, variable.name = "Metric", value.name = "Value")
```

```{r}
ggplot(rule_df_melt, aes(x = Metric, y = Value, fill = Metric)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Association Rules Metrics", x = "Metrics", y = "Values") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_fill_manual(values = c("skyblue", "orange", "green"))
```

```{r}
ggplot(rule_df, aes(x = support, y = confidence)) +
  geom_point(aes(color = lift), size = 3) +
  labs(title = "Support vs Confidence of Rules", x = "Support", y = "Confidence") +
  scale_color_gradient(low = "yellow", high = "red") +
  theme_minimal()
```

```{r}
plot(rules, method = "graph", control = list(type = "items"))
```

```{r}
rules_data <- data.frame(
  cntry = c(rep("NL", 2)), 
  agea = c("[15,261)", "[15,261)"), 
  hinctnta = c("[7,10)", "[7,10)"), 
  hincfel = c("1", "1"),
  rule = c("Rule 1", "Rule 2")
)
```

```{r}
rules_data$cntry <- as.factor(rules_data$cntry)
rules_data$agea <- as.factor(rules_data$agea)
rules_data$hinctnta <- as.factor(rules_data$hinctnta)
rules_data$hincfel <- as.factor(rules_data$hincfel)
```

Parallel Coordinates Plot

```{r}
ggpairs(rules_data, aes(color = rule, alpha = 0.5)) +
  labs(title = "Parallel Coordinates Plot of Association Rules")
```

Sankey Diagramm

```{r}
nodes <- data.frame(name = c("cntry=NL", "agea=[15,261)", "hinctnta=[7,10)", "hincfel=1"))
```

```{r}
links <- data.frame(
  source = c(0, 1, 2),  # Indices for the nodes
  target = c(3, 3, 3),  # All lead to "hincfel=1"
  value = c(474, 473, 474)  # Values from the rules count
)
```

```{r}
sankey <- sankeyNetwork(Links = links, Nodes = nodes, Source = "source", Target = "target", Value = "value", NodeID = "name", units = "Instances")

saveWidget(sankey, file = "sankey_diagram_HM_3.html")

sankey
```


## The End
