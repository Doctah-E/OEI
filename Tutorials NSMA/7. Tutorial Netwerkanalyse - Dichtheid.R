# Tutorial NSMA - igraph 
# Netwerkanalyse - Dichtheid

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

# density
am_fr
sum(am_fr)
# mogelijke ties:n^2 - n
sum(am_fr) / (7^2 - 7)          # deel door 2 bij undirected

adj_mat_dir <- matrix(c(0, 1, 0, 0, 0,
                        0, 0, 0, 1, 1,
                        0, 0, 0, 0, 1,
                        0, 0, 0, 0, 1,
                        0, 0, 0, 0, 0), 5, 5, byrow = T)


# ter vergelijking
# niet density()!
edge_density(igr_fr)               # idem




