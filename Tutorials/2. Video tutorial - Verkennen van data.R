# Video tutorial: Het verkennen van data 

# een schone start
rm(list=ls())
graphics.off()

# packages
library(haven)
library(dplyr)
library(summarytools)
library(psych)
library(gmodels)

# Data: GSS wave 2018
setwd("C:/Users/ejvan/OneDrive - Vrije Universiteit Amsterdam/Bachelor Sociologie/OEI_Github/tutorials")
# download.file("https://gss.norc.org/Documents/spss/2018_spss.zip", "2018_spss.zip", mode = "wb")
dta <- read_spss(unzip("2018_spss.zip", "GSS2018.sav"))


# -------------------- Door data heen "bladeren"-------------------------------

# click op data object in Environment
# haven neemt de labels van variabelen over 
View(dta)
attributes(dta$ABANY)
attributes(dta$ABANY)[["label"]]
lapply(dta, function(x) attributes(x)[["label"]])
tmp <- lapply(dta, function(x) attributes(x)[["label"]])

names(dta)          # zelfde als colnames()

head(dta)
# verassing: haven heeft ons data frame naar een tibble omgezet
# oftewel as_tibble() toegepast
class(dta)
dta
# als je terug wilt: dta <- as.data.frame(dta)

str(dta)        # beetje chaotisch maar wel veel info


# -------------------- Bekijken van bepaalde variabelen ------------------------

# Bijvoorbeeld life satisfaction
str(dta$SATLIFE)
attributes(dta$SATLIFE)
attributes(dta$SATLIFE)[["labels"]]         # recode nodig
summary(dta$SATLIFE)

freq(dta$SATLIFE)       # package summarytools
descr(dta$SATLIFE)

# plots
hist(dta$SATLIFE)

# range van variabelen
# truc: sla namen variabelen op in vector
v <- c("CONARMY", "CONBIZ", "CONBUS", "CONCHURH", "CONCLERG")
v
str(dta[v])
descr(dta[v])   # Stargazer ziet er beter uit

# het volgende werkt helaas niet:
# freq(dta[v])
# dit wel:
lapply(dta[v], freq)



# ---------------- Bekijken samenhang bepaalde variabelen ----------------------

corr.test(dta[v])    # package psych
psych::alpha(dta[v]) # expliciet package want functie vaker gebruikt

plot(dta$AGE, dta$SATLIFE)
abline(lm(SATLIFE ~ AGE, data= dta))

CrossTable(dta$MARITAL, dta$HLTHMNTL)    # package gmodels
# moet nog eea gebeuren: omzetten naar factor variables met labels
# minder info in cellen, bijv. alleen rijpercentages
# zie help
?CrossTable









