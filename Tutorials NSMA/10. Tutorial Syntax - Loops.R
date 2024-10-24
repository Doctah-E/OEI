# Tutorial NSMA - igraph 
# Syntax: For and while loops

library(igraph)
graphics.off()
rm(list=ls())

# For loops algemeen
tkst <- "we zitten in loop"
for (i in 1:10) {
  cat(tkst, i, "\n")
}

for (i in seq(5, 50, by = 5)) {
  j <- 25 + i * 3
  cat("j=", j, "\n")
}

# als je houdt van een schone omgeving 
rm(i, j, tkst)


# For loops over variabelen heen
data <- as.data.frame(matrix(1, 5, 100))
data["V1"] <- 2
names(data)
for (v in names(data)[1:5]){
  data[v] <- 2
}

# soms heb je positie van variabelen niet 
names(data)

# gebruik van which()
which(names(data) == "V74")
which(names(data) == "V93")
names(data) == "V93"

vars <- names(data)[which(names(data) == "V74"):which(names(data) == "V93")]
vars

for (v in vars) {
  data[v] <- data[v] + 55
}


# while loops. loopt net zolang als voorwaarde True is
# let op: dit kan ook oneindig zijn
a <- 1
while (a <= 10) {
  cat("we zitten in loop:", a, "\n")
  a <- a + 1
}

data <- data.frame(id = 1:20,
                   school = c(rep(1, 7), rep(2, 9), rep(3, 4)),
                   klas = c(1, 1, 1, 1, 2, 2, 2,
                          1, 1, 1, 2, 2, 2, 3, 3, 3,
                          1, 1, 1, 1))

# stel je wilt over alle scholen en klassen heen loopen
# bij scholen eenvoudig, maar klassen niet
for (s in 1:3) {
  k <- 1
  while(k %in% data$klas[data$school == s]) {
    cat("school", s, "klas", k, "bestaat\n")
    k <- k + 1
  }
}





