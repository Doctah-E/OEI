# Video tutorial: veelgebruikte data transformaties

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
setwd("C:/Users/ejvan/OneDrive - Vrije Universiteit Amsterdam/Bachelor Sociologie/OEI_Github/tutorials")
# download.file("https://gss.norc.org/Documents/spss/2018_spss.zip", "2018_spss.zip", mode = "wb")
dta <- read_spss(unzip("2018_spss.zip", "GSS2018.sav"))


# ---------------- bewerkingen op niveau dataset (dplyr) -----------------------

names(dta)

# variabelen andere positie geven
dta <- dta %>% relocate(HAPPY, SATLIFE)
?relocate

# andere naam
dta <- dta %>% rename(gelukkig = HAPPY, levenstevr = SATLIFE)


# ---------------- van type variabelen veranderen ------------------------------

CrossTable(dta$MARITAL, dta$HLTHMNTL)    # package gmodels
# moet nog eea gebeuren: omzetten naar factor variables met labels
freq(dta$MARITAL)
attributes(dta$MARITAL)
lb <- attributes(dta$MARITAL)[["labels"]]
lb
dta$mar_st <- factor(dta$MARITAL, levels = lb, labels = names(lb))
str(dta$mar_st)
freq(dta$mar_st)

# vervolgens heeft forcats veel mogelijkheden voor aanpassing factor variables
?forcats
?fct_drop
levels(dta$mar_st)
dta$mar_st <- fct_drop(dta$mar_st)
freq(dta$mar_st)

# zelfde bij mental health
freq(dta$HLTHMNTL)
lb <- attributes(dta$HLTHMNTL)[["labels"]]
dta$m_health <- factor(dta$HLTHMNTL, levels = lb, labels = names(lb))
freq(dta$m_health)
dta$m_health <- fct_drop(dta$m_health)
freq(dta$m_health)

# minder info in cellen, bijv. alleen rijpercentages
?CrossTable
CrossTable(dta$mar_st, dta$m_health, prop.c = F, prop.t = F, chisq = F, 
           prop.chisq = F)

# terug naar numeriek?
dta$mar_st2 <- as.numeric(dta$mar_st)
str(dta$mar_st2)

# of als puur tekst
dta$mar_st3 <- as.character(dta$mar_st)
str(dta$mar_st3)

# factor variabele van base veranderen
freq(dta$SATSOC)
attributes(dta$ATTEND)
summary(lm(dta$ATTEND ~ dta$mar_st))
dta$mar_st <- relevel(dta$mar_st, ref = "WIDOWED")
str(dta$mar_st)
summary(lm(dta$ATTEND ~ dta$mar_st))


# --------------- Rekenkundige transformaties ---------------------------------

freq(dta$gelukkig)
attributes(dta$gelukkig)
dta$gelukkig <- 4 - dta$gelukkig
freq(dta$gelukkig)

# ook icm functies
descr(dta$AGE)
dta$age_c <- dta$AGE - mean(dta$AGE, na.rm = T)     # kan ook met scale()
descr(dta$age_c)
dta$age_s <- scale(dta$AGE, center = T, scale = T)
descr(dta$age_s)

# aggreren per groep: 
freq(dta$mar_st)
descr(dta$gelukkig)
# plot maken?
tmp <- dta %>% group_by(dta$mar_st) %>% summarise(mean(gelukkig, na.rm = T))
tmp
names(tmp)
barplot(tmp[[2]], names = tmp[[1]])
# of groepsscore opslaan in originele data
dta <- dta %>% group_by(dta$mar_st) %>% 
    mutate(m_geluk_mst = mean(gelukkig, na.rm = T)) %>% ungroup()
freq(dta$m_geluk_mst)


# Recode (numeriek, character, factor)   --> volgende tutorial





