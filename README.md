# Plant Mitochondrial Volume Statistics

This repository contains an R script for analyzing mitochondrial volume data in plant cells. The script performs statistical tests and visualizations, including boxplots, normality tests, Kruskal-Wallis tests, and post-hoc analysis.

## Prerequisites
Before running the script, make sure you have R installed. You will also need the following R packages:

```r
install.packages(c("tidyverse", "readxl", "ggpubr", "ggsignif", "viridisLite", "FSA"))
```

## Usage

1. **Clone the repository**
   ```sh
   git clone https://github.com/yourusername/mitochondrial-volume-analysis.git
   cd mitochondrial-volume-analysis
   ```

2. **Open R or RStudio** and load the script.

3. **Edit the file path** in the script to specify the correct location of your data file:
   ```r
   setwd("/Users/yourname/Documents")
   data <- read_excel("YourFile.xlsx")
   ```
   Replace `YourFile.xlsx` with the actual name of your dataset. IMPORTANT: Your data file must be formatted as a two-column spreadsheet. The first column will be the “treatments” column and must include all conditions tested (i.e. control, calcium, etc). The second column will include mitochondrial volume values.

4. **Run the script** in R.

## Features
- **Boxplots** to visualize mitochondrial volume differences between treatments.
- **Statistical comparisons** using the Wilcoxon test.
- **Normality tests** using the Shapiro-Wilk test.
- **Kruskal-Wallis test** to check for overall differences.
- **Dunn’s test** for post-hoc comparisons when significant differences are found.

## Output
- A **boxplot** displaying mitochondrial volume distributions across treatment groups.
- Results of **normality tests** for each treatment.
- **Kruskal-Wallis test output** to determine if significant differences exist.
- **Dunn’s post-hoc test results**, if applicable.

## Contributing
Feel free to submit issues or pull requests if you have improvements or bug fixes.

## License
This project is licensed under the GNU General Public License (GPL) v3.0. See the LICENSE file for details.

## Contact
For any questions, reach out at [manu@unam.mx] or open an issue on this repository.

--

