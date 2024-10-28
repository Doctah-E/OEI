# Tutorial NSMA - igraph 
# Netwerkdata: van survey data naar igraph

graphics.off()
rm(list=ls())
library(igraph)
library(tidyverse)

setwd("C:/Users/ejvan/OneDrive - Vrije Universiteit Amsterdam/Bachelor Sociologie/NSMA 22-23/kennisclips/netwerkanalyse opdracht knecht data")


# -------------------- Eigen input van data --------------------------

data <- read.csv("Simpel netwerk met missings.csv", sep = ";")


# ------------------ Edge list ---------------------------------------

# poging 1
el <- data |> 
      select(Resp, Groep, Vriend1, Vriend2, Vriend3) |> 
      pivot_longer(Vriend1:Vriend3)

# nog niet helemaal het gewenste resultaat. Poging 2.
el <- data |> 
  select(Resp, Groep, Vriend1, Vriend2, Vriend3) |> 
  pivot_longer(Vriend1:Vriend3, values_drop_na = T)

# name mag weg, daar raakt igraph alleen maar van in de war
el <- select(el, -name)

# ego en alter moeten in de eerste twee kolommen
el <- relocate(el, Resp, value)

# en geef de kolommen ook een betere naam
names(el)
names(el)[1] <- "ego"
names(el)[2] <- "alter"


# ------------------- Vertices data -----------------------------------

# hebben we een vertices bestand nodig?
# je hebt toch V()??

igr_vr <- graph_from_data_frame(el, directed = T)
plot.igraph(igr_vr, edge.arrow.size = 0.2)
V(igr_vr)

# oops... isolates verdwenen
# aparte vertices list aanleveren
vl <- data |> 
      select(Resp, Groep, Vriend1, Vriend2, Vriend3) |> 
      pivot_longer(c(Resp, Vriend1:Vriend3), values_drop_na = T)

vl <- select(vl, -name)
vl <- relocate(vl, value)

# verschillende vertices komen alleen vaker voor
vl <- arrange(vl, value)
vl <- distinct(vl, value, .keep_all = T)

# nu kunnen we een igraph object maken met zowel de edge list als de vertices list
igr_vr <- graph_from_data_frame(el, directed = T, vertices = vl)
plot.igraph(igr_vr, edge.arrow.size = 0.2)
V(igr_vr)


