# Video tutorial: een schaalvariabele maken


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

# --------------------------- vooraf -------------------------------------------

# simpele schaal, één dimensie
# niet: opsporen verschillende dimensies, bijv. PCA 
# niet: toetsen meetmodel mbv latente variabele, bijv. CFA


# --------------- schaalvariabele voor houding wetenschap ---------------

# Truc: variabelen selecteren in object (df)
names(dta)
v <- dta[c("SCIENTBE", "SCIENTGO", "SCIENTHE", "SCIENTOD")]
# kan ook op allerlei andere manieren
v <- dta %>% select(starts_with("SCIENT"))

# Variabelen verkennen, eventueel spiegelen
descr(v)
lapply(v, attributes)
lapply(v, freq)

# spiegelen
dta$scientbe_m <- 5 - dta$SCIENTBE
dta$scientgo_m <- 5 - dta$SCIENTGO
dta$scienthe_m <- 5 - dta$SCIENTHE
corr.test(dta$scientbe_m, dta$SCIENTBE)
corr.test(dta$scientgo_m, dta$SCIENTGO)
corr.test(dta$scienthe_m, dta$SCIENTHE)

# update v
v <- dta[c("scientbe_m", "scientgo_m", "scienthe_m", "SCIENTOD")]

# Correlaties bekijken
corr.test(v)

# Cronbach's alpha bekijken
psych::alpha(v)              # package expliciet

v <- dta[c("scientbe_m", "scientgo_m", "scienthe_m")]
psych::alpha(v)  

# Kijk naar missings
freq(rowSums(is.na(v)))

# Gevolgen voor hoe je de schaal maakt: somscore tricky -> alleen complete cases

# Bij gemiddelde geen probleem als er maar 1 of 2 items zijn: na.rm
dta$att_sci <- rowMeans(v, na.rm = T)
print(dta %>% select(scientbe_m, scientgo_m, scienthe_m, att_sci), n = 100)
freq(dta$att_sci)

# Toch som score? 
dta$att_sci3 <- rowSums(v, na.rm = T)
dta$att_sci4 <- rowSums(v, na.rm = F)
print(dta %>% select(scientbe_m, scientgo_m, scienthe_m, att_sci3, att_sci4), 
      n = 100)

# Dus: gebruik somscore nooit met na.rm = T !!

# Complexer voorbeeld : alleen waarden meenemen onder voorwaarde(n)
# Bijvoorbeeld tellen aantal items agree (3) of strongly agree (4)
dta$att_sci5 <- rowSums(v >= 3, na.rm = F)
freq(dta$att_sci5)
print(dta %>% select(scientbe_m, scientgo_m, scienthe_m, att_sci5), n = 100)






