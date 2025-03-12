# Plant Mitochondrial Volume Statistics

This repository contains an **R script** for analyzing mitochondrial volume data in plant cells. The script performs **statistical tests and visualizations**, including boxplots, normality tests, Kruskal-Wallis tests, and post-hoc Dunn's test.

## Prerequisites
Before running the script, ensure you have **R installed** and install the required R packages:

```r
install.packages(c("tidyverse", "ggpubr", "ggsignif", "FSA"))
```

## Usage

### Clone the repository
git clone https://github.com/manuquimica/mitovolume.git

### Navigate to the project directory
cd mitovolume
```

### 2) Open R and Load the Script

### 3) Set the Correct File Path in the Script
Modify the script to point to your **CSV file**:
```r
setwd("/Users/yourname/Documents")  # Update with your actual path
data <- read_csv(“YourFile.csv")
```
Ensure your dataset is formatted as follows:
| treatment | volume |
|-----------|--------|
| control   | 2.28   |
| treatment1   | 0.88   |
| treatment2      | 0.79   |

### 4) Run the Script in R
```r
source("mitovolume.R")
```

##  Features
- **Boxplots** for mitochondrial volume comparison.  
- **IQR-based outlier filtering** before statistical analysis.  
- **Shapiro-Wilk normality test** per treatment group.  
- **Kruskal-Wallis test** for overall group differences.  
- **Dunn’s test** for multiple comparisons (if applicable).  

##  Output
- A boxplot displaying mitochondrial volume distributions across treatment groups.
- Results of Shapiro-Wilk tests before and after filtering.
- Kruskal-Wallis test output to check for significant differences.
- Dunn’s post-hoc test results, if necessary.

##  Contributing
Feel free to submit issues or pull requests for improvements or bug fixes.

## License
This project is licensed under the **GNU General Public License (GPL) v3.0**. See the LICENSE file for details.

## Contact
For any questions, reach out at **manu@unam.mx** or open an issue on this repository.

---

