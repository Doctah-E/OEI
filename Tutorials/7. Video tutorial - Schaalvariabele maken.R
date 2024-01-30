# Video tutorial: een schaalvariabele maken


# een schone start
rm(list=ls())
graphics.off()

# packages
library(haven)
library(dplyr)
library(summarytools)
library(forcats)
library(gmodels)

# Data: GSS wave 2018
setwd("C:/Users/ejvan/OneDrive - Vrije Universiteit Amsterdam/Bachelor Sociologie/OEI_Github/No_sync")
# download.file("https://gss.norc.org/Documents/spss/2018_spss.zip", "2018_spss.zip", mode = "wb")
dta <- read_spss(unzip("2018_spss.zip", "GSS2018.sav"))




# Truc: variabelen aan vector toekennen

# Variabelen verkennen, eventueel spiegelen

# Correlaties bekijken


# Cronbach's alpha bekijken


# Kijk naar missings


# Gemiddelde uitrekenen




