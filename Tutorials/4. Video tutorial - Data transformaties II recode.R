# Video tutorial: data transformaties II recode

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


# --------------- soms zijn lineaire transformaties het snelst -----------------

# vorige tutorial:
# dta$gelukkig <- 4 - dta$gelukkig


# ------------------- recode set waardes naar andere set ----------------------

# dplyr: case_match()





# ------------------------- recode met voorwaarden -----------------------------

# dplyr: case_when()


# ------------------------- factor variables -----------------------------------

# forcats: fct_recode()




