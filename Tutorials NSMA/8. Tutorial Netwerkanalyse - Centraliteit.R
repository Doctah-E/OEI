# Tutorial NSMA - igraph 
# Netwerkanalyse - centraliteit

library(igraph)
graphics.off()
rm(list=ls())


# -------- Begin met het simpele netwerk uit de eerdere opdracht ---------

# Maak een adjacency matrix
am_fr <- matrix(0, 7, 7)
colnames(am_fr) <- c("A", "B", "C", "D", "E", "F", "G")
rownames(am_fr) <- c("A", "B", "C", "D", "E", "F", "G")
am_fr[1,] <- c(0,1,1,1,0,0,0)
am_fr[2,] <- c(0,0,1,1,0,0,0)
am_fr[3, c(1,2,4)] <- 1
am_fr[4, c(1,5)] <- 1
am_fr[5,4] <- 1
am_fr[6,5] <- 1
am_fr[7,5] <- 1
# Checken! 
am_fr                         # klopt
igr_fr <- graph_from_adjacency_matrix(am_fr, mode= "directed")


# Fixeer de layout 
set.seed(5678)
my_l <- layout_nicely(igr_fr)
plot.igraph(igr_fr, layout = my_l, edge.arrow.size = 0.3)


# ---------------------------------------------------------------

# maken df voor vertices
vert_fr <- as_data_frame(igr_fr, what = "vertices")

#toevoegen centraliteitsmaten
vert_fr$indegr <- degree(igr_fr, mode = "in")
vert_fr$outdegr <- degree(igr_fr, mode = "out")
vert_fr$outdegr_norm <- degree(igr_fr, mode = "out", normalized = T)

# op hoeveel kortste routes ligt een node?
vert_fr$betw <- betweenness(igr_fr)

# hoe ver moeten andere nodes reizen om aan te komen bij de node?
vert_fr$close <- closeness(igr_fr, mode = "in")


# een veiligere methode in grote datasets
# matchen op naam
vert_fr <- as_data_frame(igr_fr, what = "vertices")
vert_fr$id <- 7:1
vert_fr <- vert_fr[order(vert_fr$id),]
# nu zouden de centraliteitsscores bij de verkeerde nodes komen!
degree(igr_fr, mode = "in")
vert_fr$indegr <- degree(igr_fr, mode = "in")
# veiliger
temp <- as.data.frame(degree(igr_fr, mode = "in"))
rownames(temp)
temp <- cbind(name = rownames(temp), temp)
vert_fr <- merge(vert_fr, temp, by = "name")

# niet in tutorial laten zien: merge via dplyr als alternatief
library(dplyr)             # Let op: nu is as_data_frame een dplyr functie
vert_fr <- full_join(vert_fr, temp, by = "name")







