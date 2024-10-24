# Tutorial NSMA - igraph 
# Visualisatie: Netwerken plotten

library(igraph)
graphics.off()
rm(list=ls())

#install.packages("igraphdata")
library("igraphdata")
data(package="igraphdata")
data("karate")

# Wayne W. Zachary. An Information Flow Model for Conflict 
# and Fission in Small Groups. Journal of Anthropological 
# Research Vol. 33, No. 4 452-473

# ---------------------------------------------------------------------------

# Gebruik default visualisatie - elke keer iets anders
plot.igraph(karate)          # helaas is igraph slordig in _ en .

# Layout vastleggen
set.seed(1234)
my_lay <- layout_nicely(karate)    # dit is geen algoritme, igraph kiest er een
my_lay
plot.igraph(karate, layout = my_lay)

# vertex 10 aan de andere kant?
my_lay[10,] <- c(3.7, -3.1)
plot.igraph(karate, layout = my_lay)

# verschillende algoritmes
my_lay2 <- layout_with_fr(karate)         # Fruchterman-Reingold algoritme
plot.igraph(karate, layout = my_lay2)

my_lay3 <- layout_with_lgl(karate)        # Large graph layout
plot.igraph(karate, layout = my_lay3)

# zie documentatie online (eventueel via R for social scientists)




