options(repos = c(CRAN = "https://cran.r-project.org"))

# Install tidyverse only if it's not already available
if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages("tidyverse")
}
