#NETWORK DATA ANALYSIS

library(sand)
library(igraph)
g<-graph.formula(1-2, 1-3, 2-3, 2-4, 3-5, 
                 4-5, 4-6, 4-7, 5-6, 5-7) #creo un grafo con 7 vertici
V(g)
E(g)
str(g)  #vertici, link e struttura
plot(g)
V(g)$color <- "red"
is.weighted(g)
wg <- g
E(wg)$weight <- runif(ecount(wg))
is.weighted(wg)
g$name <- "Grafo1"
dg<-graph.formula(1-+2, 1-+3, 2++3)
plot(dg)
dg <- graph.formula(Marco-+Giorgia, Marco-+Antonio, Giorgia++Antonio)
str(dg)
V(dg)$name
V(dg)$gender <- c("M","F","M")
E(dg)
get.adjacency(g) #matrice di contiguità
h<- induced.subgraph(g, 1:5)
str(h)
h<- g - vertices(c(6,7))
h<- h + vertices(c(6,7))
g<- h + edges(c(4,6), c(4,7), c(5,6), c(6,7))
h1<- h
h2<- graph.formula(4-6, 4-7, 5-6, 6-7)
g<- graph.union(h1,h2)
is.simple(g)
mg <- g + edges(2,3)
str(mg)
is.simple(mg)

degree(g)
degree(dg, mode = "in")
degree(dg, mode = "out")
is.connected(g)
is.connected(dg, mode = "weak")
is.connected(dg, mode = "strong")
diameter(g,weights = NA)
clusters(g)
g.full <- graph.full(7)
g.ring <- graph.ring(7)
g.tree <- graph.tree(7, children=2, mode="undirected")
g.star <- graph.star(7, mode="undirected")
par(mfrow=c(2, 2))
plot(g.full)
plot(g.ring)
plot(g.tree)
plot(g.star)

##NETWORK BIPARTITO##
g.bip <- graph.formula(actor1:actor2:actor3,
                         movie1:movie2, actor1:actor2 - movie1,
                         actor2:actor3 - movie2)
V(g.bip)$type <- grepl("^movie", V(g.bip)$name)
str(g.bip, v=T)     
proj <- bipartite.projection(g.bip)
str(proj[[1]])
str(proj[[2]])

##GRAPH LAYOUTS
g.1 <- graph.lattice(c(5,5,5))
data(aidsblog)
summary(aidsblog)
igraph.options(vertex.size=3, vertex.label=NA,
               edge.arrow.size=0.5)
par(mfrow=c(1, 2))
plot(g.l, layout=layout.circle)
title("5x5x5 Lattice")
plot(aidsblog, layout=layout.circle)
title("Blog Network")
plot(g.l, layout=layout.fruchterman.reingold)
title("5x5x5 Lattice")
plot(aidsblog, layout=layout.fruchterman.reingold)
title("Blog Network")

##ALBERI##
g.tree <- graph.formula(1-+2,1-+3,1-+4,2-+5,2-+6,2-+7,
                        2 + 3-+8,3-+9,4-+10)
par(mfrow=c(1, 3))
igraph.options(vertex.size=30, edge.arrow.size=0.5,
                  vertex.label=NULL)
plot(g.tree, layout=layout.circle)
plot(g.tree, layout=layout.reingold.tilford(g.tree,circular=T))
plot(g.tree, layout=layout.reingold.tilford)
plot(g.bip, layout=-layout.bipartite(g.bip)[,2:1],
  vertex.size=30, vertex.shape=ifelse(V(g.bip)$type,
  "rectangle", "circle"), vertex.color=ifelse(V(g.bip)$type, "red", "cyan"))

