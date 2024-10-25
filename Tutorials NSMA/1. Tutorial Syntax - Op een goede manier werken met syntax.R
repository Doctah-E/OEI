# Tutorial NSMA - igraph 
# Syntax: Op een goede manier werken met syntax

# Waarom?
# -> Replicatie!!

# libraries die je gaat gebruiken
library(igraph)
library(summarytools)
library(dplyr)

# ik begin het liefst schoon
# R vraagt altijd of je een workspace image wilt bewaren; hoeft niet
graphics.off()
rm(list=ls())

# werkmap aanwijzen
setwd("C:/Surfdrive/temp")         # let op: forward slash
getwd()
dir()

soc_nw <- read.csv("W4_Sociometric_long.csv", header = T, sep = ";")


# --------- Zet hier een logische titel bij deze sectie ------------------

# Sla altijd je syntax op, overschrijf nooit de originele data!!!
write.csv(soc_nw, file="W4_Sociometric_long_bewerkt.csv")


# Controleer alle databewerkingen!!!
freq(soc_nw$Wave)                           # uit library summarytools
soc_nw$Wave <- recode(soc_nw$Wave, "3" = "1", "4" = "2")  # uit lib dplyr
freq(soc_nw$Wave) 

test <- c(1:8, 8, 10)
test
test[9] <- 9
test


# Syntax moet van begin tot einde draaien zonder (cruciale) errors
test[5] <- "wrong"
test


# Gebruik commentaar in overvloed en geef de tekst wat ruimte
cat("Print deze tekst")      # Dit commando stuurt tekst naar de console
cat("Print deze tekst.", "En deze tekst", # Commentaar binnen een commando
    "En deze tekst")   


# Regels laten inspringen en door op de volgende regel
# Zie hierboven


# Maak commando's niet te ingewikkeld. Leesbaarheid gaat voor efficiëntie
test <- data.frame(id = c(1:10), cijfer = sample(c(4:9), 10, replace = T))

test <- data.frame(id = c(1:10), 
                   cijfer = sample(c(1:10), 10, replace = T))

cijfer <- sample(c(4:9), 10, replace = T)
test <- data.frame(id = c(1:10), cijfer)
rm(cijfer)




