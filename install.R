options(repos = c(CRAN = "https://cran.r-project.org"))

if (!requireNamespace("readr", quietly = TRUE)) {
  install.packages("readr")
}
install.packages(c("readr", "tidyr", "ggplot2"))
