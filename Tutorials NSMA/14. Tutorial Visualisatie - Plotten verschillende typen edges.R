# NSMA tutorial 
# Plotten van verschillende typen edges

library(dplyr)
library(igraph)


#  Hoe maak ik met igraph een graph met verschillende typen edges?


# Genereer een willekeurige edge list
set.seed(123)
data <- data.frame(t(replicate(20, sample(1:10, 2, replace = F))))
names(data)[1] <- "ego"
names(data)[2] <- "alter"
data <- arrange(data, ego, alter)
data                # drie dubbele ties
data$type <- c("vriend", "familie")

# naar igraph
igr <- graph_from_data_frame(data, directed = T)
plot.igraph(igr, edge.arrow.size = 0.4)

# maak kleur afhankelijk van type
E(igr)$type
E(igr)$color <- ifelse(E(igr)$type=="vriend", "blue", "black")
plot.igraph(igr, edge.arrow.size = 0.4)

# Eventueel nog een beetje opmaken
plot.igraph(igr, edge.arrow.size = 0.3, vertex.color = "white",
            main = "Vrienden- en familienetwerk")
legend("bottomleft", legend = c("vriend", "familie"), bty = "n", 
       col = c("blue", "black"), lty = 1)


