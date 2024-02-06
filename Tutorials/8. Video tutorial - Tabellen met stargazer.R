# Video tutorial: tabellen met stargazer

# een schone start
rm(list=ls())
graphics.off()

# packages
library(haven)
library(dplyr)
library(summarytools)
library(stargazer)

# Data: GSS wave 2018
setwd("C:/Users/ejvan/OneDrive - Vrije Universiteit Amsterdam/Bachelor Sociologie/OEI_Github/No_sync")
# download.file("https://gss.norc.org/Documents/spss/2018_spss.zip", "2018_spss.zip", mode = "wb")
dta <- read_spss(unzip("2018_spss.zip", "GSS2018.sav"))

# ------------------------------DATABEWERKING -----------------------------------

# levenstevredenheid
dta$tevr <- 8 - dta$SATLIFE
descr(dta$tevr)

# onafhankelijke variabelen
freq(dta$AGE)  # continu

freq(dta$HEALTH)
attributes(dta$HEALTH)
dta$hlth <- 5 - dta$HEALTH

freq(dta$CLASS)
attributes(dta$CLASS)  

freq(dta$BORN)
dta$born <- dta$BORN - 1

freq(dta$ATTEND)
attributes(dta$ATTEND)


# ---------------------------- Descriptives ------------------------------------

# Stargazer kan geen tibble aan
# En wil als input een data frame
# Dit werkt niet:
stargazer(dta[c("tevr", "AGE", "HEALTH", "CLASS", "born", "ATTEND")], 
          type = "html", out = "Descriptives.html")

tmp <- as.data.frame(dta[c("tevr", "AGE", "HEALTH", "CLASS", "born", "ATTEND")])
class(tmp)
stargazer(tmp, type = "html", out = "Descriptives.html")
?stargazer

stargazer(tmp, type = "html", out = "Descriptives.html", digits = 2,
          title = "Beschrijvende statistieken")

stargazer(tmp, type = "html", out = "Descriptives.html", digits = 2,
          title = "Beschrijvende statistieken",
          covariate.labels = c("Tevredenheid", "Leeftijd", "Gezondheid",
                               "Sociale klasse", "Geboren US", "Kerkgang"))



# ------------------------- Regressietabellen ----------------------------------

# twee verschillende voorspellend modellen
M1 <- lm(tevr ~ hlth + ATTEND, data = dta)
summary(M1)
M2 <- lm(tevr ~ hlth + ATTEND + AGE + CLASS + born, data = dta)
summary(M2)

# de basis
stargazer(M1, M2, type = "html", out = "Reg.html")

# bovenkant gestript
stargazer(M1, M2, type = "html", out = "Reg.html",
          dep.var.caption = "", dep.var.labels.include = F,
          title = paste("Regressieanalyse van levenstevredenheid",
                        "(ongestandaardiseerde coefficiënten en standaardfouten)"))

# alleen belangrijkste statistieken
stargazer(M1, M2, type = "html", out = "Reg.html",
          dep.var.caption = "", dep.var.labels.include = F,
          title = paste("Regressieanalyse van levenstevredenheid",
                        "(ongestandaardiseerde coefficiënten en standaardfouten)"),
          omit.stat = c("f", "rsq", "ll", "ser"))

# variabelennamen aanpassen
stargazer(M1, M2, type = "html", out = "Reg.html",
          dep.var.caption = "", dep.var.labels.include = F,
          title = paste("Regressieanalyse van levenstevredenheid",
                        "(ongestandaardiseerde coefficiënten en standaardfouten)"),
          omit.stat = c("f", "rsq", "ll", "ser"),
          covariate.labels = c("Gezondheid", "Kerkgang", "Leeftijd",
                                 "Sociale klasse", "Geboren US", "Intercept"))






