# Tutorial NSMA - igraph 
# Visualisatie: Vertices

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

# van igraph naar een data frame met de edge list
el_fr <- as_data_frame(igr_fr, what = "edges")
el_fr

# van igraph naar een data frame met de vertices
vl_fr <- as_data_frame(igr_fr, what = "vertices")
vl_fr


# ------------ Fixeer de layout (zie tutorial plotten ) ------------------

set.seed(5678)
my_l <- layout_nicely(igr_fr)
plot.igraph(igr_fr, layout = my_l)


# ----------- Twee manieren om layout aan te passen -------------

# 1. aan plot commando toevoegen. Is eenmalig!
plot.igraph(igr_fr, layout = my_l, edge.arrow.size = 0.1, 
            vertex.color = "black")   

# 2. als kenmerk aan V() toevoegen (of aan E(), zie tutorial edges)
V(igr_fr)
V(igr_fr)$color <- "yellow"   # werkt net als variabelen/ kolommen in df
V(igr_fr)$color               # R herhaalt de input (net als bij matrix)
plot.igraph(igr_fr, layout = my_l, edge.arrow.size = 0.1)  

V(igr_fr)$label <- c(1:7)     # igraph herkent kenmerk "label" 
V(igr_fr)$label
plot.igraph(igr_fr, layout = my_l, edge.arrow.size = 0.1)  

V(igr_fr)$label[5] <- "Anna"
plot.igraph(igr_fr, layout = my_l, edge.arrow.size = 0.1)  


# -------- Voorbeeld achtergrondkenmerken vertices, vanuit df ----------

# vertex attribute: opleidingsniveau
# stel je hebt deze info in je data frame met vertices
vl_fr
vl_fr$opl <- c("laag", "hoog", "laag", "hoog", 
                "hoog", "laag", "laag")
vl_fr

# vervolgens omzetten naar kleuren
V(igr_fr)$color <- ifelse(vl_fr$opl=="laag",      # zie tutorial subsetting
                          "lightblue", "green")
V(igr_fr)$color
plot(igr_fr, edge.arrow.size=0.1, layout= my_l) 


# ------- De omgekeerde route: van igraph naar je df ----------------------
# ------- Voorbeeld netwerkkenmerk vertices (positie) ----------------------

# outdegree uitrekenen obv adj matrix tbv dikte node
degree(igr_fr, mode = "in")              # zie tutorial centraliteit
V(igr_fr)$label <- c("A", "B", "C", "D", "E", "F", "G")

vl_fr$indegr <- degree(igr_fr, mode = "in")
vl_fr

# layout vertices obv indegree
V(igr_fr)$size <- vl_fr$indegr
V(igr_fr)$size
plot(igr_fr, edge.arrow.size=0.1, layout= my_l)      # niet goed zichtbaar

V(igr_fr)$size <- V(igr_fr)$size * 8     # groter maken
plot(igr_fr, edge.arrow.size=0.1, layout= my_l)      # sommigen zijn te klein

V(igr_fr)$size                             # sommige nodes indegree 0 
V(igr_fr)$size[which(V(igr_fr)$size<10)] <- 10      # zie tutorial subsetting
plot(igr_fr, edge.arrow.size=0.1, layout= my_l)     # nice! (ingezoomd!)  


#  Meer informatie:
#  - Eerste deel boekhoofdstuk (McNulty)
#  - Igraph documentatie over Drawing graphs



