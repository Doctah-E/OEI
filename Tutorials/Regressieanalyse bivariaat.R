# Eerste tutorial uit serie over regressieanalyse met R

# Onderwerpen: Bivariate regressie,

# Deze tutorials zijn complementair aan de R tutorials op Canvas
# https://canvas.vu.nl/courses/59293/modules - Lineair regression
# Of indien geen toegang:
# https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/9_1_linear_regression.md
# (Mauricio Garnier Villareal)

# ------------------------------------------------------------------------------

library(rio)
library(summarytools)
library(tidyverse)

# Data: WVS wave 7
# Website: https://www.worldvaluessurvey.org/WVSDocumentationWV7.jsp
# Download SPSS file 
# sla hem op in je working directory

getwd()       # aanpassen met setwd()
dir()

data <- import("WVS_Cross-National_Wave_7_spss_v5_0.sav")

# Data
freq(data$A_WAVE)
freq(data$B_COUNTRY)
attributes(data$B_COUNTRY)
data <- data %>% filter(B_COUNTRY == 528)

# Look at questionnaire
# Q46 = happiness
# Q262 = age
# Q273 = marital status
# Q48 = control
# Q49 = satfisfaction

data <- data %>% select(happy = Q46, age = Q262, 
                        mar_stat = Q273, control = Q48, 
                        satisf = Q49)
str(data)


# kijken naar happiness
freq(data$happy)
attributes(data$happy)
data$happy <- 5 - data$happy
freq(data$happy)
summary(data$happy)
sd(data$happy, na.rm = T)


# marital status
freq(data$mar_stat)
attributes(data$mar_stat)
lab <- attr(data$mar_stat, "labels")
names(lab)
data$mar_stat <- factor(data$mar_stat, 
                        levels = c(-5, -4, -2, -1, 1:6),
                        labels = names(lab))
str(data$mar_stat)
attributes(data$mar_stat)
freq(data$mar_stat)


# kijken naar age
freq(data$age)


# kijken naar control
freq(data$control)
attributes(data$control)
summary(data$control)
sd(data$control, na.rm = T)


# kijken naar life satisfaction
freq(data$satisf)
attributes(data$satisf)
summary(data$satisf)
sd(data$satisf, na.rm = T)


# -------------------- Bivariate regressie ------------------------------------

# Continue variabele
M1 <- lm(satisf ~ age, data = data)
summary(M1)



# Categorische variabele



# -------------- Storende variabelen en  mediatie -----------------------------

# 
M1 <- lm(satisf ~ age, data = data)
summary(M1)
tab_M1 <- as.data.frame(summary(M1)$coefficients)
options(scipen=999)
tab_M1 <- round(tab_M1, digits = 3)

M2 <- lm(satisf ~ age + control, data = data)
summary(M2)
tab_M2 <- round(as.data.frame(summary(M2)$coefficients), digits = 3)

# vergelijk de modellen
tab_vgl <- cbind(tab_M1[,1], tab_M2[,1])