#CURARE IL LAYOUT DEL GRAFO# 
library(igraphdata)
data(karate)
set.seed(42)
l <- layout.kamada.kawai(karate)
# Plot undecorated first.
igraph.options(vertex.size=10)
par(mfrow=c(1,1),mar=c(1,1,1,1))
plot(karate, layout=l, vertex.label=V(karate))
# Now decorate, starting with labels.
V(karate)$label <- sub("Actor ", "", V(karate)$name)
# Two leaders get shapes different from club members.
V(karate)$shape <- "circle"
V(karate)[c("Mr Hi", "John A")]$shape <- "rectangle"
# Differentiate two factions by color.
V(karate)[Faction == 1]$color <- "red"
V(karate)[Faction == 2]$color <- "dodgerblue"
# Vertex area proportional to vertex strength
# (i.e., total weight of incident edges).
V(karate)$size <- 4*sqrt(graph.strength(karate))
v(karate)$size2 <- V(karate)$size * .5
# Weight edges by number of common activities
E(karate)$width <- E(karate)$weight
# Color edges by within/between faction.
F1 <- V(karate)[Faction==1]
F2 <- V(karate)[Faction==2]
E(karate)[ F1 %--% F1 ]$color <- "pink"
E(karate)[ F2 %--% F2 ]$color <- "lightblue"
E(karate)[ F1 %--% F2 ]$color <- "yellow"
# Offset vertex labels for smaller points (default=0).
V(karate)$label.dist <- ifelse(V(karate)$size >= 10, 0, 0.75)
# Plot decorated graph, using same layout.
plot(karate, layout=l)

hist(degree(karate), col="lightblue", xlim=c(0, 50),xlab="Vertex Degree", ylab="Frequency", main="")
hist(graph.strength(karate), col="pink",xlab="Vertex Strength", ylab="Frequency", main="")

data("yeast")
ecount(yeast)
vcount(yeast)
d.yeast <- degree(yeast)
hist(d.yeast,col="blue", lab="Degree", ylab="Frequency", main="Degree Distribution")
dd.yeast <- degree.distribution(yeast)
d <- 1:max(d.yeast)-1
ind <- (dd.yeast != 0)
plot(d[ind], dd.yeast[ind], log="xy", col="blue", xlab=c("Log-Degree"), ylab=c("Log-Intensity"),main="Log-Log Degree Distribution")

## MISURE DI CENTRALITA' ## 
#per varie misure cambia main con closeness, betweenness, o evcent$vector#

A <- get.adjacency(karate, sparse=FALSE)
library(network)
g <- network::as.network.matrix(A)
library(sna)
sna::gplot.target(g, degree(g), main="Degree",
                      circ.lab = FALSE, circ.col="skyblue",
                      usearrows = FALSE,
                      vertex.col=c("blue", rep("red", 32), "yellow"),
                      edge.col="darkgray")
l <- layout.kamada.kawai(aidsblog)
plot(aidsblog, layout=l, main="Hubs", vertex.label="",
         vertex.size=10 * sqrt(hub.score(aidsblog)$vector))
plot(aidsblog, layout=l, main="Authorities",
         vertex.label="", vertex.size=10 *
           sqrt(authority.score(aidsblog)$vector))

table(sapply(cliques(karate), length))
cliques(karate)[sapply(cliques(karate), length) == 5]
table(sapply(maximal.cliques(karate), length))

cores <- graph.coreness(karate)
sna::gplot.target(g, cores, circ.lab = FALSE,circ.col="skyblue", usearrows = FALSE,vertex.col=cores, edge.col="darkgray")

## PARTIZIONI DEL NETWORK ##
kc <- fastgreedy.community(karate)
length(kc)
sizes(kc)
plot(kc, karate)
library(ape)
dendPlot(kc, mode="phylo")

## MODELLI ## #randomGraph,smallWorld,preferentialAttachment
library(sand)
set.seed(42)
g.er <- erdos.renyi.game(100, 0.02)
plot(g.er, layout=layout.circle, vertex.label=NA)
is.connected(g.er)
table(sapply(decompose.graph(g.er), vcount))
mean(degree(g.er))
hist(degree(g.er), col="lightblue",xlab="Degree", ylab="Frequency", main="")
average.path.length(g.er)
diameter(g.er)

#randomGraph#
degs <- c(2,2,2,2,3,3,3,3)
g1 <- degree.sequence.game(degs, method="vl")
g2 <- degree.sequence.game(degs, method="vl")
plot(g1, vertex.label=NA)
plot(g2, vertex.label=NA)
graph.isomorphic(g1, g2)
data(yeast)
degs <- degree(yeast)
fake.yeast <- degree.sequence.game(degs,method=c("vl"))
all(degree(yeast) == degree(fake.yeast))
diameter(yeast)
diameter(fake.yeast)

#smallWorld#
g.ws <- watts.strogatz.game(1, 25, 5, 0.05)
plot(g.ws, layout=layout.circle, vertex.label=NA)
g.lat100 <- watts.strogatz.game(1, 100, 5, 0)
transitivity(g.lat100)
diameter(g.lat100)
average.path.length(g.lat100)

