# Tutorial van SPSS naar R Studio: 2. Hoe doe ik dit in R?

# Je weet hoe je iets moet doen in SPSS maar niet in R


# -----------------------------------------------------------------------------

library(haven)   

# gebruik install.packages() als je dit pakket niet hebt
install.packages("haven")


# -----------------------------------------------------------------------------

# ------------ Maak SPSS bestand / geen onderdeel tutorial --------------------

set.seed(1234)    
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
# functies verwachten een variabele/kolom of een data frame
# het laatste voorbeeld gebruikt subsetting: 
#   niet alle data, maar alle rijen en kolommen 2 en 3
dta
dta[4,2]


# Meer weten over subsetting? 
# https://youtu.be/6-0tB_sElYU?si=50hoZIpHdJV_5gsJ
# https://github.com/ejvingen/R-tutorials/blob/main/Tutorials%20NSMA/4.%20Tutorial%20Syntax%20-%20Subsetting%20en%20logische%20voorwaarden.R


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


# Meer over hercoderen:
# https://youtu.be/NMonzk2lZ0s?si=-_XLPDjV10SMv6bw
# https://github.com/ejvingen/R-tutorials/blob/main/Tutorials%20OEI/4.%20Video%20tutorial%20-%20Data%20transformaties%20II%20recode.R


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
dta$F <- factor(dta$E, labels= c("onvoldoende", "redelijk", "goed"))
freq(dta$F)
str(dta$F)
# ook in View() zichtbaar
View(dta)


# Meer over werken met factors variables:
# https://youtu.be/Wo8s4OOOwt8?si=9M5G0PcHxlfuMU-B
# https://github.com/ejvingen/R-tutorials/blob/main/Tutorials%20OEI/3.%20Video%20tutorial%20-%20Data%20transformaties.R


# -----------------------------------------------------------------------------

# Hoe krijg ik een kruistabel (CROSSTABS)
install.packages("gmodels")
library(gmodels)
CrossTable(dta$A, dta$F)
CrossTable(x= dta$A, y= dta$F, prop.chisq = F, prop.r = F, prop.c = F, 
           prop.t = F)


# -----------------------------------------------------------------------------

# Hoe maak ik een correlatiematrix? (CORRELATIONS)
library(psych)
# functie vraagt om een matrix of dataframe
?corr.test()
#corr.test(dta)   # werkt niet vanwege factor variable F
corr.test(dta[, 1:5])

# Als er NA's zijn krijg je matrix met N per combinatie van variabelen
dta[2,1] <- NA
corr.test(dta[, 1:5])


# -----------------------------------------------------------------------------

# Hoe draai ik een gemiddelde uit (MEANS)? 
mean(dta$A)
mean(dta$A, na.rm= T)


# -----------------------------------------------------------------------------

# Hoe doe ik een regressieanalyse? (REGRESSION)
m1 <- lm(dta$A ~ dta$F)
m1 <- lm(A ~ F, data = dta)
summary(m1)



# Meer leren over gebruiken R (Studio)?
# https://www.youtube.com/@EJvanIngen/videos
# https://github.com/ejvingen/R-tutorials/tree/main









