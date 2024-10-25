# Tutorial Netwerkanalyse - Van onderzoeksvraag naar resultaat
# Cursus NSMA

rm(list=ls())
graphics.off()
library(summarytools); library(haven); library(dplyr)
library(tidyr); library(igraph)

#setwd("C:/Users/ejvan/OneDrive - Vrije Universiteit Amsterdam/Bachelor Sociologie/NSMA 23-24/opdrachten")
setwd("C:/Users/ein900/OneDrive - Vrije Universiteit Amsterdam/Bachelor Sociologie/NSMA 23-24/opdrachten")
data <- read_sav("Pupils.sav")
data <- as_tibble(data)
data


# Voorbeeld onderzoeksvraag:
# Hebben scholieren die geïsoleerd zijn in schoolnetwerken een 
# grotere kans op deviant gedrag? 

# Operationalisering:
# isolatie -> indegree 0 vriendschapsnetwerk vs de rest
# deviant gedrag -> schaal


# --------------- data bewerken ----------------------------

# deviant gedrag
# bekijk data
data %>% select(actlate:actsmoke) %>% str()     
data %>% select(actlate:actsmoke) %>% descr()
# maak schaalvariabele door gemiddelde te nemen
data$dev <- data %>% select(actlate:actsmoke) %>% rowMeans()
freq(data$dev)
hist(data$dev)


# ------- maak edge list van vrienden --------

# bekijk data
data %>% select(friend1:friend12) %>% str()         # variabelen eigenlijk character
data %>% select(friend1:friend12) %>% descr()

# maak data frame met edges
el_fr <- data  %>%
    select(id, friend1:friend12, klasnr) %>% 
    pivot_longer(friend1:friend12, values_to = "alter", values_drop_na = T)  %>%  
    relocate(id, alter, klasnr)
el_fr <- select(el_fr, -name)


# ------- maak vertices list --------------------

vl <- data %>% 
    select(id, friend1:friend12, klasnr) %>% 
    pivot_longer(c(id, friend1:friend12), 
                 values_to = "vertex", 
                 values_drop_na = T)  %>% 
    arrange(vertex)
 
# verwijdere dubbele vertices en houd alleen vertex en klasnr over
vl <- vl %>% distinct(vertex, .keep_all = T) %>% select(vertex, klasnr)


# ------------ naar igraph en terug ----------------------

# maak igraph object
igr_fr <- graph_from_data_frame(el_fr, directed = T, vertices = vl)  
igr_fr

# reken indegree uit en stop dat in data frame
temp <- as.data.frame(degree(igr_fr, mode = "in"))
temp <- cbind(rownames(temp), temp)
names(temp)[1] <- "id"
names(temp)[2] <- "fr_indegr"
data <- merge(data, temp, by = "id")


# ---------------- regressie --------------------------------

# dummy maken van indegr
freq(data$fr_indegr)
data$iso <- ifelse(data$fr_indegr==0, 1, 0)
freq(data$iso)

# analyse
m1 <- lm(data$dev ~ data$iso)
summary(m1)                 # isolates minder deviant gedrag!
# Regressievergelijking: Y = 1.55 - 0.14 * iso

