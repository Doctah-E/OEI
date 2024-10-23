# Video tutorial: Mediatie-effecten - lm en sem in R

# Voorbeeld: 
# Mensen met een vaste relatie zijn tevredener over hun leven dan mensen 
# zonder vaste relatie. Komt dit doordat ze overall tevredener zijn met hun
# sociale activiteiten? 
# X = married; Y = life satisfaction
# M = satisfaction social activities

# niet overnemen; dit is alleen om wat plaatjes in te laden
library(jpeg)
img1 <- readJPEG("Med1.JPG"); grid::grid.raster(img1)
img2 <- readJPEG("Med2.JPG"); grid::grid.raster(img2)
img3 <- readJPEG("Med3.JPG"); grid::grid.raster(img3)
img4 <- readJPEG("Med4.JPG"); grid::grid.raster(img4)

# Ligt M in de causale volgorde tussen X en Y? 
# relatie -> tevredenheid sociale activiteit?
# tevredenheid sociale activiteit -> tevredenheid leven? 

# Let op: onderstaande toetsen zeggen niets over causale volgorde
# De causale volgorde is hier een aanname!

# een schone start
rm(list=ls())
graphics.off()

# packages
library(haven)
library(dplyr)
library(summarytools)
library(stargazer)
library(lavaan)
library(lavaanPlot)

# Data: GSS wave 2018 - zie tutorial 1 voor toelichting
setwd("C:/Users/ejvan/OneDrive - Vrije Universiteit Amsterdam/Bachelor Sociologie/OEI_Github/No_sync")
# setwd("C:/Users/ein900/OneDrive - Vrije Universiteit Amsterdam/Bachelor Sociologie/OEI_Github/No_sync")
# download.file("https://gss.norc.org/Documents/spss/2018_spss.zip", "2018_spss.zip", mode = "wb")
dta <- read_spss(unzip("2018_spss.zip", "GSS2018.sav"))

# ---------------------DATA BEWERKING ------------------------------------------

# levenstevredenheid
attributes(dta$SATLIFE)[["labels"]]
dta$tevr <- 8 - dta$SATLIFE

# marital status - voor nu focus op vaste relatie versus geen vaste relatie
freq(dta$MARITAL)
attributes(dta$MARITAL)[["labels"]]
dta <- dta %>% mutate(mar = case_match(MARITAL, 1 ~ 1, 5 ~ 0, 2:4 ~ NA))
freq(dta$mar)

# satisfaction social relationships
freq(dta$SATSOC)
attributes(dta$SATSOC)
dta$sf_soc_act <- 6 - dta$SATSOC



# -------------------------- ANALYSES -----------------------------------------

# in regressieanalyse met lm(): schatting c, c', b 
M1 <- lm(tevr ~ mar, data = dta)
summary(M1)     # totaal effect c / samenhang
M2 <- lm(tevr ~ mar + sf_soc_act, data = dta)
summary(M2)
# en je kunt a*b uitrekenen door het verschil te nemen tussen c en c'
M1$coefficients[[2]]
M2$coefficients[[2]]
M1$coefficients[[2]] - M2$coefficients[[2]]
# welke deel is verklaard door de mediator? 
# verschil als proportie van het oorspronkelijke effect:
(M1$coefficients[[2]] - M2$coefficients[[2]]) / M1$coefficients[[2]]

# oftewel: zelfde aanpak als bij storende variabele, maar de interpretatie
# is anders doordat we een andere causale volgorde veronderstellen

# voornaamste tekortkoming: geen toets op significantie a*b
# zelfde kan ook in padmodel, met sem() functie van het pakket lavaan

# hoe maak je M2 met sem()?
M3_spec <- 'tevr ~ mar + sf_soc_act'
M3_sch <- sem(M3_spec, data = dta, meanstructure = T)
summary(M3_sch)
lavaanPlot(model = M3_sch, coefs = T, 
           graph_options = list(rankdir = "LR")) # argumenten moeten expliciet

# en nu met pad A er ook in:
M4_spec <- 'tevr ~ mar + sf_soc_act
            sf_soc_act ~ mar'
M4_sch <- sem(M4_spec, data = dta, meanstructure = T)
summary(M4_sch)
lavaanPlot(model = M4_sch, coefs = T, 
           graph_options = list(rankdir = "LR"))

# en nu met expliciete toetsing van het indirecte en totale effect
# dan moet je de coefficienten namen geven 
# en opgeven welke combinaties getoetst moeten worden
M5_spec <- 'tevr ~ c_acc*mar + b*sf_soc_act
            sf_soc_act ~ a*mar
            ab := a*b
            c := c_acc + a*b'
M5_sch <- sem(M5_spec, data = dta, meanstructure = T)
summary(M5_sch)
lavaanPlot(model = M5_sch, coefs = T, 
           graph_options = list(rankdir = "LR"))

