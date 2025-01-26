# Tutorial van SPSS naar R Studio: 1. "filosofie" van R


# Veronderstelling: ervaring met werken met SPSS syntax
# d.w.z. data transformaties, visualisaties, analyses

# Veronderstelling: R en R Studio geïnstalleerd
# [link installeren R & RStudio]


# -----------------------------------------------------------------------------

# R ziet er wit uit default ipv zwart
# Je hebt alles in één scherm ipv data, syntax, output

# Openen syntax file (script, code). Extensie .R
# Taal is totaal verschillend
# Syntax = script, code; Data = data frame; Commands = functions;  

# Het symbool voor commentaar is de hashtag ipv asterisk (*)
# Regels eindigen niet met een punt
# Je runt code met ctrl + enter

# Interface
# Files e.a.
# Console: lijkt op output venster SPSS maar ook direct "commando's" intypen


# -----------------------------------------------------------------------------

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
install.packages("haven")
library(haven)

# Tidyverse: packages met gedeelde aanpak/ logica


# ------------ Maak SPSS bestand / geen onderdeel tutorial --------------------

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

# [link data bekijken]


# -----------------------------------------------------------------------------

# # objecten hebben attributes ($)
# als je variabelen wilt bewerken geef je in base R altijd het data object op
attributes(dta$A)
# functies zijn vaak zowel om uit te lezen als om toe te schrijven
attributes(dta$A)$onzin <- TRUE
attributes(dta$A)


# -----------------------------------------------------------------------------

# Ingebouwde hulp
?read_sav()

# [link gebruiken help in R]


# -----------------------------------------------------------------------------

# Bij afsluiten: Opslaan RData file?
# .R en .RData files






