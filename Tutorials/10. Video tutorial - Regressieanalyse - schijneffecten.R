# Video tutorial: Regressieanalyse - schijneffecten

# Voorbeeld: maakt geld gelukkig? of is dat een schijneffect? 
# X = inkomen; Y = tevredenheid
# Z = werkloosheid (of meer algemeen: werkstatus)

# Kan werkeloos een storende variabele zijn? 
# werkloos -> inkomen
# werkloos -> tevredenheid

# niet overnemen; dit is alleen om wat plaatjes in te laden
library(jpeg)
img1 <- readJPEG("Dia1.JPG"); grid::grid.raster(img1)
img2 <- readJPEG("Dia2.JPG"); grid::grid.raster(img2)
img3 <- readJPEG("Dia3.JPG"); grid::grid.raster(img3)
img4 <- readJPEG("Dia4.JPG"); grid::grid.raster(img4)

# Let op dat Z niet een mediator is
# Is X -> Z aannemelijk? 
# Dan is de interpretatie anders (volgende tutorial)


# een schone start
rm(list=ls())
graphics.off()

# packages
library(haven)
library(dplyr)
library(summarytools)
library(stargazer)

# Data: GSS wave 2018 - zie tutorial 1 voor toelichting
setwd("C:/Users/ejvan/OneDrive - Vrije Universiteit Amsterdam/Bachelor Sociologie/OEI_Github/No_sync")
# download.file("https://gss.norc.org/Documents/spss/2018_spss.zip", "2018_spss.zip", mode = "wb")
dta <- read_spss(unzip("2018_spss.zip", "GSS2018.sav"))

# ---------------------DATA BEWERKING ------------------------------------------

# levenstevredenheid
attributes(dta$SATLIFE)[["labels"]]
dta$tevr <- 8 - dta$SATLIFE

# income
str(dta$REALINC)
sum(is.na(dta$REALINC))
descr(dta$REALINC)
# delen door 10000
dta$inkomen <- dta$REALINC / 20000

# werkloos
attributes(dta$WRKSTAT)
freq(dta$WRKSTAT)
# simpeler: wel/ niet werken
dta$werkloos <- case_match(dta$WRKSTAT, 1:2 ~ 0, 3:4 ~ 1, .default = NA)
freq(dta$werkloos)
dta2 <- dta[!is.na(dta$werkloos),]


# ------------------------- ANALYSES -------------------------------------------

# Checken op schijneffecten:
# Vergelijk model zonder en met storende variabele(n)

# Model X -> Y
M1 <- lm(tevr ~ inkomen, data = dta2)
summary(M1)
# Model X -> Y gecontroleerd voor Z
M2 <- lm(tevr ~ inkomen + werkloos, data = dta2)
summary(M2)
# wat fijnere output
stargazer(M1, M2, type = "html", out = "Reg.html")

# welk gedeelte was schijneffect? 
# verschil in effecten:
M1$coefficients[[2]]
M2$coefficients[[2]]
# verschil nemen en uitdrukken als proportie van oorspronkelijke effect:
(M1$coefficients[[2]] - M2$coefficients[[2]]) / M1$coefficients[[2]]
# 6 % van effect was schijneffect door achterwege laten werkloosheid

# of controleren voor alle verschillen in werk status
M3 <- lm(tevr ~ inkomen + as.factor(dta$WRKSTAT), data = dta)
summary(M3)         # deels onderdrukt!
# je weet alleen niet goed waardoor





