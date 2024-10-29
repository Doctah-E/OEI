# Tutorial NSMA 
# Op een goede manier werken met een script file

# Waarom?
# - voor je eigen begrip
# - replicatie!!

# begin libraries die je gaat gebruiken
library(summarytools)
library(dplyr)

# ik begin het liefst schoon. kan ook door op "de bezems" te klikken
graphics.off()
rm(list=ls())

# werkmap aanwijzen
# gebruik "..." in de "Files" tab icm "Copy folder path to clipboard"
setwd("C:/temp")         # let op: forward slash

getwd()
dir()

# default slaat R dan daar bestanden op
write.csv(mtcars, file= "Test.csv")


# meestal open je hier data
# R zoekt in je working directory als je geen pad opgeeft
d <- read.csv("Test.csv")


# ----------- Zet hier een logische titel bij deze sectie ------------------

# Sla altijd je script file op, overschrijf nooit de originele data!!!
# R vraagt altijd of je een workspace image wilt bewaren; hoeft niet


# Controleer alle databewerkingen!!!
freq(d$cyl)                           # uit library summarytools
d$cyl4_plus <- case_match(d$cyl, 4 ~ 0, 6:8 ~ 1)  # uit lib dplyr
freq(d$cyl4_plus) 


# Syntax moet van begin tot einde draaien zonder errors
# Let op: errors zijn niet hetzelfde als warnings


# Gebruik commentaar in overvloed en geef de tekst wat ruimte
cat("Print deze tekst")      # Dit commando stuurt tekst naar de console
cat("Print deze tekst.", "En deze tekst", # Commentaar binnen een commando
    "En deze tekst")   


# Regels laten inspringen als ze vervolg functie vorige regel zijn
# Zie hierboven


# Maak commando's niet te ingewikkeld. Leesbaarheid gaat voor efficiëntie
summary(m <- lm(log(mpg) ~ scale((wt * 454/500), scale = F) + as.factor(cyl), 
        data = d[d$am == 0,]))


# haal dingen weg die fout waren of die je niet meer gebruikt
# alternatief: maak een sectie "klad" of "oud" aan het einde



