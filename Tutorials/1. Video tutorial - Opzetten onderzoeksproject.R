# Video tutorial: Opzetten van een onderzoeksproject


# .R script file, geen R markdown
# - liever eerste want overzichtelijker tov R markdown voor knitten en
#   elke keer nitten is omslachtig
# - onhandig R code in verschillende blokken
# - text editor wat beter bij .R ipv .Rmd

# Start: Bewaar alles op één plek in een nieuwe map en maak nieuw R project aan

# -----------------------------------------------------------------------------'

# Toelichting doel script

# een schone start
graphics.off()
rm(list=ls())

# packages
library(haven)

# Data: GSS wave 2018
# Maak project / working directory
# Download SPSS file, sla hem op in je working directory

setwd("C:/Users/ejvan/OneDrive - Vrije Universiteit Amsterdam/Bachelor Sociologie/OEI_Github/tutorials")
getwd()

download.file("https://gss.norc.org/Documents/spss/2018_spss.zip", "2018_spss.zip", mode = "wb")
dir()
dta <- read_spss(unzip("2018_spss.zip", "GSS2018.sav"))

# codebook: https://gss.norc.org/Documents/codebook/gss_codebook.zip 
# data explorer: https://gssdataexplorer.norc.org/pages/show?page=gss%2Fhelp_variables
# filter 2018



# Verschillende blokken van onderzoeksvraag naar rapportage
# - Exploratieve data analyse/ verkennen van data (tutorial)
# - Data transformaties, met name recode (tutorial)
# - Definitieve data analyse (tutorials regressie)
# - Rapportage (tutorial Stargazer)


# Do's and don'ts
# - Overschrijf nooit de originele data
# - Controleer alles wat je doet
# - Maak je script reproduceerbaar! Principe van open science. Dus heel goed 
#   documenteren!
# - Save niet de workspace image in de Rdata file als je afsluit
# - Meer in aparte tutorial over werken met syntax (script)

# Scripts van tutorials op Github
# Kijk tutorials actief en experimenteer
# Tutorials zijn aanvulling op geschreven tutorials op Canvas R for social scientists





