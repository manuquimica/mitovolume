#### PLANT MITOCHONDRIAL VOLUME STATISTICS ####

# Load necessary libraries (install separately if needed)
library(tidyverse)
library(readxl)
library(ggpubr)
library(ggsignif)
library(viridisLite)
library(FSA) # For Dunn's test

# Load data: You will need to specify the data file location and name
setwd("/Users/yourname/Documents") # This is the data file location
data <- read_excel("YourFile.xlsx") # This is the data file name
View(data)

#### Box Plot ####

my_comparisons <- list(c("control", "calcium"), c("control", "CsA"), c("calcium", "CsA"))

# Chart ordered by levels on the x-axis.
data$treatment <- factor(data$treatment, levels = c("control", "calcium", "CsA"))

# Create boxplot
boxplot <- ggplot(data, aes(y = volume, x = treatment)) +
  geom_boxplot(aes(fill = treatment, colour = treatment), 
               alpha = 0.5, size = 0.35) +
  theme_classic(base_size = 15) + 
  theme(legend.position = "none") +
  labs(x = "Treatments", y = "Mitochondrial volume (µm³)") +
  scale_fill_brewer(palette = "Dark2") +
  scale_colour_brewer(palette = "Dark2") +
  scale_y_log10()

# Plot without statistics
print(boxplot)

# Plot with statistics
boxplot + stat_compare_means(comparisons = my_comparisons, method = "wilcox.test", label = "p.signif")

#### Normality test for individual groups ####

group1 <- data %>% filter(treatment == "control") %>% pull(volume)
group2 <- data %>% filter(treatment == "calcium") %>% pull(volume)
group3 <- data %>% filter(treatment == "CsA") %>% pull(volume)

shapiro_test_group1 <- shapiro.test(group1)
shapiro_test_group2 <- shapiro.test(group2)
shapiro_test_group3 <- shapiro.test(group3)

print(shapiro_test_group1)
print(shapiro_test_group2)
print(shapiro_test_group3)

#### Kruskal-Wallis test ####

kruskal_result <- kruskal.test(volume ~ treatment, data = data)
print(kruskal_result)

#### Post hoc test (Dunn’s test) ####

if (kruskal_result$p.value < 0.05) {
  dunn_result <- dunnTest(volume ~ treatment, data = data, method = "bonferroni")
  print(dunn_result)
} else {
  print("No significant differences detected, skipping post-hoc test.")
}
