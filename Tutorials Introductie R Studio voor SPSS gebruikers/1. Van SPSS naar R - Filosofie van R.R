# Tutorial van SPSS naar R Studio: 1. "filosofie" van R


# Veronderstelling: ervaring met werken met SPSS syntax
# d.w.z. data transformaties, analyses

# Veronderstelling: R en R Studio geïnstalleerd

# Hulp bij installatie?
# Link geschreven tutorial Mauricio Garnier Villareal op Canvas:
# https://canvas.vu.nl/courses/59293/modules
# Link Github Mauricio:
# https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/0_2_Installing_windows.md


# -----------------------------------------------------------------------------

# R ziet er wit uit default ipv zwart
# Je hebt alles in één scherm ipv data, syntax, output

# Openen syntax file (script, code). Extensie .R

# Taal is totaal verschillend
# Syntax = script, code; Data = data frame; Commands = functions; . = NA  

# Het symbool voor commentaar is de hashtag ipv asterisk (*)
# Regels eindigen niet met een punt
# Je runt code met ctrl + enter

# Interface
# Files e.a.
# Console: lijkt op output venster SPSS maar ook direct "commando's" intypen


# ---------------------------------------------------------------------------

# Andere filosofie R: "er zijn alleen objecten en functies"
# Je kunt een object aanmaken door er iets aan toe te wijzen: <-
x <- 5
x
x <- x + 1
x

# Environment: alle objecten in geheugen computer
# Vaak van allerlei data door elkaar open
rm(x)       

# Functie: voert iets uit tav een object en heeft argumenten


# -----------------------------------------------------------------------------

# Data open en aan object koppelen (ipv get file)
# Packages. Installeren, openen
# Haven
# install.packages("haven")
library(haven)

# Tidyverse: packages met gedeelde aanpak/ logica


# ------------ Maak SPSS bestand / geen onderdeel tutorial --------------------

set.seed(1234)
tmp <- data.frame(A= sample(c(0:10), 10, replace = T),
                  B= sample(c(0:10), 10, replace = T),
                  C= sample(c(0:10), 10, replace = T))
attributes(tmp$A)$label <- "Een variabele" 
attributes(tmp$B)$label <- "Variabele twee" 
attributes(tmp$C)$label <- "Variabele drie" 
getwd()
write_sav(tmp, "tmp.sav")
dir()
rm(tmp)


# -----------------------------------------------------------------------------

dta <- read_sav("tmp.sav")
    
# Niet echt data view, maar kunt data wel openen
View(dta)   # "case sensitive"

# Meestal geen variable labels. 
# Ook niet echt variable view, maar kun je uitdraaien (of klikken environment)
str(dta)


# Uitgebreidere uitleg data verkennen:
# https://youtu.be/i-cogQfBPEw?si=MuYYkGBVHLLSqtYG
# https://github.com/ejvingen/R-tutorials/blob/main/Tutorials%20OEI/2.%20Video%20tutorial%20-%20Verkennen%20van%20data.R


# -----------------------------------------------------------------------------

# objecten hebben attributes ($)
# als je variabelen wilt bewerken geef je in base R altijd het data object op
attributes(dta$A)
# functies zijn vaak zowel om uit te lezen als om toe te schrijven
attributes(dta$A)$onzin <- TRUE
attributes(dta$A)


# -----------------------------------------------------------------------------

# Ingebouwde hulp
?read_sav()


# Meer uitleg gebruiken ingebouwde hulp in R:
# https://youtu.be/PHcyNNOqIKY?si=2zqOUiq9ONO-dFAJ
# https://github.com/ejvingen/R-tutorials/blob/main/Tutorials%20NSMA/0.%20Tutorial%20-%20Het%20gebruiken%20van%20ingebouwde%20hulp%20in%20R.R


# -----------------------------------------------------------------------------

# Bij afsluiten: Opslaan RData file?
# .R en .RData files






