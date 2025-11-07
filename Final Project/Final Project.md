# BIOS 512 Final Course Project - Suzi Callis

## 1. Dataset
Dataset: [Dogs Dataset – 3,000 Records](https://www.kaggle.com/datasets/waqi786/dogs-dataset-3000-records)  
Rows: 3,000  
Columns: 5 

### 1.1 Dataset Description

The dataset contains **3,000 observations** and **five variables** describing individual dogs.  

**Numerical Variables:**  
- *Age (Years)* represents each dog’s age, ranging from 1 to 14 years.  
- *Weight (kg)* represents the dog’s body weight, ranging from 5 to 59 kilograms.  
Both variables are continuous and contain no missing values.  

**Categorical Variables:**  
- *Breed* includes 53 distinct dog breeds.  
- *Color* includes 16 different coat color categories.  
- *Gender* indicates the dog’s sex, with two possible values: *Male* and *Female.*  

No missing values are present in the dataset. Minor inconsistencies in categorical formatting (e.g., capitalization of color names) may require standardization prior to analysis.


### 1.2 Codebook

| Column Name    | Type       | Description / Summary                                      | Missing Values | Unique Values |
|----------------|------------|------------------------------------------------------------|----------------|---------------|
| **Breed**      | character  | Dog breed. Examples: “Airedale Terrier”, “Labrador Retriever”, “Jack Russell Terrier”, etc. | 0 | 53 |
| **Age (Years)**| numeric    | Age of the dog in years. Range: 1–14, Median: 8, Mean: 7.5 | 0 | 14 |
| **Weight (kg)**| numeric    | Weight of the dog in kilograms. Range: 5–59, Median: 33, Mean: 32.1 | 0 | 55 |
| **Color**      | character  | Primary color(s) of the dog. Examples: “White”, “Tan”, “Spotted”, “Bicolor”, etc. | 0 | 10 |
| **Gender**     | character  | Gender of the dog. Values: “Male”, “Female” | 0 | 2 |


## 2. Data Analysis

### 2.1 Summary of Data


```R
library(tidyverse)
dogs <- read.csv("dogs_dataset.csv")
summary(dogs)

# Check for missing values
sapply(dogs, function(x) sum(is.na(x)))

# Rename columns
names(dogs) <- c("Breed", "Age", "Weight", "Color", "Gender")
```

    ── [1mAttaching core tidyverse packages[22m ──────────────────────── tidyverse 2.0.0 ──
    [32m✔[39m [34mdplyr    [39m 1.1.2     [32m✔[39m [34mreadr    [39m 2.1.4
    [32m✔[39m [34mforcats  [39m 1.0.0     [32m✔[39m [34mstringr  [39m 1.5.0
    [32m✔[39m [34mggplot2  [39m 3.4.2     [32m✔[39m [34mtibble   [39m 3.2.1
    [32m✔[39m [34mlubridate[39m 1.9.2     [32m✔[39m [34mtidyr    [39m 1.3.0
    [32m✔[39m [34mpurrr    [39m 1.0.1     
    ── [1mConflicts[22m ────────────────────────────────────────── tidyverse_conflicts() ──
    [31m✖[39m [34mdplyr[39m::[32mfilter()[39m masks [34mstats[39m::filter()
    [31m✖[39m [34mdplyr[39m::[32mlag()[39m    masks [34mstats[39m::lag()
    [36mℹ[39m Use the conflicted package ([3m[34m<http://conflicted.r-lib.org/>[39m[23m) to force all conflicts to become errors



        Breed            Age..Years.      Weight..kg.       Color          
     Length:3000        Min.   : 1.000   Min.   : 5.00   Length:3000       
     Class :character   1st Qu.: 4.000   1st Qu.:19.00   Class :character  
     Mode  :character   Median : 8.000   Median :33.00   Mode  :character  
                        Mean   : 7.499   Mean   :32.06                     
                        3rd Qu.:11.000   3rd Qu.:45.00                     
                        Max.   :14.000   Max.   :59.00                     
        Gender         
     Length:3000       
     Class :character  
     Mode  :character  
                       
                       
                       



<style>
.dl-inline {width: auto; margin:0; padding: 0}
.dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}
.dl-inline>dt::after {content: ":\0020"; padding-right: .5ex}
.dl-inline>dt:not(:first-of-type) {padding-left: .5ex}
</style><dl class=dl-inline><dt>Breed</dt><dd>0</dd><dt>Age..Years.</dt><dd>0</dd><dt>Weight..kg.</dt><dd>0</dd><dt>Color</dt><dd>0</dd><dt>Gender</dt><dd>0</dd></dl>



### 2.2 Color


```R
library(tidyverse)
color_summary <- dogs %>%
  group_by(Color) %>%
  summarise(Count = n()) %>%
  arrange(desc(Count))
color_summary
```


<table class="dataframe">
<caption>A tibble: 16 × 2</caption>
<thead>
	<tr><th scope=col>Color</th><th scope=col>Count</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Black and White</td><td>205</td></tr>
	<tr><td>Bicolor        </td><td>200</td></tr>
	<tr><td>Brindle        </td><td>200</td></tr>
	<tr><td>Merle          </td><td>199</td></tr>
	<tr><td>Sable          </td><td>199</td></tr>
	<tr><td>Black and Tan  </td><td>193</td></tr>
	<tr><td>Blue           </td><td>191</td></tr>
	<tr><td>Spotted        </td><td>191</td></tr>
	<tr><td>Brown          </td><td>189</td></tr>
	<tr><td>Red            </td><td>185</td></tr>
	<tr><td>Black          </td><td>184</td></tr>
	<tr><td>White          </td><td>182</td></tr>
	<tr><td>Gray           </td><td>179</td></tr>
	<tr><td>Tan            </td><td>173</td></tr>
	<tr><td>Tricolor       </td><td>166</td></tr>
	<tr><td>Cream          </td><td>164</td></tr>
</tbody>
</table>



#### 2.2.1 Combine "Black and White" and "Black and Tan" into "Bicolor" and update counts


```R
dogs <- dogs %>%
  mutate(Color = if_else(Color %in% c("Black and White", "Black and Tan"), "Bicolor", Color))
dogs %>%
  count(Color, name = "Count") %>%
  arrange(desc(Count))
```


<table class="dataframe">
<caption>A data.frame: 14 × 2</caption>
<thead>
	<tr><th scope=col>Color</th><th scope=col>Count</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Bicolor </td><td>598</td></tr>
	<tr><td>Brindle </td><td>200</td></tr>
	<tr><td>Merle   </td><td>199</td></tr>
	<tr><td>Sable   </td><td>199</td></tr>
	<tr><td>Blue    </td><td>191</td></tr>
	<tr><td>Spotted </td><td>191</td></tr>
	<tr><td>Brown   </td><td>189</td></tr>
	<tr><td>Red     </td><td>185</td></tr>
	<tr><td>Black   </td><td>184</td></tr>
	<tr><td>White   </td><td>182</td></tr>
	<tr><td>Gray    </td><td>179</td></tr>
	<tr><td>Tan     </td><td>173</td></tr>
	<tr><td>Tricolor</td><td>166</td></tr>
	<tr><td>Cream   </td><td>164</td></tr>
</tbody>
</table>



### 2.3 Breed


```R
breed_counts <- dogs %>%
  count(Breed, sort = TRUE)
head(breed_counts, 53)
```


<table class="dataframe">
<caption>A data.frame: 53 × 2</caption>
<thead>
	<tr><th></th><th scope=col>Breed</th><th scope=col>n</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>Rottweiler                   </td><td>118</td></tr>
	<tr><th scope=row>2</th><td>French Bulldog               </td><td> 70</td></tr>
	<tr><th scope=row>3</th><td>Pekingese                    </td><td> 68</td></tr>
	<tr><th scope=row>4</th><td>Pembroke Welsh Corgi         </td><td> 67</td></tr>
	<tr><th scope=row>5</th><td>Doberman Pinscher            </td><td> 66</td></tr>
	<tr><th scope=row>6</th><td>Weimaraner                   </td><td> 66</td></tr>
	<tr><th scope=row>7</th><td>Pug                          </td><td> 65</td></tr>
	<tr><th scope=row>8</th><td>Bichon Frise                 </td><td> 64</td></tr>
	<tr><th scope=row>9</th><td>Cavalier King Charles Spaniel</td><td> 64</td></tr>
	<tr><th scope=row>10</th><td>Chinese Shar-Pei             </td><td> 64</td></tr>
	<tr><th scope=row>11</th><td>Vizsla                       </td><td> 64</td></tr>
	<tr><th scope=row>12</th><td>Poodle                       </td><td> 61</td></tr>
	<tr><th scope=row>13</th><td>Whippet                      </td><td> 60</td></tr>
	<tr><th scope=row>14</th><td>Bloodhound                   </td><td> 59</td></tr>
	<tr><th scope=row>15</th><td>Cocker Spaniel               </td><td> 59</td></tr>
	<tr><th scope=row>16</th><td>Dachshund                    </td><td> 59</td></tr>
	<tr><th scope=row>17</th><td>Border Collie                </td><td> 57</td></tr>
	<tr><th scope=row>18</th><td>Bernese Mountain Dog         </td><td> 56</td></tr>
	<tr><th scope=row>19</th><td>Lhasa Apso                   </td><td> 56</td></tr>
	<tr><th scope=row>20</th><td>Samoyed                      </td><td> 56</td></tr>
	<tr><th scope=row>21</th><td>Airedale Terrier             </td><td> 55</td></tr>
	<tr><th scope=row>22</th><td>Alaskan Malamute             </td><td> 55</td></tr>
	<tr><th scope=row>23</th><td>Beagle                       </td><td> 55</td></tr>
	<tr><th scope=row>24</th><td>Bull Terrier                 </td><td> 55</td></tr>
	<tr><th scope=row>25</th><td>Bulldog                      </td><td> 55</td></tr>
	<tr><th scope=row>26</th><td>Dogo Argentino               </td><td> 55</td></tr>
	<tr><th scope=row>27</th><td>Havanese                     </td><td> 55</td></tr>
	<tr><th scope=row>28</th><td>Irish Setter                 </td><td> 55</td></tr>
	<tr><th scope=row>29</th><td>Jack Russell Terrier         </td><td> 55</td></tr>
	<tr><th scope=row>30</th><td>Miniature Schnauzer          </td><td> 55</td></tr>
	<tr><th scope=row>31</th><td>Great Dane                   </td><td> 54</td></tr>
	<tr><th scope=row>32</th><td>Saint Bernard                </td><td> 54</td></tr>
	<tr><th scope=row>33</th><td>Boston Terrier               </td><td> 53</td></tr>
	<tr><th scope=row>34</th><td>German Shepherd              </td><td> 53</td></tr>
	<tr><th scope=row>35</th><td>Siberian Husky               </td><td> 53</td></tr>
	<tr><th scope=row>36</th><td>Yorkshire Terrier            </td><td> 53</td></tr>
	<tr><th scope=row>37</th><td>Boxer                        </td><td> 52</td></tr>
	<tr><th scope=row>38</th><td>Chesapeake Bay Retriever     </td><td> 52</td></tr>
	<tr><th scope=row>39</th><td>Labrador Retriever           </td><td> 52</td></tr>
	<tr><th scope=row>40</th><td>Maltese                      </td><td> 52</td></tr>
	<tr><th scope=row>41</th><td>Shih Tzu                     </td><td> 52</td></tr>
	<tr><th scope=row>42</th><td>Akita                        </td><td> 51</td></tr>
	<tr><th scope=row>43</th><td>Australian Shepherd          </td><td> 51</td></tr>
	<tr><th scope=row>44</th><td>Shetland Sheepdog            </td><td> 50</td></tr>
	<tr><th scope=row>45</th><td>Basenji                      </td><td> 49</td></tr>
	<tr><th scope=row>46</th><td>Chihuahua                    </td><td> 48</td></tr>
	<tr><th scope=row>47</th><td>Papillon                     </td><td> 48</td></tr>
	<tr><th scope=row>48</th><td>Pomeranian                   </td><td> 48</td></tr>
	<tr><th scope=row>49</th><td>West Highland White Terrier  </td><td> 48</td></tr>
	<tr><th scope=row>50</th><td>Schnauzer                    </td><td> 45</td></tr>
	<tr><th scope=row>51</th><td>Shiba Inu                    </td><td> 45</td></tr>
	<tr><th scope=row>52</th><td>Belgian Malinois             </td><td> 44</td></tr>
	<tr><th scope=row>53</th><td>Golden Retriever             </td><td> 44</td></tr>
</tbody>
</table>



### 2.3 Gender


```R
gender_counts <- dogs %>%
  count(Gender)
gender_counts
```


<table class="dataframe">
<caption>A data.frame: 2 × 2</caption>
<thead>
	<tr><th scope=col>Gender</th><th scope=col>n</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Female</td><td>1520</td></tr>
	<tr><td>Male  </td><td>1480</td></tr>
</tbody>
</table>



## 3. Figures

### 3.1 Figure 1: Age and Weight Distribution


```R
library(ggplot2)
ggplot(dogs, aes(x = Age)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  theme_minimal() +
  labs(title = "Figure 1a: Distribution of Dog Ages (Years)", x = "Age (Years)", y = "Count")

ggplot(dogs, aes(x = Weight)) +
  geom_histogram(binwidth = 5, fill = "lightgreen", color = "black") +
  theme_minimal() +
  labs(title = "Figure 1b: Distribution of Dog Weights (kg)", x = "Weight (kg)", y = "Count")
```


    
![png](output_16_0.png)
    



    
![png](output_16_1.png)
    


### 3.2 Figure 2: Age vs Weight Scatterplot


```R
ggplot(dogs, aes(x = Age, y = Weight)) +
  geom_point(size = 3, color = "blue") +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  theme_minimal() +
  labs(
    title = "Relationship Between Age and Weight",
    x = "Age (years)",
    y = "Weight (kg)"
  )
```

    [1m[22m`geom_smooth()` using formula = 'y ~ x'



    
![png](output_18_1.png)
    


### 3.3 Figure 3: PCA on numeric variables (Age and Weight) to visualize breed, color, and gender patterns


```R
# Load libraries
library(Rtsne)

# 1. Scale Age and Weight
dogs_scaled <- dogs %>%
  mutate(across(c(Age, Weight), ~ as.numeric(scale(.))))
head(dogs_scaled)

# 2. Run PCA
PCA <- prcomp(dogs_scaled %>% select(Age, Weight), center = TRUE, scale. = TRUE)
summary(PCA)

# Optional: PCA rotation matrix
PCA_rotationmatrix <- solve(PCA$rotation)
head(PCA_rotationmatrix)

# 3. Create PCA score data frames with categorical variables
pca_scores <- as_tibble(PCA$x) %>%
  mutate(
    Breed  = dogs$Breed,
    Gender = dogs$Gender,
    Color  = dogs$Color
  )

# 4. Define a reusable plotting function
plot_pca <- function(data, color_var, plot_title) {
  ggplot(data, aes_string(x = "PC1", y = "PC2", color = color_var)) +
    geom_point(alpha = 0.7, size = 3) +
    theme_minimal(base_size = 14) +
    labs(title = plot_title, color = color_var) +
    theme(plot.title = element_text(hjust = 0.5, face = "bold"))
}

# 5. Generate plots
plot_gender <- plot_pca(pca_scores, "Gender", "Figure 3a: PCA of Dogs Dataset (Gender)")
plot_color  <- plot_pca(pca_scores, "Color",  "Figure 3b: PCA of Dogs Dataset (Color)")
plot_breed <- plot_pca(pca_scores, "Breed", "Figure 3c: PCA of Dogs Dataset (Breed)") +
  theme(
    legend.position = "bottom",
    legend.text = element_text(size = 6),
    legend.title = element_text(size = 8)
  ) +
  guides(color = guide_legend(ncol = 4))

# 6. Display plots
print(plot_gender)
print(plot_color)
print(plot_breed)

```


<table class="dataframe">
<caption>A data.frame: 6 × 5</caption>
<thead>
	<tr><th></th><th scope=col>Breed</th><th scope=col>Age</th><th scope=col>Weight</th><th scope=col>Color</th><th scope=col>Gender</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>Airedale Terrier    </td><td> 1.3713971</td><td> 0.1881396</td><td>White  </td><td>Male  </td></tr>
	<tr><th scope=row>2</th><td>Jack Russell Terrier</td><td> 0.6234983</td><td> 0.7000262</td><td>Tan    </td><td>Female</td></tr>
	<tr><th scope=row>3</th><td>Dogo Argentino      </td><td>-1.3708985</td><td>-1.0275909</td><td>Spotted</td><td>Female</td></tr>
	<tr><th scope=row>4</th><td>Labrador Retriever  </td><td> 0.3741987</td><td> 1.5958276</td><td>Bicolor</td><td>Male  </td></tr>
	<tr><th scope=row>5</th><td>French Bulldog      </td><td> 1.1220975</td><td> 0.4440829</td><td>Spotted</td><td>Male  </td></tr>
	<tr><th scope=row>6</th><td>French Bulldog      </td><td> 0.3741987</td><td>-1.5394775</td><td>Bicolor</td><td>Female</td></tr>
</tbody>
</table>




    Importance of components:
                              PC1    PC2
    Standard deviation     1.0016 0.9984
    Proportion of Variance 0.5016 0.4985
    Cumulative Proportion  0.5016 1.0000



<table class="dataframe">
<caption>A matrix: 2 × 2 of type dbl</caption>
<thead>
	<tr><th></th><th scope=col>Age</th><th scope=col>Weight</th></tr>
</thead>
<tbody>
	<tr><th scope=row>PC1</th><td>-0.7071068</td><td> 0.7071068</td></tr>
	<tr><th scope=row>PC2</th><td>-0.7071068</td><td>-0.7071068</td></tr>
</tbody>
</table>



    Warning message:
    “[1m[22m`aes_string()` was deprecated in ggplot2 3.0.0.
    [36mℹ[39m Please use tidy evaluation idioms with `aes()`.
    [36mℹ[39m See also `vignette("ggplot2-in-packages")` for more information.”



    
![png](output_20_4.png)
    



    
![png](output_20_5.png)
    



    
![png](output_20_6.png)
    


### 3.4 Figure 4: t-SNE on numeric variables (Age and Weight) to visualize breed, color, and gender patterns


```R
# 1. Prepare t-SNE input
tsne_input <- dogs %>%
  select(Age, Weight) %>%
  # add tiny noise to avoid exact duplicates
  mutate(
    Age = Age + rnorm(n(), 0, 0.01),
    Weight = Weight + rnorm(n(), 0, 0.01)
  )

# 2. Set seed for reproducibility
set.seed(123)

# 3. Run t-SNE
tsne_result <- Rtsne(
  tsne_input, 
  dims = 2, 
  perplexity = 30, 
  verbose = TRUE, 
  check_duplicates = FALSE
)

# 4. Convert t-SNE output to tibble and add categorical variables
tsne_df <- as_tibble(tsne_result$Y) %>%
  rename(tSNE1 = V1, tSNE2 = V2) %>%
  mutate(
    Breed = dogs$Breed,
    Color = dogs$Color,
    Gender = dogs$Gender
  )

# 5. Define a plotting function
plot_tsne <- function(data, color_var, plot_title) {
  ggplot(data, aes_string(x = "tSNE1", y = "tSNE2", color = color_var)) +
    geom_point(alpha = 0.7, size = 2) +
    theme_minimal(base_size = 14) +
    labs(title = plot_title, color = color_var) +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold"),
      legend.position = "bottom"
    )
}

# 6. Create plots
plot_color <- plot_tsne(tsne_df, "Color", "Figure 4a: t-SNE of Dogs Dataset (Color)")
plot_gender <- plot_tsne(tsne_df, "Gender", "Figure 4b: t-SNE of Dogs Dataset (Gender)")
plot_breed <- plot_tsne(tsne_df, "Breed", "Figure 4c: t-SNE of Dogs Dataset (Breed)") +
  theme(
    legend.position = "bottom",
    legend.text = element_text(size = 6),
    legend.title = element_text(size = 8)
  ) +
  guides(color = guide_legend(ncol = 4))

# 7. Display plots
print(plot_color)
print(plot_gender)
print(plot_breed)
```

    Performing PCA
    Read the 3000 x 2 data matrix successfully!
    OpenMP is working. 1 threads.
    Using no_dims = 2, perplexity = 30.000000, and theta = 0.500000
    Computing input similarities...
    Building tree...
    Done in 0.17 seconds (sparsity = 0.032723)!
    Learning embedding...
    Iteration 50: error is 78.661214 (50 iterations in 0.28 seconds)
    Iteration 100: error is 65.057681 (50 iterations in 0.27 seconds)
    Iteration 150: error is 63.184160 (50 iterations in 0.30 seconds)
    Iteration 200: error is 62.332175 (50 iterations in 0.31 seconds)
    Iteration 250: error is 61.738399 (50 iterations in 0.32 seconds)
    Iteration 300: error is 1.430138 (50 iterations in 0.30 seconds)
    Iteration 350: error is 1.050093 (50 iterations in 0.31 seconds)
    Iteration 400: error is 0.877889 (50 iterations in 0.40 seconds)
    Iteration 450: error is 0.790658 (50 iterations in 0.31 seconds)
    Iteration 500: error is 0.743894 (50 iterations in 0.31 seconds)
    Iteration 550: error is 0.715885 (50 iterations in 0.31 seconds)
    Iteration 600: error is 0.696736 (50 iterations in 0.32 seconds)
    Iteration 650: error is 0.681570 (50 iterations in 0.32 seconds)
    Iteration 700: error is 0.671429 (50 iterations in 0.31 seconds)
    Iteration 750: error is 0.662585 (50 iterations in 0.32 seconds)
    Iteration 800: error is 0.654905 (50 iterations in 0.32 seconds)
    Iteration 850: error is 0.649773 (50 iterations in 0.32 seconds)
    Iteration 900: error is 0.644061 (50 iterations in 0.32 seconds)
    Iteration 950: error is 0.639466 (50 iterations in 0.32 seconds)
    Iteration 1000: error is 0.634755 (50 iterations in 0.32 seconds)
    Fitting performed in 6.28 seconds.


    Warning message:
    “[1m[22mThe `x` argument of `as_tibble.matrix()` must have unique column names if
    `.name_repair` is omitted as of tibble 2.0.0.
    [36mℹ[39m Using compatibility `.name_repair`.”



    
![png](output_22_2.png)
    



    
![png](output_22_3.png)
    



    
![png](output_22_4.png)
    


### 3.5 Figure 5: K-means


```R
# 1. Prepare the data matrix for k-means
dogs_matrix <- dogs %>%
  select(Age, Weight) %>%   # only numeric columns
  as.matrix()

# 2. Run k-means with 3 clusters (adjust centers as needed)
set.seed(123)  # for reproducibility
kmeans_results <- kmeans(dogs_matrix, centers = 3)

# 3. Inspect the cluster centers
print(kmeans_results$centers)

# 4. Optionally, add cluster assignments back to the dogs dataframe
dogs_clustered <- dogs %>%
  mutate(Cluster = kmeans_results$cluster)

# 5. Quick plot of Age vs Weight colored by cluster
library(ggplot2)
ggplot(dogs_clustered, aes(x = Age, y = Weight, color = factor(Cluster))) +
  geom_point(size = 2, alpha = 0.7) +
  theme_minimal() +
  labs(title = "K-means Clustering of Dogs", color = "Cluster")
```

           Age   Weight
    1 7.500525 50.37775
    2 7.455179 13.94622
    3 7.539789 32.75839



    
![png](output_24_1.png)
    


### 3.6 Figure 6: Linear Regression Analysis of Dog Weight by Age, Breed, Color, and Gender


```R
# 1. Optional: Scale numeric columns (Age and Weight)
scale <- function(a) {
  (a - min(a)) / (max(a) - min(a))
}

dogs_scaled <- dogs %>%
  mutate(
    Age = scale(Age),
    Weight = scale(Weight)
  )

# 2. Train/test split
set.seed(123)
train <- runif(nrow(dogs_scaled)) < 0.75
test <- !train

# 3. Define the formula
f <- Weight ~ Age + Breed + Color + Gender

# 4. Fit the linear regression on the training set
m <- lm(f, data = dogs_scaled[train, ])
summary(m)

# 5. Predict on the test set
dogs_test <- dogs_scaled[test, ] %>%
  mutate(Weight_pred = predict(m, newdata = dogs_scaled[test, ]))

# 6. Plot Actual vs Predicted
ggplot(dogs_test, aes(x = Weight, y = Weight_pred)) +
  geom_point(alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0, color = "red") +
  labs(title = "Figure 6a: Actual vs Predicted Dog Weight",
       x = "Actual Weight",
       y = "Predicted Weight")

# 7. Plot Residuals vs Predicted
ggplot(dogs_test, aes(x = Weight_pred, y = Weight - Weight_pred)) +
  geom_point(alpha = 0.5) +
  geom_hline(yintercept = 0, color = "red") +
  labs(title = "Figure 6b: Residuals vs Predicted Weight",
       x = "Predicted Weight",
       y = "Residuals")
```


    
    Call:
    lm(formula = f, data = dogs_scaled[train, ])
    
    Residuals:
        Min      1Q  Median      3Q     Max 
    -0.5961 -0.2514  0.0103  0.2343  0.6067 
    
    Coefficients:
                                        Estimate Std. Error t value Pr(>|t|)    
    (Intercept)                         0.531457   0.050934  10.434   <2e-16 ***
    Age                                -0.023193   0.020054  -1.156   0.2476    
    BreedAkita                          0.015028   0.063247   0.238   0.8122    
    BreedAlaskan Malamute               0.081148   0.062839   1.291   0.1967    
    BreedAustralian Shepherd            0.083378   0.064082   1.301   0.1934    
    BreedBasenji                        0.006729   0.065035   0.103   0.9176    
    BreedBeagle                         0.034478   0.062541   0.551   0.5815    
    BreedBelgian Malinois              -0.027552   0.066705  -0.413   0.6796    
    BreedBernese Mountain Dog           0.011043   0.062600   0.176   0.8600    
    BreedBichon Frise                   0.020482   0.060414   0.339   0.7346    
    BreedBloodhound                    -0.027389   0.061034  -0.449   0.6537    
    BreedBorder Collie                 -0.009607   0.062850  -0.153   0.8785    
    BreedBoston Terrier                 0.058027   0.063887   0.908   0.3638    
    BreedBoxer                          0.051034   0.062168   0.821   0.4118    
    BreedBull Terrier                   0.054058   0.061593   0.878   0.3802    
    BreedBulldog                        0.056343   0.065637   0.858   0.3908    
    BreedCavalier King Charles Spaniel -0.007325   0.059851  -0.122   0.9026    
    BreedChesapeake Bay Retriever      -0.074703   0.063207  -1.182   0.2374    
    BreedChihuahua                     -0.024213   0.064136  -0.378   0.7058    
    BreedChinese Shar-Pei               0.113232   0.062472   1.813   0.0700 .  
    BreedCocker Spaniel                 0.048538   0.060457   0.803   0.4221    
    BreedDachshund                      0.063565   0.064603   0.984   0.3253    
    BreedDoberman Pinscher             -0.046481   0.059920  -0.776   0.4380    
    BreedDogo Argentino                 0.061782   0.062844   0.983   0.3257    
    BreedFrench Bulldog                -0.070458   0.060404  -1.166   0.2436    
    BreedGerman Shepherd               -0.004083   0.062523  -0.065   0.9479    
    BreedGolden Retriever               0.054850   0.063639   0.862   0.3888    
    BreedGreat Dane                     0.032813   0.062040   0.529   0.5969    
    BreedHavanese                      -0.051765   0.065193  -0.794   0.4273    
    BreedIrish Setter                   0.030182   0.061758   0.489   0.6251    
    BreedJack Russell Terrier          -0.045866   0.061720  -0.743   0.4575    
    BreedLabrador Retriever             0.028188   0.063323   0.445   0.6563    
    BreedLhasa Apso                    -0.077511   0.061374  -1.263   0.2067    
    BreedMaltese                        0.015951   0.063785   0.250   0.8026    
    BreedMiniature Schnauzer            0.088784   0.062891   1.412   0.1582    
    BreedPapillon                      -0.072024   0.067929  -1.060   0.2891    
    BreedPekingese                      0.048484   0.059529   0.814   0.4155    
    BreedPembroke Welsh Corgi           0.031910   0.060388   0.528   0.5973    
    BreedPomeranian                     0.037764   0.064197   0.588   0.5564    
    BreedPoodle                         0.060403   0.062963   0.959   0.3375    
    BreedPug                            0.043773   0.058532   0.748   0.4546    
    BreedRottweiler                     0.012977   0.053032   0.245   0.8067    
    BreedSaint Bernard                  0.055211   0.062139   0.889   0.3744    
    BreedSamoyed                        0.046802   0.061299   0.764   0.4452    
    BreedSchnauzer                      0.033757   0.067895   0.497   0.6191    
    BreedShetland Sheepdog             -0.017230   0.062803  -0.274   0.7838    
    BreedShiba Inu                      0.044724   0.065706   0.681   0.4962    
    BreedShih Tzu                       0.075634   0.064700   1.169   0.2425    
    BreedSiberian Husky                -0.053766   0.064110  -0.839   0.4018    
    BreedVizsla                        -0.008004   0.060110  -0.133   0.8941    
    BreedWeimaraner                    -0.017767   0.059348  -0.299   0.7647    
    BreedWest Highland White Terrier   -0.070300   0.065681  -1.070   0.2846    
    BreedWhippet                        0.067563   0.063653   1.061   0.2886    
    BreedYorkshire Terrier             -0.022172   0.062795  -0.353   0.7241    
    ColorBlack                         -0.050059   0.034448  -1.453   0.1463    
    ColorBlack and Tan                 -0.038585   0.033923  -1.137   0.2555    
    ColorBlack and White               -0.049764   0.033738  -1.475   0.1403    
    ColorBlue                          -0.033913   0.034545  -0.982   0.3263    
    ColorBrindle                       -0.032180   0.033282  -0.967   0.3337    
    ColorBrown                         -0.021314   0.033712  -0.632   0.5273    
    ColorCream                         -0.048333   0.035467  -1.363   0.1731    
    ColorGray                          -0.078447   0.034524  -2.272   0.0232 *  
    ColorMerle                         -0.044139   0.033577  -1.315   0.1888    
    ColorRed                           -0.024533   0.034546  -0.710   0.4777    
    ColorSable                         -0.051990   0.033616  -1.547   0.1221    
    ColorSpotted                       -0.066188   0.033956  -1.949   0.0514 .  
    ColorTan                           -0.021116   0.035294  -0.598   0.5497    
    ColorTricolor                      -0.081422   0.035168  -2.315   0.0207 *  
    ColorWhite                         -0.029989   0.034611  -0.866   0.3863    
    GenderMale                          0.005729   0.012526   0.457   0.6475    
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    
    Residual standard error: 0.2904 on 2193 degrees of freedom
    Multiple R-squared:  0.03106,	Adjusted R-squared:  0.0005743 
    F-statistic: 1.019 on 69 and 2193 DF,  p-value: 0.4355




    
![png](output_26_1.png)
    



    
![png](output_26_2.png)
    


## 4. Figure Conclusions 

### 4.1 Figure 1: Age and Weight Distribution
Figure 1a: Distribution of Dog Ages (Years)
This histogram displays the frequency distribution of dogs’ ages (in years). The data span from 1 to 14 years, with most dogs clustered around the median of 8 years. The unimodal shape suggests a relatively balanced sample with no strong age bias, though there may be fewer very young or very old dogs represented.

Figure 1b: Distribution of Dog Weight (kg)
This histogram shows the distribution of dog weights (in kilograms). Weights range from 5 to 59 kg, with a concentration around the median of 33 kg. The right tail indicates the presence of heavier breeds, implying moderate right-skewness in the population weight distribution.

### 4.2 Figure 2: Age VS. Weight Scatterplot
This scatter plot explores the relationship between dog age and weight. The cloud of points indicates no strong linear correlation; heavier dogs appear across most age groups. However, some clustering may occur for medium-weight dogs around ages 5–10, typical of adult life stages.

### 4.3 Figure 3: PCA 
The first two principal components capture all variance, confirming that the two numeric features (Age and Weight) are sufficient to describe the dataset’s linear structure. PC1 captures the inverse relationship between age and weight, while PC2 captures their simultaneous variation.

Figure 3a: PCA of Dogs Dataset (Gender): There is no visible separation between male and female dogs in the PCA space. Both genders overlap entirely across the two principal components. This suggests that Age and Weight distributions are similar between genders, meaning there is no strong gender-based pattern in these features.

Figure 3b: PCA of Dogs Dataset (Color): Similar to the gender PCA, dogs of all coat colors are distributed throughout the PCA space without clear groupings. This implies that color is not correlated with either age or weight — these physical attributes are independent of coat color in the dataset.

Figure 3c: PCA of Dogs Dataset (Breed) There is still a large degree of overlap between breeds, though some mild clustering can be observed for certain breeds. This overlap suggests that age and weight alone do not fully distinguish breeds, though some breeds may occupy characteristic ranges (e.g., larger or smaller dogs).
To separate breeds more effectively, additional features (such as height, lifespan, or body measurements) would likely be needed.

### 4.4 Figure 4: t-SNE
Figure 4a: t-SNE of Dogs Dataset (Color): The plot shows that color does not appear to form distinct clusters in the t-SNE space — dogs of different colors are well mixed. This suggests that coat color is not strongly correlated with the other features in the dataset (e.g., breed, size, or weight). Color variation is likely distributed across multiple breeds and characteristics rather than being a defining or separating feature.

Figure 4b: t-SNE of Dogs Dataset (Gender): Male and female dogs are distributed almost evenly across the entire space. There are no clear separations or clusters based on gender. This implies that gender has little to no influence on the combination of features that define similarity between dogs in the dataset.

Figure 4c: Some clustering by breed can be observed — certain groups of points appear to be more tightly clustered. This indicates that breed is a stronger factor influencing the dogs’ features (such as weight, height, or other attributes). However, there is still some overlap between breeds, which may reflect similarities between certain types of dogs or mixed-breed individuals.

### 4.5 Figure 5: Kmeans
The figure shows a scatter plot with Age vs. Weight, with dogs grouped into three clusters identified by K-means clustering.

Cluster 1 (red) represents heavier dogs (likely large breeds).
Cluster 2 (green) represents lighter dogs.
Cluster 3 (blue) represents medium-weight dogs.

Age does not strongly separate the clusters — the key distinction appears to be driven by weight, suggesting that weight alone captures much of the natural grouping among dogs.

### 4.6 Figure 6: Comparison of Average Dog Weight Across Breeds
Figure 6a: Actual vs Predicted Dog Weight
This scatter plot compares actual vs. predicted weights from a regression model, with the red line representing the ideal 1:1 relationship (perfect predictions).
The data points are widely scattered around the red line, indicating a fair amount of prediction error. The model captures some general trends, but it struggles to predict weight precisely for individual dogs.
Possible reasons: high variability within breeds, missing predictive features, or limited training data.

Figure 6b: Residuals vs Predicted Weight
This plot shows the residuals (errors between predicted and actual weight) plotted against the predicted weight values.
The residuals appear randomly scattered around zero, without a clear pattern.
This suggests that the model’s errors are not systematically biased — a good sign of model validity. However, the spread of residuals indicates that predictions still have moderate variance, meaning the model could be improved with more features or non-linear methods.

## 5. Exploratory Questions

### 5.1 Do older dogs tend to weigh more than younger dogs stratified by breed?
Figure 2 Age vs Weight Scatterplot showed the relationship between dog age and weight. No strong linear correlation was found. To further understand the relationship between age and weight, stratifying by breed will better show the growth patterns of the dogs. 


```R
ggplot(dogs, aes(x = Age, y = Weight)) +
  geom_point(alpha = 0.6, size = 2, color = "steelblue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  facet_wrap(~ Breed, scales = "free_y") +
  theme_minimal(base_size = 13) +
  labs(
    title = "Age vs. Weight by Breed",
    x = "Age (years)",
    y = "Weight (kg)"
  )
```

    [1m[22m`geom_smooth()` using formula = 'y ~ x'



    
![png](output_36_1.png)
    


### 5.2 Do certain breeds have more color variation than others?
Previous analyses (Figures 3b and 4a) showed that coat color is not correlated with weight or age. However, those results did not examine the relationship between breed and color variation. It is possible that some breeds have a wider range of acceptable or naturally occurring coat colors, while others are more uniform.
To explore this question, the number of unique coat colors should be calculated for each breed and it can be visualized using a heatmap to highlight which breeds display the greatest color diversity.


```R
color_diversity <- dogs %>%
  group_by(Breed) %>%
  summarise(Color_Diversity = n_distinct(Color)) %>%
  arrange(desc(Color_Diversity))
print(color_diversity, n=53)

#Heatmap
ggplot(color_diversity, 
       aes(x = "", 
           y = reorder(Breed, Color_Diversity), 
           fill = Color_Diversity)) +
  geom_tile(color = "white", height = 0.8) +
  scale_fill_gradient(low = "lightyellow", high = "firebrick") +
  theme_minimal(base_size = 13) +
  labs(
    title = "Heatmap of Coat Color Diversity Across Breeds",
    x = NULL,
    y = "Breed",
    fill = "Unique Colors"
  ) +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.text.y = element_text(size = 9),
    plot.title = element_text(face = "bold", hjust = 0.5)
  )
```


    Error in dogs %>% group_by(Breed) %>% summarise(Color_Diversity = n_distinct(Color)) %>% : could not find function "%>%"
    Traceback:



### 5.3 Are certain breeds heavier than other breeds?
Figures 3c and 4c indicate that breed may play a stronger role in explaining variation in weight. Mild clustering by breed was observed in both the PCA and t-SNE plots, suggesting that dogs of similar breeds tend to share comparable size profiles.

To investigate this relationship more directly, the distribution of weights across breeds could be examined using summary statistics and a boxplot. This analysis helps clarify whether certain breeds are consistently heavier or lighter than others, and whether breed type can meaningfully account for differences in body weight.


```R
# Calculate mean and SD of weight per breed
breed_weights <- dogs %>%
  group_by(Breed) %>%
  summarise(
    Mean_Weight = mean(Weight, na.rm = TRUE),
    SD_Weight = sd(Weight, na.rm = TRUE),
    Count = n()
  ) %>%
  arrange(desc(Mean_Weight))
print(breed_weights, n = 53)

# Boxplot of Weight by Breed
ggplot(dogs, aes(x = reorder(Breed, Weight, median), y = Weight, fill = Breed)) +
  geom_boxplot(show.legend = FALSE, alpha = 0.8) +
  coord_flip() +
  theme_minimal(base_size = 13) +
  labs(
    title = "Distribution of Dog Weight Across Breeds",
    x = "Breed",
    y = "Weight (kg)"
  )
```

    [90m# A tibble: 53 × 4[39m
       Breed                         Mean_Weight SD_Weight Count
       [3m[90m<chr>[39m[23m                               [3m[90m<dbl>[39m[23m     [3m[90m<dbl>[39m[23m [3m[90m<int>[39m[23m
    [90m 1[39m Chinese Shar-Pei                     38.2      14.0    64
    [90m 2[39m Golden Retriever                     35.5      16.5    44
    [90m 3[39m Miniature Schnauzer                  35.3      15.1    55
    [90m 4[39m Alaskan Malamute                     34.6      14.9    55
    [90m 5[39m Bulldog                              34.6      14.8    55
    [90m 6[39m Pembroke Welsh Corgi                 34.5      14.7    67
    [90m 7[39m Saint Bernard                        34.3      14.3    54
    [90m 8[39m Bull Terrier                         34.2      16.0    55
    [90m 9[39m Dachshund                            33.9      14.8    59
    [90m10[39m Dogo Argentino                       33.7      15.5    55
    [90m11[39m Pug                                  33.6      17.3    65
    [90m12[39m Poodle                               33.5      15.4    61
    [90m13[39m Australian Shepherd                  33.4      16.4    51
    [90m14[39m Pekingese                            33.3      16.2    68
    [90m15[39m Bernese Mountain Dog                 33.3      16.4    56
    [90m16[39m Irish Setter                         33.1      16.9    55
    [90m17[39m Shih Tzu                             33.1      15.7    52
    [90m18[39m Boston Terrier                       33.0      18.5    53
    [90m19[39m Samoyed                              33.0      13.8    56
    [90m20[39m Whippet                              32.7      15.2    60
    [90m21[39m Schnauzer                            32.6      14.2    45
    [90m22[39m Great Dane                           32.6      15.6    54
    [90m23[39m Beagle                               32.5      15.6    55
    [90m24[39m Bloodhound                           32.3      17.0    59
    [90m25[39m Pomeranian                           32.2      14.4    48
    [90m26[39m Boxer                                32.2      15.7    52
    [90m27[39m Papillon                             32.1      16.9    48
    [90m28[39m Cocker Spaniel                       32.1      18.3    59
    [90m29[39m Bichon Frise                         32.0      15.7    64
    [90m30[39m Basenji                              31.9      17.3    49
    [90m31[39m Labrador Retriever                   31.9      15.8    52
    [90m32[39m German Shepherd                      31.9      15.3    53
    [90m33[39m Airedale Terrier                     31.8      14.0    55
    [90m34[39m Akita                                31.7      14.4    51
    [90m35[39m Havanese                             31.6      16.2    55
    [90m36[39m Shiba Inu                            31.5      13.5    45
    [90m37[39m Maltese                              31.3      13.7    52
    [90m38[39m Rottweiler                           30.7      15.8   118
    [90m39[39m Border Collie                        30.5      15.9    57
    [90m40[39m Chihuahua                            30.2      16.0    48
    [90m41[39m Cavalier King Charles Spaniel        30.2      15.5    64
    [90m42[39m Shetland Sheepdog                    30.2      16.5    50
    [90m43[39m Doberman Pinscher                    30.1      16.6    66
    [90m44[39m Vizsla                               30.0      15.1    64
    [90m45[39m Lhasa Apso                           29.9      15.8    56
    [90m46[39m Weimaraner                           29.9      14.4    66
    [90m47[39m Jack Russell Terrier                 29.5      14.8    55
    [90m48[39m West Highland White Terrier          29.5      18.1    48
    [90m49[39m Yorkshire Terrier                    29.5      14.2    53
    [90m50[39m Belgian Malinois                     29.1      15.3    44
    [90m51[39m French Bulldog                       29.0      15.2    70
    [90m52[39m Chesapeake Bay Retriever             28.2      15.0    52
    [90m53[39m Siberian Husky                       28.2      15.9    53



    
![png](output_40_1.png)
    

