# Tutorial NSMA
# For loops

library(summarytools)
library(dplyr)

graphics.off()
rm(list=ls())

d <- mtcars
d


# ----------- For loops algemeen ------------------------

# vergelijkbare bewerkingen herhalen
names(d)
# alle namen laten eindigen met "_orig"
names(d)[1]
names(d)[1] <- "mpg_orig"
names(d)
names(d)[2] <- paste0(names(d)[2], "_orig")
names(d)

# een loop draait dezelfde bewerking met kleine variaties
# en heeft altijd een index (variabele) om bij te houden in welke loop je zit
for (i in 1:10) {
    cat("dit is loop nummer: ", i, "\n")
}

groeten <- c("hallo", "hoi", "dag")
groeten 

for (g in groeten) {
    cat(g, "\n")
}
# Dus: het bovenstaande is voor R exact hetzelfde als:
cat("hallo", "\n")
cat("hoi", "\n")
cat("dag", "\n")


# nu loopen over names(d)
# hoe vaak moet dat? 
length(names(d))

# kun je gebruiken voor aantal loops
# en index kun je gebruiken om elke loop iets anders te maken
# nu: "_orig" toevoegen aan namen
d <- mtcars
for (i in 1:length(names(d))) {
    names(d)[i] <-  paste0(names(d)[i], "_orig")
}
names(d)


# ------------- Ingebouwde loops in R ------------------------

# Loops over vectoren
d <- mtcars
d
round(5.5)
round(d$mpg)

# Loops over variabelen heen
freq(d$cyl)
freq(d[c("cyl", "am", "gear", "carb")])


# Bij eigen bewerkingen kun je dat zelf ook programmeren
vars <- d[c("cyl", "am", "gear", "carb")]
vars
for (i in 1:length(vars)) {
  vars[i] <- vars[i] + 10
}
vars


# En soms wil je ook wel eens loopen over de waardes van een variabele
# bijvoorbeeld minste en meeste horsepower binnen groep met evenveel cylinders
d
# (dit kan efficiënter, maar het gaat om het overbrengen van het idee)

# hoe krijg ik de vector met waardes waarover ik wil loopen?
d$cyl
unique(d$cyl)
sort(unique(d$cyl))

# opzet loop (zonder inhoud)
for (i in sort(unique(d$cyl))) {   
    cat("i= ", i, "\n")
}

# vervolgens inhoud invullen
# min en max horsepower (hp) uitdraaien
for (i in sort(unique(d$cyl))) {   
    cat("cyl= ", i, "\n", 
        "min hp= ", min(d$hp[d$cyl == i]), "\n",
        "max hp= ", max(d$hp[d$cyl == i]), "\n")
}
d %>% arrange(cyl)


# Als je dit ingewikkeld vindt probeer een loop dan net zo te lezen als R dat doet!







