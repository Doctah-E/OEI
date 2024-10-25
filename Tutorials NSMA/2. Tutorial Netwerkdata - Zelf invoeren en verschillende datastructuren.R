# Tutorial NSMA - igraph 
# Netwerkdata: zelf invoeren en verschillende datastructuren

graphics.off()
rm(list=ls())

# Laad library igraph. Eventueel installeren
library(igraph)


# -------------------- Eigen input van data --------------------------

# Kan op allerlei manieren. Focus hier is via een adjacency matrix

# Maak een adjacency matrix
am_fr <- matrix(0, 7, 7)
am_fr

# voegen namen nodes toe
colnames(am_fr) <- c("A", "B", "C", "D", "E", "F", "G")
rownames(am_fr) <- c("A", "B", "C", "D", "E", "F", "G")
am_fr

#invoeren data
am_fr[1,] <- c(0,1,1,1,0,0,0)
am_fr[2,] <- c(0,0,1,1,0,0,0)
am_fr[3, c(1,2,4)] <- 1
am_fr[4, c(1,5)] <- 1
am_fr[5,4] <- 1
am_fr[6,5] <- 1
am_fr[7,5] <- 1
# Checken! 
am_fr                         # klopt


# ------------ Van matrix naar igraph object --------------------------

# Igraph gebruikt eigen, zelfgedefinieerde objecten.
# Voordat je met igraph kunt werken moet je altijd een "igraph graph" 
# aanmaken.

igr_fr <- graph_from_adjacency_matrix(am_fr, mode= "directed")

# Bij een data frame gebruik je "graph_from_data_frame"

# klopt het?
igr_fr
plot(igr_fr)
plot(igr_fr, edge.arrow.size=0.1)


# ------------------ Edge lists ---------------------------------------------

# edge list ingebouwd
E(igr_fr)

# van igraph naar een data frame met de edge list
el_fr <- as_data_frame(igr_fr, what = "edges")
el_fr


# ------------------- Vertices data ------------------------------------------

# vertices list ingebouwd
V(igr_fr)

# van igraph naar een data frame met de vertices
vl_fr <- as_data_frame(igr_fr, what = "vertices")
vl_fr



