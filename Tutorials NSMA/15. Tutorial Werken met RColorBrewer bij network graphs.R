# Tutorial werken met RColorBrewer
# Inkleuren van vertices in network graphs

library(summarytools)
library(dplyr)
library(RColorBrewer)
library(igraph)


# -------------------- random graph --------------------------------------------

set.seed(1234)
g <- sample_smallworld(1, 50, 2, 0.1)
my_lay <- layout_nicely(g)
plot.igraph(g, edge.arrow.size = 0.1, layout = my_lay)
V(g)


# --------------- kleurenpaletten van RColorBrewer gebruiken -------------------

display.brewer.all()

# aantal kleuren uit palette gebruiken: brewer.pal()
brewer.pal(5, "Greys")
# geeft hexadecimale RGB codes
plot(x=0, y=0, type= "n", axes= F, ann = F)
text(x=0, y=0, col = "#FF0000", labels = "Dit is rood", cex= 2)
plot(x=0, y=0, type= "n", axes= F, ann = F)
text(x=0, y=0, col = "#0000FF", labels = "Dit is blauw", cex= 2)

# soms heb je meer kleuren nodig dan er in het palette zitten
colorRampPalette(brewer.pal(9, "Greys"))(50)

# vertices mee inkleuren
my_col <- colorRampPalette(brewer.pal(9, "Greys"))(50)
plot.igraph(g, vertex.color = my_col, edge.arrow.size= 0.2, layout = my_lay)

# je kunt ook zelf een kleurovergang maken
my_col2 <- colorRampPalette(c("white", "red"))(50)
plot.igraph(g, vertex.color = my_col2, edge.arrow.size= 0.2, layout = my_lay)


# --------- kleur baseren op kenmerk vertices (of edges) -----------------------

# Bijvoorbeeld wrk relatie
V(g)$wrk <- sample(c("student", "werkend", "gepensioneerd"), size = 50, replace = T)
V(g)$wrk
tmp_c <- brewer.pal(3, "Dark2")
tmp_c
V(g)$color <- case_match(V(g)$wrk, "student" ~ tmp_c[1],
                                    "werkend" ~ tmp_c[2],
                                    "gepensioneerd" ~ tmp_c[3])
# deze tutorial legt case_match uit:
# https://www.youtube.com/watch?v=NMonzk2lZ0s
V(g)$color
plot.igraph(g, edge.arrow.size= 0.2, layout = my_lay)
plot.igraph(g, edge.arrow.size= 0.2, layout = my_lay, vertex.label = V(g)$wrk)

# eventueel kun je ook een legenda maken
plot.igraph(g, edge.arrow.size= 0.2, layout = my_lay)
legend("bottomright", legend = c("student", "werkend", "gepensioneerd"), 
       col = tmp_c, pch = 19)


# wat te doen bij veel verschillende waardes? 
# bijv. leeftijd weergeven
set.seed(1234)
V(g)$lft <- sample(18:80, 50, replace = T)
freq(V(g)$lft)

# nu bovenstaande wat meer automatiseren
# hoe krijgen we alle aanwezige categoriën/ waardes?
as.factor(V(g)$lft)
cbind(V(g)$lft, as.factor(V(g)$lft))
nlevels(as.factor(V(g)$lft))

tmp_c <- colorRampPalette(brewer.pal(9, "Greys"))(nlevels(as.factor(V(g)$lft)))
# belangrijk: nu staan kleuren op zelfde volgorde als factor levels

V(g)$color <- tmp_c[as.numeric(as.factor(V(g)$lft))]

plot.igraph(g, edge.arrow.size= 0.2, layout = my_lay)
plot.igraph(g, edge.arrow.size= 0.2, layout = my_lay, vertex.label = V(g)$lft)


# legenda
legend("bottomright", legend = c("19 jaar", "80 jaar"), 
       col = tmp_c[c(1,35)], pch = 19)

legend("bottomright", legend = c("19 jaar", "80 jaar"), 
       pch = 21, pt.bg = tmp_c[c(1, 35)], col = "black")









