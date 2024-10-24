# Tutorial NSMA
# Netwerkdata: info van alters toekennen aan ego bij full-network data

library(dplyr)

# Soms wil je kenmerken van alters toekennen aan ego bij full-network data

# Bijv: heeft gem. cijfer in iemands netwerk een effect op eigen cijfer? 


# ----------------- maak fictieve full netwerk data ---------------------------

data <- data.frame(ego = LETTERS[1:10], alter1 = NA, alter2 = NA, alter3 = NA)

# willekeurige ego's als alters
set.seed(123)
for(i in 1:nrow(data)){
    data[i, 2:4] <- sample(c(data$ego[-i], NA, NA, NA), 3, replace = F)
}

# wijs NA toe indien vorig kolom ook NA
data[,3] <- ifelse(is.na(data[,2]), NA, data[,3])
data[,4] <- ifelse((is.na(data[,2]) | is.na(data[,3])), NA, data[,4])

# willekeurig kenmerk: cijfer vak 
data$cijfer <- sample(3:10, 10, replace = T)
data <- relocate(data, ego, cijfer)


# ----------------- info van alters naar ego ----------------------------------

alter <- data[, 1:2]
names(alter)[1]<- "alter"

# je zou één voor één alle kolommen kunnen nagaan
data2 <- data
data2 <- merge(data2, alter, by.x = "alter1", by.y = "alter", all.x = T, 
               suffixes = c("", "alter1"))
data2 <- merge(data2, alter, by.x = "alter2", by.y = "alter", all.x = T, 
               suffixes = c("", "alter2"))
data2 <- merge(data2, alter, by.x = "alter3", by.y = "alter", all.x = T,
               suffixes = c("", "alter3"))

# maar bij veel kolommen is een loop gemakkelijker
# hoe doen we dat? 
# uitlezen index kolommen die we nodig hebben op match met "alter"
grep("alter", names(data))      # je kunt ook in de data kijken welke kolommen het zijn

# dan een loop maken die over verschillende namen heen loopt
# eerst een lege loop om het principe te laten zien
for(i in names(data)[grep("alter", names(data))]){
    print(i)
}

# dan de loop die we feitelijk nodig hebben
for(i in names(data)[grep("alter", names(data))]){
    data <- merge(data, alter, by.x = i, by.y = "alter", all.x = T,
                  suffixes = c("", i))
}

# beetje fatsoeneren
data <- arrange(data, ego)
data <- relocate(data, ego, cijfer, alter1, alter2, alter3)

# gemiddeld cijfer uitrekenen
data$cijf_nw <- rowMeans(data[, 6:8], na.rm = T)

# hangt eigen cijfer samen met gem cijfer in netwerk? 
m1 <- lm(cijfer ~ cijf_nw, data = data)
summary(m1)


# ------------- Alternatieve benandering functie en lapply --------------------

zoek_op <- function(x){
    if(is.na(x)) return(NA)
    data$cijfer[data$ego == x]
}

data$alter1friend <- lapply(data$alter1, zoek_op)



