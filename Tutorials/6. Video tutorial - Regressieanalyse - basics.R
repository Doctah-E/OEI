# Video tutorial: Regressieanalyse, basics

# Model met één continue afhankelijke variabele
# Model met categorische afhankelijke variabele 
# -> Tutorial regressieanalyse dummy variabelen

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

# Meest simpele model: voorspel tevredenheid zonder verdere data
# Model met alleen een intercept
M1 <- lm(tevr ~ 1, data = dta)
summary(M1)
# regressievergelijking: Y = 5.25       # eigenlijk Y-dakje en Y ~ 5.25
descr(dta$tevr)

# wat betekent de rest? standard error
# is duidelijk ongelijk aan de std deviatie (0.09 versus 1.10)
# std is gemiddelde afstand tot gemiddelde IN DE HUIDIGE STEEKPROEF

# Voorbeeld fictieve data (alleen ter illustratie!)
# Gemiddelde tijd besteed aan studie per week (T)? 
set.seed(123)
T <- rnorm(500, mean = 32, sd = 10)
summary(lm(T ~ 1))
hist(T, breaks = 100)
abline(v = 32, col = "green", lwd = 3)
sd(T)
# maar T is geschat obv een steekproef en elke keer iets anders
abline(v = 37, col = "green", lwd = 3)
abline(v = 24, col = "green", lwd = 3)
# SE is een speciaal soort std! --> van een schatter (estimate)
# in dit geval van het gemiddelde dat we geschat hebben
# SE zegt dus iets over precisie van de schatting!

# belangrijkste factor die SE bepaalt is de steekproefgrootte n
# intuïtief: kans op spreiding steeds groter
# obv stat theorie kun je SE met formule uitrekenen
# hier eenvoudig: SE = sd(T) / sqrt(n)
sd(T) / sqrt(500)

# Voor een langere en duidelijkere uitleg:
# https://www.youtube.com/watch?v=XNgt7F6FqDU&t=240s 
# (de bootstrap methode gebruiken we hier niet)

# Wat is de relatie met significantie? 
# Hoe ziet de verdeling van de schatter er dan uit?
# Terug naar GSS data
M1 <- lm(tevr ~ 1, data = dta)
summary(M1)
# Als estimate normaal verdeeld is ligt 95% van de verdeling tussen -/+ 2SD (1.96)
curve(dnorm(x, mean = 5.49, sd = 0.03), from = 5.3, to = 5.7)
abline(v = 5.49 - 2 * 0.03, col = "green")
abline(v = 5.49 + 2 * 0.03, col = "green")
# We kunnen met 95% zekerheid zeggen dat gemiddelde tevredenheid tussen 5.43 en
# 5.55 ligt. 
# We kunnen met nog veel grotere zekerheid zeggen dat onze schatter niet nul is
# --> bekijk je met significantie

# Hoe zit het dan met p waardes? 
# stel gem. tevredenheid is werkelijkheid nul: wat is dan de kans op resultaat
# van 5.49 in een steekproef?
curve(dnorm(x, mean = 0, sd = 0.03), from = -5.5, to = 5.5)
abline(v = 5.49, col = "green")
options(scipen = 999)
summary(M1)
# p geeft aan welke proportie van waardes in verdeling nog buiten de gevonden
# waarde zit
# als dat minder dan .05 is (5%) spreken we van een significant resultaat 
# dan verwerpen we de hypothese dat de schatter 0 is


# ----------------- beter model: voeg leeftijd toe -----------------------------

M2 <- lm(tevr ~ age_c, data = dta)
summary(M2)
Regressievergelijking: Y = 5.494 + .005 * leeftijd

# wat geeft reg coeff aan? 
# geschatte waarde van tevredenheid bij 1 jaar verschil in leeftijd
plot(dta$age_c, dta$tevr)
abline(lm(tevr ~ age_c, data = dta))

# wat geeft het intercept aan? 
# kijk naar situatie waar alle regressiecoefficienten nul zijn
Regressievergelijking: Y = 5.494 + .005 * 0
                        Y = 5.494
# voorspelde tevredenheid bij gemiddelde leeftijd
descr(dta$AGE)

# en ook een regr coefficient (RC) is geschat obv een steekproef
# dus ook standard error en significantie
# waarbij SE iets zegt over precisie vd schatting van de RC
# en p iets over hoe waarschijnlijk het is dat de RC niet nul is in werkelijkheid

# Laatste punt van aandacht: R-square oftewel verklaarde variantie
# hier heel klein 0.6 % 
# Dit gaat over het deel van de variantie (in Y) dat wordt verklaard door het model
# Daarvoor moet je het vergelijken met het simpele model met alleen het gemiddelde

# Fictieve data: verklaart tijd besteed aan studie het gemiddelde cijfer?
set.seed(123)
T <- rnorm(50, mean = 32, sd = 10)
C <- 1 + 0.1 * T + rnorm(50, 0, 2)
plot(T, C)
# reken totale variatie uit door alle (verticle) afstanden tot gemiddelde 
# te kwadrateren en op te tellen
abline(h = mean(C), lty = 4)
# kijk naar (verticale) afstanden tot voorspellingen (lijn) van model
abline(lm(C ~ T))
# R-kwadr is de proportie waarmee variantie is afgenomen
# Var(mean) - Var(line) / Var(mean)
# Oftewel de proportie verklaarde variantie!


# Uitgebreidere uitleg verklaarde variantie: 
# https://www.youtube.com/watch?v=bMccdk8EdGo





