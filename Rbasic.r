setwd("C:\\Users\\Desktop")

# Load necessary libraries
library(readxl)
library(dplyr)
library(ggplot2)
library(scales)

# Load dataset
data<-read_xlsx("For patero.xlsx")  # Adjust the file path if needed

# Convert column names to lowercase to avoid mismatches
colnames(data) <- tolower(colnames(data))  

# Check available column names
print(colnames(data))

# Ensure required columns exist
if (!all(c("vendor", "spend") %in% colnames(data))) {
  stop("Ensure 'vendor' and 'spend' columns exist in your dataset.")
}

# Convert 'spend' column to numeric if it's not already
data <- data %>%
  mutate(spend = as.numeric(spend))

# Aggregate spend per vendor (if vendors are repeated)
vendor_spend <- data %>%
  group_by(vendor) %>%
  summarise(spend = sum(spend, na.rm = TRUE)) %>%
  arrange(desc(spend))  # Sort vendors by spend

# Check if data loaded correctly
head(vendor_spend)

# Compute cumulative spend percentage
vendor_spend <- vendor_spend %>%
  mutate(cumulative_spend = cumsum(spend),
         total_spend = sum(spend),
         cumulative_percent = (cumulative_spend / total_spend) * 100)

# Plot Pareto chart
ggplot(vendor_spend, aes(x = reorder(vendor, -spend))) +
  geom_bar(aes(y = spend), stat = "identity", fill = "steelblue") +  
  geom_line(aes(y = cumulative_percent * max(spend) / 100, group = 1), 
            color = "red", size = 1) +  
  geom_hline(yintercept = 0.8 * max(vendor_spend$cumulative_spend), 
             linetype = "dashed", color = "green", size = 1) +
  scale_y_continuous(sec.axis = sec_axis(~ . / max(vendor_spend$spend) * 100, 
                                         name = "Cumulative % (Right Axis)")) +
  labs(title = "Pareto Analysis of Vendor Spend",
       x = "Vendors",
       y = "Spend ($)") +
  theme_minimal() +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())

