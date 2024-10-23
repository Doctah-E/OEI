# Video tutorial: Regressieanalyse en effect size

# Eerder: effecten schatten en significantie
# Nu: hoe groot is het effect? Is het betekenisvol? 

# Voorbeeld: effecten van 1) diagnose mentaal gezondheidsprobleem en 
# 2) leeftijd op levenstevredenheid

# een schone start
rm(list=ls())
graphics.off()

# packages
library(haven)
library(dplyr)
library(summarytools)

# Data: GSS wave 2018 - zie tutorial 1 voor toelichting
setwd("C:/Users/ejvan/OneDrive - Vrije Universiteit Amsterdam/Bachelor Sociologie/OEI_Github/No_sync")
# download.file("https://gss.norc.org/Documents/spss/2018_spss.zip", "2018_spss.zip", mode = "wb")
dta <- read_spss(unzip("2018_spss.zip", "GSS2018.sav"))

# ------------------------------------------------------------------------------

# levenstevredenheid
attributes(dta$SATLIFE)[["labels"]]
dta$tevr <- 8 - dta$SATLIFE
descr(dta$tevr)

# dichotome variabele: diagnosed with mental health problem
# had ook kunnen zijn: verschil mannen-vrouwen, treatment versus controlegroep 
freq(dta$DIAGNOSD)
attributes(dta$DIAGNOSD)[["labels"]]
dta$mhlth <- case_match(dta$DIAGNOSD, 2 ~ 0, 1 ~ 1)
freq(dta$mhlth)

# continue variabele: leeftijd
freq(dta$AGE)  # continu


# ------------------------------------------------------------------------------

# regressie tevredenheid op mentale gezondheidsprobleem
M <- lm(tevr ~ mhlth, dta)
summary(M)

# is dit een groot verschil? 
descr(dta$tevr)
hist(dta$tevr)
# gestandaardiseerd verschil in gemiddeldes; Cohen's D
M$coefficients
M$coefficients[[2]]
sd(dta$tevr, na.rm = T)
M$coefficients[[2]] / sd(dta$tevr, na.rm = T)

# Cohen's D: gestandaardiseerde verschillen in gemiddeldes
# 0.10 small
# 0.30 medium
# 0.50 large
# Echter: effect grootte is belangrijk, maar niet categorisch!

# liever een intuitieve benadering
# bijvoorbeeld wat is de verdeling van lichaamsgewicht in NL? 
# Link LISS panel:
# https://www.dataarchive.lissdata.nl/study-units/view/957
gew <- read_sav("qd19a_EN_1.0p.sav")
freq(gew$qd19a015)
hist(gew$qd19a015, breaks = 50)
descr(gew$qd19a015)
# 1 SD -> 16 kg
# 0.5 SD -> 8 kg
# 0.1 SD -> 1.6 kg
# 0.2 SD -> 3.2 kg

# continue variabele
# regressie tevredenheid op leeftijd
M <- lm(tevr ~ AGE, dta)
summary(M)

# is dit een groot verschil? 
# maximaal verschil
descr(dta$AGE)
max(dta$AGE, na.rm = T) - min(dta$AGE, na.rm = T)
M$coefficients[[2]] * (max(dta$AGE, na.rm = T) - min(dta$AGE, na.rm = T))
descr(dta$tevr)
# zowel x als y standaardiseren
M$coefficients[[2]]
# niet één jaar maar één SD verschil
M$coefficients[[2]] * sd(dta$AGE, na.rm = T)
# hoeveel is dat uitgedrukt in sd's tevredenheid? 
M$coefficients[[2]] * sd(dta$AGE, na.rm = T) / sd(dta$tevr, na.rm = T)

# Veel discussie over wat is groot/ midden/ klein

# "For a coefficient β, effect sizes between 0.10–0.29 are said to be only 
# small, effect sizes between 0.30–0.49 are medium, and effect sizes of 0.50 
# or greater are large [24,25]."
# Nieminen, P. (2022). Application of standardized regression coefficient 
# in meta-analysis. BioMedInformatics, 2(3), 434-458. 
# 
# "[...] individual differences researchers are recommended to consider 
# correlations of 0.10, 0.20, and 0.30 as relatively small, typical, and 
# relatively large"
# Gignac, G. E., & Szodorai, E. T. (2016). Effect size guidelines for individual 
# differences researchers. Personality and individual differences, 102, 74-78. 





