# Video tutorial: Regressieanalyse, basics

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


# -------------------------- data bewerking  -----------------------------------

freq(dta$SATLIFE)
attributes(dta$SATLIFE)
?case_match
dta$life_sat <- case_match(dta$SATLIFE, 1 ~ 7, 2 ~ 6, 3 ~ 5, 4 ~ 4, 5 ~ 3, 
                           6 ~ 2, 7 ~ 1)
freq(dta$life_sat)


# -------------------------- leeg model ----------------------------------------



