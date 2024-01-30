# Video tutorial: data transformaties II recode

# een schone start
rm(list=ls())
graphics.off()

# packages
library(haven)
library(dplyr)
library(summarytools)
library(forcats)

# Data: GSS wave 2018
setwd("C:/Users/ejvan/OneDrive - Vrije Universiteit Amsterdam/Bachelor Sociologie/OEI_Github/No_sync")
# download.file("https://gss.norc.org/Documents/spss/2018_spss.zip", "2018_spss.zip", mode = "wb")
dta <- read_spss(unzip("2018_spss.zip", "GSS2018.sav"))


# --------------- soms zijn lineaire transformaties het snelst -----------------

# vorige tutorial:
# dta$gelukkig <- 4 - dta$gelukkig


# ------------------- recode set waardes naar andere set ----------------------

# dplyr: case_match()
freq(dta$MARITAL)           # let op: numeriek
attributes(dta$MARITAL)
dta$marital2 <- case_match(dta$MARITAL, 4 ~ 3, .default = dta$MARITAL)
freq(dta$marital2)
# zelfde resultaat:
dta$marital2 <- case_match(dta$MARITAL, 1 ~ 1, 2 ~ 2, 3 ~ 3, 4 ~ 3, 5 ~5)
freq(dta$marital2)

# factor var van maken voor onderstaande recode
dta$mar2_f <- factor(dta$marital2, 
                     labels = c("Married", "Widowed", "Divorced/ separated",
                                "Never married"))
str(dta$mar2_f)
freq(dta$mar2_f)


# ---------------------- recode met voorwaarden -------------------------------

# zie eventueel tutorial subsetting en logische voorwaarden

# dplyr: case_when()
# kan bijv. ook prima met ifelse()

# bijv: dummy variabelen maken van marital status
freq(dta$MARITAL)
dta$mst_mar<- case_when(dta$MARITAL == 1 ~ 1,   # mag ook met meerdere variabelen
                        dta$MARITAL != 1 ~ 0)
freq(dta$mst_mar)

# als je niet steeds de naam van het df wilt typen en meerdere tegelijk wilt
# regels kunnen copy-paste en dan met <insert> overschrijven
dta <- dta %>% mutate(mst_mar = case_when(MARITAL == 1 ~ 1, MARITAL != 1 ~ 0),
                      mst_wdw = case_when(MARITAL == 2 ~ 1, MARITAL != 2 ~ 0),
                      mst_div = case_when(MARITAL == 3 ~ 1, MARITAL != 3 ~ 0),
                      mst_sep = case_when(MARITAL == 4 ~ 1, MARITAL != 4 ~ 0),
                      mst_nev = case_when(MARITAL == 5 ~ 1, MARITAL != 5 ~ 0))
freq(dta$mst_mar)
freq(dta$mst_wdw)
freq(dta$mst_div)
freq(dta$mst_sep)
freq(dta$mst_nev)


# ------------------------- factor variables -----------------------------------

# forcats: fct_recode()

# stel widowed samen met divorced / separated
freq(dta$mar2_f)
?fct_recode     # helaas andere conventies
dta$mar3_f <- fct_recode(dta$mar2_f, "Prev married" = "Widowed", 
                         "Prev married" = "Divorced/ separated")
freq(dta$mar3_f)

# Alternatief is terug naar numeriek en dan case_match()
# as.numeric()
# wel labels kwijt






