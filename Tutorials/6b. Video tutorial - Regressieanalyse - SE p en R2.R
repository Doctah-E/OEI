# Video tutorial: Regressieanalyse, basics

# Uitvoeren in R, interpretatie uitkomsten, niet schatting van model

# Model met één continue afhankelijke variabele
# Model categorische afh variabele: tutorial regressieanalyse dummy variabelen

# Deel A: model maken en interpreteren (intercept en regressiecoëfficiënt)
# Deel B: SE, p en R2 interpreteren

# een schone start
rm(list=ls())
graphics.off()

# packages
library(summarytools)

# obv fictieve data


# -------------- DATA SIMULATIE - NIET OVERNEMEN -----------------------------

# Onderzoek onder studenten
# Hoeveel is de gemiddelde tijd besteed aan studie per week (T)? 
# En voorspelt dit het gemiddelde cijfer C?
set.seed(123)
T <- rnorm(100, mean = 32, sd = 10)
C <- 1 + 0.12 * T + rnorm(100, 0, 2)
descr(C)

# ------------ wat betekent de standard error? ---------------------------------

# simpelste model: schat C
M1 <- lm(C ~ 1)
summary(M1)
options(scipen = 999)
summary(M1)

# is duidelijk ongelijk aan de std deviatie (2.17 versus .22)
# std is gemiddelde afstand tot gemiddelde IN DE HUIDIGE STEEKPROEF
hist(C, breaks = 20)
abline(v = 4.73, col = "green", lwd = 3)
sd(T) # kwadrateer alle afstanden en tel ze op, deel door n en neem wortel uit

# maar T is geschat obv een steekproef en elke keer iets anders
abline(v = 3.7, col = "green", lwd = 3)
abline(v = 4.2, col = "green", lwd = 3)
abline(v = 5.3, col = "green", lwd = 3)
abline(v = 5.8, col = "green", lwd = 3)
# SE is een speciaal soort std! --> van een schatter (estimate)
# in dit geval van het gemiddelde dat we geschat hebben
# gemiddelde afstand tot het gemiddelde van de gemiddeldes

# obv stat theorie kun je SE met formule uitrekenen
# hier eenvoudig: SE = sd(C) / sqrt(n)

# belangrijkste factor die SE bepaalt is de steekproefgrootte n
# intuïtief: kans op uitschieter steeds kleiner

# SE zegt dus iets over precisie (of betrouwbaarheid) van de schatting!

# Voor een uitgebreidere uitleg (Josh Starmer):
# https://www.youtube.com/watch?v=XNgt7F6FqDU&t=240s 
# (de bootstrap methode gebruiken we hier niet)


# ------------- Wat is de relatie met significantie? ---------------------------

# Hoe ziet de verdeling van de schatter er dan uit?

# Als estimate normaal verdeeld is ligt 95% van de verdeling tussen -/+ 2SD (1.96)
curve(dnorm(x, mean = 4.73, sd = 0.22), from = 4, to = 5.5)
abline(v = 4.73 - 2 * 0.22, col = "green")
abline(v = 4.73 + 2 * 0.22, col = "green")
# We kunnen met 95% zekerheid zeggen dat gemiddelde tevredenheid tussen 4.29 en
# 5.17 ligt. = betrouwbaarheidsinterval

# We kunnen met nog veel grotere zekerheid zeggen dat onze schatter niet nul is
# --> bekijk je met significantie

# Hoe zit het dan met p waardes? 
# Nul hypothese:
# stel gem. cijfer is in werkelijkheid nul: wat is dan de kans op resultaat
# van 4.73 in een steekproef?
curve(dnorm(x, mean = 0, sd = 0.22), from = -2, to = 2)
# kan waarde hier niet eens intekenen zover naar rechts

# p geeft aan welke proportie van waardes in verdeling nog buiten de gevonden
# waarde zit (overschrijdingskans)
# als dat minder dan .05 is (5%) spreken we van een significant resultaat 
# dan verwerpen we de hypothese dat de schatter 0 is

# en ook een regr coefficient (RC) is geschat obv een steekproef
# dus ook standard error en significantie
M2 <- lm(C ~ T)
summary(M2)
# waarbij SE iets zegt over precisie vd schatting van de RC en p iets over 
# hoe waarschijnlijk het is dat de RC niet nul is in werkelijkheid


# ------ Laatste punt van aandacht: R-square oftewel verklaarde variantie ----

# Dit is het deel van de variantie (in Y) dat wordt verklaard door het model
# Daarvoor moet je het vergelijken met het model met alleen het gemiddelde

# Fictieve data: verklaart tijd besteed aan studie het gemiddelde cijfer?
plot(T, C)
# reken totale variatie uit door alle (verticale) afstanden tot gemiddelde 
# te kwadrateren en op te tellen
abline(h = mean(C), lty = 4)
# kijk naar (verticale) afstanden tot voorspellingen (lijn) van model
abline(lm(C ~ T))
# R-kwadr is de proportie waarmee variantie is afgenomen
# Var(mean) - Var(line) / Var(mean)
# Oftewel de proportie verklaarde variantie!


# Uitgebreidere uitleg verklaarde variantie (Josh Starmer): 
# https://www.youtube.com/watch?v=bMccdk8EdGo





