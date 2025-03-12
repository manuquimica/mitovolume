#### PLANT MITOCHONDRIAL VOLUME STATISTICS ####

# Load necessary libraries
library(tidyverse)
library(ggpubr)
library(ggsignif)
library(FSA) # For Dunn's test
library(conflicted)
conflict_prefer("filter", "dplyr")
conflict_prefer("lag", "dplyr")

# Load data: You will need to specify the data file location and name below
setwd("/Users/yourname/Documents")  
# Set working directory (update as needed)
data <- read_csv("YourFile.csv")  # Load data (assumed CSV format)

# Ensure treatment is a factor with correct levels
data$treatment <- factor(data$treatment, levels = c("control", "calcium", "CsA"))

# View dataset structure
print(head(data))

#### Normality Test Before Filtering ####
shapiro_test_results <- data %>% group_by(treatment) %>% summarise(p_value = shapiro.test(volume)$p.value)
print(shapiro_test_results)

# Check if all groups have p > 0.05 (indicating normality)
all_normal <- all(shapiro_test_results$p_value > 0.05)

#### IQR Filtering ####
Q1 <- quantile(data$volume, 0.25)
Q3 <- quantile(data$volume, 0.75)
IQR_value <- Q3 - Q1
lower_limit <- Q1 - 1.5 * IQR_value
upper_limit <- Q3 + 1.5 * IQR_value

data_filtered <- data %>% dplyr::filter(volume >= lower_limit & volume <= upper_limit)

# View filtered dataset
print(head(data_filtered))

#### Normality Test After Filtering ####
shapiro_test_results_filtered <- data_filtered %>% group_by(treatment) %>% summarise(p_value = shapiro.test(volume)$p.value)
print(shapiro_test_results_filtered)

# Re-check if all groups have p > 0.05 after filtering
all_normal_filtered <- all(shapiro_test_results_filtered$p_value > 0.05)

#### Statistical Test Selection ####
if (all_normal_filtered) {
  print("Data is normally distributed. Running ANOVA + Tukey's test.")
  anova_result <- aov(volume ~ treatment, data = data_filtered)
  print(summary(anova_result))
  
  # Tukey's post-hoc test
  tukey_result <- TukeyHSD(anova_result)
  print(tukey_result)
} else {
  print("Data is NOT normally distributed. Running Kruskal-Wallis + Dunn's test.")
  
  # Kruskal-Wallis test
  kruskal_result <- kruskal.test(volume ~ treatment, data = data_filtered)
  print(kruskal_result)
  
  # Post hoc test (Dunn’s test)
  if (kruskal_result$p.value < 0.05) {
    dunn_result <- dunnTest(volume ~ treatment, data = data_filtered, method = "bonferroni")
    print(dunn_result)
  } else {
    print("No significant differences detected, skipping post-hoc test.")
  }
}

#### Boxplot Visualization ####
my_comparisons <- list(c("control", "calcium"), c("control", "CsA"), c("calcium", "CsA"))

boxplot <- ggplot(data_filtered, aes(y = volume, x = treatment, fill = treatment)) +
  geom_boxplot(alpha = 0.5, color = "black", outlier.shape = NA) +
  geom_jitter(aes(color = treatment), width = 0.2, alpha = 0.5) +
  theme_classic(base_size = 15) +
  labs(x = "Treatments", y = "Mitochondrial Volume (µm³)") +
  scale_fill_brewer(palette = "Dark2") +
  scale_color_brewer(palette = "Dark2") +
  scale_y_log10() +
  stat_compare_means(comparisons = my_comparisons, method = "wilcox.test", label = "p.signif")

print(boxplot)

