# Video tutorial: Regressieanalyse, basics

# Uitvoeren in R, interpretatie uitkomsten, niet schatting van model

# Model met één continue onafhankelijke variabele
# Model categorische onafh variabele: tutorial regressieanalyse dummy variabelen

# Deel A: model maken en interpreteren (intercept en regressiecoëfficiënt)
# Deel B: SE, p en R2 interpreteren

# een schone start
rm(list=ls())
graphics.off()

# packages
library(haven)
library(dplyr)
library(summarytools)
library(psych)

# Data: GSS wave 2018
setwd("C:/Users/ejvan/OneDrive - Vrije Universiteit Amsterdam/Bachelor Sociologie/OEI_Github/No_sync")
# download.file("https://gss.norc.org/Documents/spss/2018_spss.zip", "2018_spss.zip", mode = "wb")
dta <- read_spss(unzip("2018_spss.zip", "GSS2018.sav"))


# Hypothese: Hoe ouder mensen zijn, hoe lager de tevredenheid met hun leven
# nul-hypothese: er is geen verband tussen leeftijd en tevredenheid


# -------------------------- data bewerking  -----------------------------------

# levenstevredenheid
freq(dta$SATLIFE)       # gevraagd in split sample
attributes(dta$SATLIFE)
dta$tevr <- 8 - dta$SATLIFE
corr.test(dta$tevr, dta$SATLIFE)
hist(dta$tevr)          # vatten we hier op als continue variabelen
descr(dta$tevr)

# leeftijd
freq(dta$AGE)  # continu
# gecentreerd tbv voorbeeld
dta$age_c <- scale(dta$AGE, center = T, scale = F)
descr(dta$age_c)


# -------------------------- leeg model ----------------------------------------

# Regressieanalyse: voorspel Y op basis van een model

# Meest simpele model: voorspel tevredenheid zonder onafhankelijke variabelen
# Model met alleen een intercept
M1 <- lm(tevr ~ 1, data = dta)
summary(M1)
# regressievergelijking: Y = a + b1X1 + b2X2 etc.
# regressievergelijking: Y = 5.49       # eigenlijk Y-dakje en Y ~ 5.49
descr(dta$tevr)


# ----------------- beter model: voeg leeftijd toe -----------------------------

M2 <- lm(tevr ~ age_c, data = dta)
summary(M2)
# Regressievergelijking: Y = 5.494 + .005 * leeftijd

# wat geeft reg coeff aan? 
# geschatte waarde van tevredenheid bij 1 jaar verschil in leeftijd
plot(dta$age_c, dta$tevr)
abline(lm(tevr ~ age_c, data = dta))
tmp <- dta %>% group_by(age_c) %>% summarise(m_tevr = mean(tevr, na.rm = T))
tmp
plot(tmp[[1]], tmp[[2]])

# wat geeft het intercept aan? 
# kijk naar situatie waar alle regressiecoefficienten nul zijn
# Regressievergelijking: Y = 5.494 + .005 * 0
#                        Y = 5.494
# voorspelde tevredenheid bij gemiddelde leeftijd
descr(dta$AGE)

# Hypothese?
# p < .05 en we moeten deze nog halveren, want onze hypothese was eenzijdig
# R geeft in output tweezijdige toetsing
# We kunnen nul hypothese (geen verband) verwerpen
# Echter: klein effect
# Ook te zien aan verkaarde variantie R^2