g.ws100 <- watts.strogatz.game(1, 100, 5, 0.05)
diameter(g.ws100)
average.path.length(g.ws100)
transitivity(g.ws100)

steps <- seq(-4, -0.5, 0.1)
len <- length(steps)
cl <- numeric(len)
apl <- numeric(len)
ntrials <- 100
for (i in (1:len)) {
  cltemp <- numeric(ntrials)
  apltemp <- numeric(ntrials)
  for (j in (1:ntrials)) {
    g <- watts.strogatz.game(1, 1000, 10, 10^steps[i])
    cltemp[j] <- transitivity(g)
    apltemp[j] <- average.path.length(g)}
cl[i] <- mean(cltemp)
apl[i] <- mean(apltemp

#pref.Attachment#
set.seed(42)
g.ba <- barabasi.game(100, directed=FALSE)
plot(g.ba, layout=layout.circle, vertex.label=NA)
hist(degree(g.ba), col="lightblue", xlab="Degree", ylab="Frequency", main="")
summary(degree(g.ba))
average.path.length(g.ba)
diameter(g.ba)

#TOPOLOGY INFERENCE#
library(sand)
nv <- vcount(fblog)
ncn <- numeric()
A <- get.adjacency(fblog)
for(i in (1:(nv-1))){
   ni <- neighborhood(fblog, 1, i)
   nj <- neighborhood(fblog, 1, (i+1):nv)
   nbhd.ij <- mapply(intersect, ni, nj, SIMPLIFY=FALSE)
   temp <- unlist(lapply(nbhd.ij, length)) -2* A[i, (i+1):nv]
  ncn <- c(ncn, temp)}

library(vioplot)
Avec <- A[lower.tri(A)]
vioplot(ncn[Avec==0], ncn[Avec==1],
            names=c("No Edge", "Edge"))
title(ylab="Number of Common Neighbors")

library(ROCR)
pred <- prediction(ncn, Avec)
perf <- performance(pred, "auc")
slot(perf, "y.values")

# associations Network#
rm(list=ls())
data(Ecoli.data)
ls()
heatmap(scale(Ecoli.expr), Rowv=NA)
library(igraph)
g.regDB <- graph.adjacency(regDB.adj, "undirected")
summary(g.regDB)
plot(g.regDB, vertex.size=3, vertex.label=NA)

# tomographic Inference
data(sandwichprobe)
delaydata[1:5,]
host.locs
meanmat <- with(delaydata, by(DelayDiff,list(SmallPktDest, BigPktDest), mean))
image(log(meanmat + t(meanmat)), xaxt="n", yaxt="n",col=heat.colors(16))
mtext(side=1, text=host.locs,at=seq(0.0,1.0,0.11), las=3)
mtext(side=2, text=host.locs,at=seq(0.0,1.0,0.11), las=1)

# PREDICTION#
# nearest Neighbor
set.seed(42)
library(sand)
data(ppi.CC)
summary(ppi.CC)
V(ppi.CC)$ICSC[1:10]
V(ppi.CC)[ICSC == 1]$color <- "yellow"
V(ppi.CC)[ICSC == 0]$color <- "blue"
plot(ppi.CC, vertex.size=5, vertex.label=NA)

#MarkovRandomFields
library(ngspatial)
X <- V(ppi.CC.gc)$ICSC
A <- get.adjacency(ppi.CC.gc, sparse=FALSE)
formula1 <- X ~ 1
gene.motifs <- cbind(V(ppi.CC.gc)$IPR000198,
                       V(ppi.CC.gc)$IPR000403,
                       V(ppi.CC.gc)$IPR001806,
                       V(ppi.CC.gc)$IPR001849,
                       V(ppi.CC.gc)$IPR002041,
                       V(ppi.CC.gc)$IPR003527)
formula2 <- X ~ gene.motifs

# epidemic Process
gl <- list()
gl$ba <- barabasi.game(250, m=5, directed=FALSE)
gl$er <- erdos.renyi.game(250, 1250, type=c("gnm"))
gl$ws <- watts.strogatz.game(1, 100, 12, 0.01)
beta <- 0.5
gamma <- 1
ntrials <- 100
sim <- lapply(gl, sir, beta=beta, gamma=gamma,no.sim=ntrials)
plot(sim$er)
plot(sim$ba, color="palegoldenrod",median_color="gold", quantile_color="gold")
plot(sim$ws, color="pink", median_color="red",quantile_color="red")

x.max <- max(sapply(sapply(sim, time_bins), max))
y.max <- 1.05 * max(sapply(sapply(sim, function(x)
median(x)[["NI"]]), max, na.rm=TRUE))
plot(time_bins(sim$er), median(sim$er)[["NI"]],
         type="l", lwd=2, col="blue", xlim=c(0, x.max),
         ylim=c(0, y.max), xlab="Time",
         ylab=expression(N[I](t)))
lines(time_bins(sim$ba), median(sim$ba)[["NI"]],lwd=2, col="gold")
lines(time_bins(sim$ws), median(sim$ws)[["NI"]],lwd=2, col="red")
legend("topright", c("ER", "BA", "WS"),col=c("blue", "gold", "red"), lty=1)

# DATASET DI RELAZIONI LAVORATIVE
library(sand)
g.lazega <- graph.data.frame(elist.lazega, directed = "FALSE", vertices =v.attr.lazega)
g.lazega$name <- "Lazega Lawyers"
vcount(g.lazega)
ecount(g.lazega)   #conteggio vertici e links

library(igraph)
library(netrankr)
library(magrittr)
library(ggplot2)
data("florentine_m")
plot(florentine_m,vertex.label.cex=V(florentine_m)$wealth*0.01,vertex.label.color="black",vertex.color="white",vertex.frame.color="gray")
#Delete Pucci family (isolated)
florentine_m <- delete_vertices(florentine_m,which(degree(florentine_m)==0))
par(mar=c(1,1,1,1),mfrow=c(1,2))
plot(florentine_m,vertex.label.cex=V(florentine_m)$wealth*0.02,vertex.label.color="black",vertex.color="white",vertex.frame.color="gray",main="Nome prop. alla ricchezza")
risorse <- data.frame(ricchezza=V(florentine_m)$wealth,degree = degree(florentine_m),betweenness = betweenness(florentine_m),
                      closeness = closeness(florentine_m),eigenvector = eigen_centrality(florentine_m)$vector,subgraph = subgraph_centrality(florentine_m))
risorse[order(risorse$eigenvector,decreasing = T),]
plot(florentine_m,vertex.label.cex=eigen_centrality(florentine_m)$vector*2,vertex.label.color="black",vertex.color="white",vertex.frame.color="gray",main="Nome prop. alla centralità")

load("/Users/utente/Documents/prova r pkg/lucidi del corso/starwars.RData")
V(sw_men_g)$size=degree(sw_men_g)/4+1
V(sw_men_g)$label.cex <- (degree(sw_men_g)+1)/80
par(mar=c(0,0,2,0))
plot(sw_men_g,vertex.label.color="black",vertex.color="yellow",edge.color="black",vertex.frame.color="red",main="Nome prop. alla centralità",layout = layout.kamada.kawai)
V(sw_int_g)$size=degree(sw_int_g)/4+1
V(sw_int_g)$label.cex <- (degree(sw_int_g)+1)/80
par(mar=c(2,2,2,2))
plot(sw_int_g,vertex.label.color="black",vertex.color="yellow",edge.color="black",vertex.frame.color="red",main="Nome prop. alla centralità",layout = layout.kamada.kawai)
V(sw_intac_g)$size=degree(sw_intac_g)/4+1
V(sw_intac_g)$label.cex <- (degree(sw_intac_g)+1)/80
par(mar=c(2,2,2,2))
plot(sw_intac_g,vertex.label.color="black",vertex.color="yellow",edge.color="black",vertex.frame.color="red",main="Nome prop. alla centralità",layout = layout.kamada.kawai)
clusw <- cluster_fast_greedy(as.undirected(sw_men_g))
plot(clusw, sw_men_g,layout = layout.kamada.kawai)
centr <- data.frame(degree = degree(sw_men_g),betweenness = betweenness(sw_men_g),
                    closeness = closeness(sw_men_g),eigenvector = eigen_centrality(sw_men_g)$vector,subgraph = subgraph_centrality(sw_men_g))
centr <- centr[order(-centr$eigenvector),]

load("/Users/utente/Documents/prova r pkg/lucidi del corso/rinascimento.RData")
V(ren)$color=as.numeric(re_nodes$category)
V(ren)$size=degree(ren)+1
V(ren)$label.cex <- (degree(ren)+1)/20
par(mar=c(0,0,0,0))
plot(ren,layout=layout.graphopt)
ren2 <- delete.vertices(simplify(ren), degree(ren)==0)
ren3 <- decompose.graph(ren2)[[1]]
par(mar=c(0,0,0,0))
plot(ren3,layout=layout.graphopt)
clush <- cluster_edge_betweenness(ren3) 
dendPlot(clush, mode="hclust")
plot(clush, ren3)
migliore <- data.frame(degree = degree(ren3),betweenness = betweenness(ren3),
                       closeness = closeness(ren3),eigenvector = eigen_centrality(ren3)$vector,subgraph = subgraph_centrality(ren3))
migliore <- migliore[order(-migliore$eigenvector),]

load("/Users/utente/Documents/prova r pkg/lucidi del corso/marvel.RData")
heroes <- graph_from_edgelist(as.matrix(heroes_edges), directed = F)
heroes <- delete.vertices(simplify(heroes), degree(heroes) < 500)
heroes <- decompose.graph(heroes)[[1]]
V(heroes)$size      <- (degree(heroes)+1)/20
V(heroes)$label.cex <- (degree(heroes)+1)/500
par(mar=c(0,0,0,0))
plot(heroes,layout = layout.kamada.kawai)
clusw <- cluster_fast_greedy(as.undirected(heroes))
plot(clusw, heroes,layout = layout.kamada.kawai)
centr <- data.frame(degree = degree(heroes),betweenness = betweenness(heroes),
                    closeness = closeness(heroes),eigenvector = eigen_centrality(heroes)$vector,subgraph = subgraph_centrality(heroes))
centr <- centr[order(-centr$eigenvector),]

load("/Users/utente/Documents/prova r pkg/lucidi del corso/pendolarismo.RData")
datipend <- datipend[datipend$tipo == "S",]
datipend <- datipend[datipend$provres <= 69 & datipend$provres >= 66 & datipend$provdes <= 69 & datipend$provdes >= 66,]
datipend <- datipend[datipend$motivo == 2,]
datipend$codcomres <- datipend$provres * 1000 + datipend$comres
datipend$codcomdes <- datipend$provdes * 1000 + datipend$comdes
sumpend <- aggregate(datipend$stiflusso,by=list(codcomres = datipend$codcomres,codcomdes = datipend$codcomdes),sum,na.rm = T)
library(maptools)
comabr <- readShapePoly("/Users/utente/Desktop/Dati Archivio/Limiti Amministrativi/comuni2008/com2008_s.shp")
comabr <- subset(comabr,COD_REG == 13)
library(flows)
myflows <- prepflows(mat = sumpend, i = "codcomres", j = "codcomdes", fij = "x")
mystats <- statmat(mat = myflows, output = "all", verbose = TRUE)
diag(myflows) <- 0
flowSel1 <- domflows(mat = myflows, w = colSums(myflows), k = 1)
flowSel2 <- firstflows(mat = myflows, method = "nfirst", ties.method = "first",k = 1)
flowSel <- myflows * flowSel1 * flowSel2
inflows <- data.frame(id = colnames(myflows), w = colSums(myflows))
opar <- par(mar = c(0,0,1,0))
sp::plot(comabr, col = "#cceae7", border = NA)
plotMapDomFlows(mat = flowSel, spdf = comabr, spdfid = "PRO_COM", w = inflows, wid = "id",
                wvar = "w", wcex = 0.05, add = TRUE,
                legend.flows.pos = "bottomleft",
                legend.flows.title = "Nb. of Travel to Work")
title("Flussi Dominanti - ISTAT, 2011")
par(opar)

load("/Users/utente/Documents/prova r pkg/lucidi del corso/interntrade.RData")
library(ITNr)
ITNplotset(wineITN)
ITN_make_plot(wineITN,TRUE,TRUE)
ITNdegdist(wineITN)
ITNhistdegdist(wineITN)
par(mfrow=c(1,1),mar=c(1,1,1,1))
region_circle_plot(wineITN)
ITN_map_plot(wineITN)
CLUwine<-ITNcluster(wineITN)
CENTwine<-ITNcentrality(wineITN)
cbind(CLUwine$cluster.fast.greedy.mem,CENTwine[,-c(1,2:5)])

ITNplotset(pomoITN)
ITN_make_plot(pomoITN,TRUE,TRUE)
ITNdegdist(pomoITN)
ITNhistdegdist(pomoITN)
par(mfrow=c(1,1))
region_circle_plot(pomoITN)
ITN_map_plot(pomoITN)
CLUpomo<-ITNcluster(pomoITN)
CENTpomo<-ITNcentrality(pomoITN)

ITNplotset(cheeseITN)
ITN_make_plot(cheeseITN,TRUE,TRUE)
ITNdegdist(cheeseITN)
ITNhistdegdist(cheeseITN)
par(mfrow=c(1,1))
region_circle_plot(cheeseITN)
ITN_map_plot(cheeseITN)
CLUcheese<-ITNcluster(cheeseITN)
CENTcheese<-ITNcentrality(cheeseITN)
ITN_map_plot(cheeseITN)

library(iotables)
load("/Users/utente/Documents/prova r pkg/lucidi del corso/TavoleIO.RData")
na <- io_tables %>% dplyr::filter ( geo %in% "IT") %>% dplyr::filter ( year %in% 2010) %>% dplyr::filter ( unit %in% "MIO_EUR") %>%
  dplyr::filter ( stk_flow %in% "DOM")
an <- as.data.frame(na$data)
df <- as.data.frame(ITtable)
cc <- t(t(as.matrix(ITtable[1:65,2:66]))/as.vector(as.matrix(ITtable[75,2:66])))
inp <- input_coefficient_matrix_create(data_table=ITtable) 
leo <- leontieff_inverse_create(inp)
com <- input_indicator_create(ITtable, 'compensation_employees')
ind <- rowSums(as.data.frame(leo[,2:66]))
dir <- rowSums(as.data.frame(inp[,2:66]))
plot(dir,ind,cex=1,pch=19,xlab="coefficienti diretti 2010",ylab="coefficienti indiretti 2010",cex.lab=2)
names(ind) <- colnames(leo[,2:66])
names(dir) <- colnames(leo[,2:66])
rcoe <- lm(ind ~ dir)
abline(rcoe,lwd=2)
cbind(dir,ind)[order(-ind),]
#matr <- as.matrix(leo[,2:66])
#matr <- solve(I(65)-as.matrix(inp[1:65,2:66]))
com <- input_indicator_create( data_table = ITtable, input_vector = c("gva"),digits = 4, indicator_names = c("GVA indicator"))
ind2 <- indirect_effects_create(input_requirements = com,inverse = leo)
cbind(dir,ind,t(ind2[2:length(ind2)]))[order(-t(ind2[2:length(ind2)])),]

load("/Users/utente/Documents/prova r pkg/lucidi del corso/movies.RData")
library(cluster)
revfilm <- revfilm[!is.na(revfilm$budget),]
revfilm <- revfilm[revfilm$budget > 50000000,]
regfilm <- lm(gross ~ budget + score + year + votes + runtime,data=revfilm)
disf <- as.matrix(1-daisy(revfilm[,c(3,4,5,12,14)],metric = "gower"))
disf[disf < 0.2] <- 0
rownames(disf) <- colnames(disf) <- revfilm$name
library(igraph)
grfilm  <- graph_from_adjacency_matrix(disf, mode = "max", weighted = T,diag = F, add.rownames = T)
clufilm <- fastgreedy.community(grfilm)
centr <- data.frame(degree = degree(grfilm),betweenness = betweenness(grfilm),
                    closeness = closeness(grfilm),eigenvector = eigen_centrality(grfilm)$vector)
datifilm <- cbind(revfilm,centr)
kk <- datifilm[order(datifilm$eigenvector,decreasing = T),]
regfilm <- lm(gross ~ budget + score + year + votes + runtime+degree+betweenness+closeness+eigenvector,data=datifilm)
g1 <- as.matrix(as_adjacency_matrix(grfilm))
del <- which(rowSums(g1)==0)
g1 <- g1[-del,-del];datifilm <- datifilm[-del,]
library(spdep) 
nb <- mat2listw(g1,style="W")
mor <- moran(datifilm$gross, nb,length(nb),Szero(nb))
sar <- lagsarlm(gross ~ budget + score + year + votes + runtime+degree+betweenness+closeness+eigenvector, Durbin=T,data=datifilm, nb,tol.solve = 1e-100)
impacts(sar, listw=nb)
sem <- errorsarlm(gross ~ budget + score + year + votes + runtime+degree+betweenness+closeness+eigenvector, data=datifilm, nb,tol.solve = 1e-100)
