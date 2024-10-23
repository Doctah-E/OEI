# Tutorial R 
# Gebruiken van ingebouwde hulp

library(dplyr)


# ----------------------- 1. ? of help() -------------------------------------

help(rowSums)
?rowSums
# of gebruiken <F1> toets
rowSums(matrix(c(1,2,3,4), ncol = 2))


# Lezen van help documentatie
?rowSums
x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
data <- as.data.frame(x)
data
rowSums(data)
data$rs <- rowSums(data)
data

?rename
data <- rename(data, score1= x1)
data
data <- data %>% rename(score2 = x2)    
data


# --- 2. <Tab> toets om argumenten te laten zien (en voor auto completion) ---

data$rm <- rowMeans(data)


# 3. Overzicht functies package: vignettes

vignette()
vignette(package= "dplyr")
browseVignettes()

vignette("dplyr", package = "dplyr")






