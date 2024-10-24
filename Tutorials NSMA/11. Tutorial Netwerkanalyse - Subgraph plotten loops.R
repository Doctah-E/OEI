# NSMA igraph tutorial
# Werken met subgraph()

library(igraph)
graphics.off()
rm(list=ls())

# genereer random  netwerkdata met verschillende componenten
adj <- matrix(0, 40, 40)
set.seed(6789)
adj[1:10,1:10] <- rbinom(100, 1, 0.2)
adj[11:20,11:20] <- rbinom(100, 1, 0.4)     # toenemende density
adj[21:30,21:30] <- rbinom(100, 1, 0.6)
adj[31:40,31:40] <- rbinom(100, 1, 0.8)
for(i in 1:40){
    adj[i,i] <- 0           # zorgen dat de diagonaal nullen heeft
}

# naar igraph
igr <- graph_from_adjacency_matrix(adj, mode = "directed")
igr
V(igr)$group <- rep(1:4, each = 10)
V(igr)$group


# ---------------------- Subgraph plotten --------------------------------

set.seed(1234)
sub_gr1 <- subgraph(igr, V(igr)[group == 1])
plot.igraph(sub_gr1, edge.arrow.size = .2)

# Je kunt gewoon base plot functies gebruiken icm igpraph
abline(h=0, v=0)
text(c(0.5, 0.5), c(-0.25, 0.8), c("voorzitter", "secretaris"), cex = .8)

# Dus bijvoorbeeld ook meerdere graphs
par(mfrow = c(1,2), mar = c(1,1,1,1))
set.seed(1234)
sub_gr1 <- subgraph(igr, V(igr)[group == 1])
plot.igraph(sub_gr1, edge.arrow.size = .2, main = "Groep 1")
sub_gr4 <- subgraph(igr, V(igr)[group == 4])
plot.igraph(sub_gr4, edge.arrow.size = .2, main = "Groep 4")


# ----------- kenmerken van subgraphs uitrekenen ------------------------------

# kenmerk alle subgraphs in loop uitrekenen
for (i in 1:4) {
    sub_gr <- subgraph(igr, V(igr)[group == i])
    print(edge_density(sub_gr))
}

# of naar een data frame schrijven
grp <- data.frame(group = 1:4)
for (i in 1:4) {
    sub_gr <- subgraph(igr, V(igr)[group == i])
    grp$density[i] <- edge_density(sub_gr)
    grp$av_path[i] <- mean_distance(sub_gr)
}


