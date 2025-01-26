# Tutorial van SPSS naar R Studio: 2. Hoe doe ik dit in R?

# Je weet hoe je iets moet doen in SPSS maar niet in R

# -----------------------------------------------------------------------------

library(haven)   

# gebruik install.packages() als je dit pakket niet hebt
install.packages("haven")


# -----------------------------------------------------------------------------

# ------------ Maak SPSS bestand / geen onderdeel tutorial --------------------
    
tmp <- data.frame(A= sample(c(0:10), 10, replace = T),
                  B= sample(c(0:10), 10, replace = T),
                  C= sample(c(0:10), 10, replace = T))
attributes(tmp$A)$label <- "Een variabele" 
attributes(tmp$B)$label <- "Variabele twee" 
attributes(tmp$C)$label <- "Variabele drie" 
getwd()
write_sav(tmp, "tmp.sav")
dir()
rm(tmp)
    


# -----------------------------------------------------------------------------

# Hoe open ik data? (als in vorige tutorial) (GET FILE)

dta <- read_sav("tmp.sav")  # of read.csv() of load() bij .Rdata file


# -----------------------------------------------------------------------------

# Hoe krijg ik frequencies / descriptives? (FREQUENCIES, DESCRIPTIVES)

library(summarytools)
freq(dta$A)
descr(dta[, 2:3])
#functies verwachten een variabele/kolom of een data frame
# het laatste voorbeeld gebruikt subsetting: 
# niet alle data, maar alle rijen en kolommen 2 en 3
# [link subsetting]


# -----------------------------------------------------------------------------

# Wat is COMPUTE in R? 

dta$D <- dta$C - dta$B
dta


# -----------------------------------------------------------------------------

# Hoe hercodeer (RECODE) ik een variabele?

library(dplyr)
freq(dta$A)
dta$E <- case_match(dta$A, 0:4 ~ 0, 5:6 ~ 1, 7:10 ~ 2, .default = dta$A)
freq(dta$E)
# als je met logische voorwaarden wilt werken gebruik je case_when()

# [ link naar tutorial hercoderen ]


# -----------------------------------------------------------------------------

# Hoe verander ik variable labels (VARIABLE LABELS)
# Variable labels niet zo nuttig
attributes(dta$A)$label <- "nieuw label" 
attributes(dta$A)$label


# -----------------------------------------------------------------------------

# Hoe verander ik value labels (VALUE LABELS)
# Value labels -> factor variables
# Typen variabelen: numeric, character, factor
str(dta$E)
dta$F <- factor(dta$E, labels= c("onvoldoende", "voldoende", "goed"))
freq(dta$F)
str(dta$F)


# -----------------------------------------------------------------------------

# Hoe krijg ik een kruistabel (CROSSTABS)
install.packages("gmodels")
library(Gmodels)
Cross


# -----------------------------------------------------------------------------

# Hoe maak ik een correlatiematrix? (CORRELATIONS)


# -----------------------------------------------------------------------------

# Hoe draai ik een gemiddelde uit (MEANS)? 


# -----------------------------------------------------------------------------

# Hoe doe ik een regressieanalyse? (REGRESSION)



# [link opzetten onderzoeksproject]
# [link verkennen van data]
# [link Github]









