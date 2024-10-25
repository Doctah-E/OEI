# Tutorial NSMA
# Subsetting en logische voorwaarden

library("summarytools")
library("tidyverse")


# -------------------------- Subsetting -------------------------------

# Data maken: tentamen en presentatie cijfers
df1 <- data.frame(id = 1:10,
                  naam = c("Anna", "Bert", "Cindy", "Dirk", "Evelien", 
                           "Fred", "Gerard", "Hans", "Ineke", "Jolien"),
                  tent = sample(1:10, 10, replace = T))
df2 <- data.frame(id = 1:10,
                  pres = sample(1:10, 10, replace = T))
# Vector 
my_vec <- c("Anna", "Bert", "Cindy", "Dirk", "Evelien", 
            "Fred", "Gerard", "Hans", "Ineke", "Jolien")
my_vec


# Subsetting met rechte haken []
my_vec[5]
my_vec[2] <- "Bernard"
my_vec
# Dataframe
df1[8,2]
df1[3,]         # weglaten kolom betekent de hele rij!
# Subsetting kan ook met tidyverse 
# Dan werkt het steeds met select en filter
df1 |> filter (id==3)   # hetzelfde met tidyverse

df1[,1]         # weglaten rij betekent de hele kolom!
df1 |> select (id)      # hetzelfde met tidyverse (als dataframe)

# Voorbeeld subsetting bij frequencies
freq(df1$tent[1:5])      # de frequentie vd cijfers vd bovenste 5
df1 |> filter(id < 6) |> select(tent) |> freq()   # met tidyverse

# Omgekeerd subsetten: bijv. -c(), df[-1,-2])
my_vec[-c(3, 5, 7)]
df1[-1,-2]                 # eerste rij en tweede kolom eruit
df1 |> select(!naam) |> filter(id > 1)    # met tidyverse


# --------------------- Logische voorwaarden --------------------------

# ==, >, <
df1$tent[df1$tent >= 5.5]       # laat de voldoendes zien
df1$tent >= 5.5
df1$tent[df1$naam == "Anna"]    # cijfer van Anna
df1$naam == "Anna"
mean(df1$tent[df1$tent >= 5.5])   # gemiddelde van alle voldoendes

# !=
df1$naam[df1$id != 10]          # de namen die niet 10 als id hebben

# Gebruik van %in%
df1$tent[df1$naam %in% c("Cindy", "Dirk", "Evelien")] # cijfers cindy etc.

# & | is.na 
df1$tent[df1$naam == "Dirk" | df1$naam == "Fred"] <- NA # missing maken
df1$id[is.na(df1$tent)]                # IDs van waar cijfer ontbreekt
df1$tent[df1$id > 5 & df1$tent < 5.5]  #cijfers ID>5 en onvoldoende


# ----------------------- Functie ifelse -----------------------------

df1$vold <- ifelse(df1$tent>=5.5, "voldoende", 
                   "onvoldoende") # nieuwe var on-/voldoende

# als vectoren even lang zijn kun je zelfs tussen df's vergelijken
# let uiteraard heel goed op dat het dezelfde cases zijn
# en in dezelfde volgorde
df1$pres_vold <- ifelse(df2$pres>=5.5, "voldoende", "onvoldoende")






