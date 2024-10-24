# Tutorial NSMA - igraph 
# Visualisate: Edges

library(igraph)
graphics.off()
rm(list=ls())

# zie ook de iets uitgebreidere tutorial over vertices
# de vormgeving daarvan werkt grotendeels hetzelfde


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


# ----------------------- Fixeer de layout --------------------------

set.seed(5678)
my_l <- layout_nicely(igr_fr)
plot.igraph(igr_fr, layout = my_l)


# ----- Kenmerken aan plot commando of  E() toevoegen ---------------

plot.igraph(igr_fr, layout = my_l, edge.arrow.size = 0.1) 

E(igr_fr)
E(igr_fr)$arrow.size <- 0.3
plot.igraph(igr_fr, layout = my_l) 
E(igr_fr)$arrow.size

# toevoegen aan E() ivm subsetting
length(E(igr_fr))
E(igr_fr)[c(1,8,10,13)]$color <- "black"
plot(igr_fr, layout= my_l)
# niet het verwachte resultaat!
# igraph neemt aan dat je de default kleur wilt overschrijven
# en dat de rest geen kleur heeft
E(igr_fr)$color                 # aantal ontbrekende waarden

E(igr_fr)$color <- "grey"       # gebruik repetitie
E(igr_fr)[c(1,8,10,13)]$color <- "black"
plot(igr_fr, layout= my_l) # moeilijk te zien

E(igr_fr)$width <- 3
plot(igr_fr, layout= my_l)


# -------------- Informatie halen uit df  --------------

# Bijv: je hebt data over de mate van contact tussen nodes 
# Bijv. een vraag (voor alle genoemde personen) Hoe vaak 
# zie je deze persoon? (1= weinig; 2= soms; 3=vaak)

E(igr_fr)$color <- "grey" 

# van igraph naar een data frame met de edge list
# fictief bestand
el_fr <- as_data_frame(igr_fr, what = "edges")
el_fr
el_fr$contact <- c(3, 1, 1, 2, 3, 2, 1, 3, 2, 1, 2, 2, 3)

# omzetten naar soort lijn (lty = line type)
E(igr_fr)$lty <- ifelse(el_fr$contact==3, "solid", 
                        ifelse(el_fr$contact==2, "dashed", 
                               "dotted"))
E(igr_fr)$lty
plot(igr_fr, layout= my_l)

# edges liggen soms over elkaar heen
E(igr_fr)$curved <- T
plot(igr_fr, layout= my_l)

# arrow head nog wat vergroten
E(igr_fr)$arrow.size <- 0.5
plot(igr_fr, layout= my_l)



#  Meer informatie:
#  - Eerste deel boekhoofdstuk (McNulty)
#  - Igraph documentatie over Drawing graphs






