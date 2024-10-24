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











###########################################################################
# ------------------------- ------------------------------------
# ----------- andere analyses onderzoeksvragen ------------------------------
###########################################################################


# ----------- Hangt roken samen met populariteit? ----------------------

data$actsmoke <- as_factor(data$actsmoke)
freq(data$actsmoke)                    # niet heel veel gedaan, maar wel wat

# populair -> vaak genoemd als vriend
freq(data$friend1)

# ------- maak edge list van vrienden--------
el_fr <- data %>% 
    select(id, friend1:friend12, klasnr) %>% 
    pivot_longer(friend1:friend12, values_to = "alter", values_drop_na = T)  %>%  
    relocate(id, alter, klasnr)
el_fr <- select(el_fr, !name)
head(el_fr, 10)

# ------- maak vertices list --------------------
vl <- data %>% 
    select(id, friend1:friend12, klasnr) %>% 
    pivot_longer(id:friend12, values_to = "vertex", values_drop_na = T)  %>% 
    arrange(vertex) %>% 
    distinct(vertex, .keep_all = T)           # verwijderd dubbele vertices
vl <- select(vl, vertex, klasnr)

# naar igraph
igr_fr <- graph_from_data_frame(el_fr, directed = T, vertices = vl)  
igr_fr
temp <- as.data.frame(degree(igr_fr, mode = "in"))
temp <- cbind(rownames(temp), temp)
names(temp)[1] <- "id"
names(temp)[2] <- "fr_indegr"
data <- merge(data, temp, by = "id")

# regressie
data$actsmoke <- as.numeric(data$actsmoke)
sm_m1 <- lm(data$actsmoke ~ data$fr_indegr)
summary(sm_m1)                 # geen verband tussen populariteit en roken



# --------- zijn influencers op school van kinderen hoger opgeleiden? -----

# influencers -> opinion indegree
freq(data$educfa)                 # missings ontbreken
data$educfa <- ifelse(data$educfa >= 4, NA, data$educfa)
str(data$educfa)
freq(data$educmo)                 # idem
data$educmo <- ifelse(data$educmo >= 4, NA, data$educmo)
freq(data$educmo)
data <- data %>% relocate(id, educfa, educmo)

data$educ_oud <- rowMeans(data[, c(2,3)], na.rm = T)
data <- data %>% relocate(id, educfa, educmo, educ_oud)


# ------- maak edge list van vrienden--------
el_op <- data %>% 
    select(id, opinio1:opinio12, klasnr) %>% 
    pivot_longer(opinio1:opinio12, names_to = "name",  
                 values_to = "alter", values_drop_na = T)  %>%  
    relocate(id, alter, klasnr)
el_op <- select(el_op, !name)

# ------- maak vertices list --------------------
vl <- data %>% 
    select(id, opinio1:opinio12, klasnr) %>% 
    pivot_longer(id:opinio12, names_to = "name",  
                 values_to = "vertex", values_drop_na = T)  %>% 
    arrange(vertex) %>% 
    distinct(vertex, .keep_all = T)           # verwijderd dubbele vertices
vl <- select(vl, vertex, klasnr)

# naar igraph
igr_op <- graph_from_data_frame(el_op, directed = T, vertices = vl)  
igr_op
temp <- as.data.frame(degree(igr_op, mode = "in"))
temp <- cbind(rownames(temp), temp)
names(temp)[1] <- "id"
names(temp)[2] <- "op_indegr"
data <- merge(data, temp, by = "id")

# regressie
sm_m2 <- lm(data$op_indegr ~ data$educ_oud)
summary(sm_m2)                 # geen verband tussen educ parents en influencer





# ------- Heeft gepest worden een negatief effect op schoolresultaten? ---------
# schoolres >- gem cijfer
# pesten -> outdegree! bully 1-12
names(data)
data$cijf <- data %>% 
    select(gradmatb:gradhanb) %>% 
    rowMeans()
freq(data$cijf)

# ------- maak edge list van bully--------
el_bu <- data %>% 
    select(id, bully1:bully12, klasnr) %>% 
    pivot_longer(bully1:bully12, values_to = "alter", values_drop_na = T)  %>%  
    relocate(id, alter, klasnr)
el_bu <- select(el_bu, !name)

# ------- maak vertices list --------------------
vl <- data %>% 
    select(id, bully1:bully12, klasnr) %>% 
    pivot_longer(id:bully12, values_to = "vertex", values_drop_na = T)  %>% 
    arrange(vertex) %>% 
    distinct(vertex, .keep_all = T)           # verwijderd dubbele vertices
vl <- select(vl, vertex, klasnr)

# naar igraph
igr_bu <- graph_from_data_frame(el_bu, directed = T, vertices = vl)  
igr_bu
temp <- as.data.frame(degree(igr_bu, mode = "out"))
temp <- cbind(rownames(temp), temp)
names(temp)[1] <- "id"
names(temp)[2] <- "bu_outdegr"
data <- merge(data, temp, by = "id")

# regressie
# dummy maken van indegr
sm_m4 <- lm(data$cijf ~ data$bu_outdegr)
summary(sm_m4)          # geen effect



# -- Heeft de grootte van het supportnetwerk een invloed op schoolresultaten? --
# support -> indegree pracsup1-12
# schoolresultaten -> data$cijf

# ------- maak edge list van pracsup--------
el_ps <- data %>% 
    select(id, pracsup1:pracsu12, klasnr) %>% 
    pivot_longer(pracsup1:pracsu12, values_to = "alter", values_drop_na = T)  %>%  
    relocate(id, alter, klasnr)
el_ps <- select(el_ps, !name)

# ------- maak vertices list --------------------
vl <- data %>% 
    select(id, pracsup1:pracsu12, klasnr) %>% 
    pivot_longer(id:pracsu12, values_to = "vertex", values_drop_na = T)  %>% 
    arrange(vertex) %>% 
    distinct(vertex, .keep_all = T)           # verwijderd dubbele vertices
vl <- select(vl, vertex, klasnr)

# naar igraph
igr_ps <- graph_from_data_frame(el_ps, directed = T, vertices = vl)  
igr_ps
temp <- as.data.frame(degree(igr_ps, mode = "in"))
temp <- cbind(rownames(temp), temp)
names(temp)[1] <- "id"
names(temp)[2] <- "ps_indegr"
data <- merge(data, temp, by = "id")

# regressie
# dummy maken van indegr
sm_m5 <- lm(data$cijf ~ data$ps_indegr)
summary(sm_m5)  
