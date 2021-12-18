rm(list = ls())

#  1) Clean all data from enivornment

# Unzip the network.csv.zip file, then load the Dolphin Social Network*

#' *D. Lusseau et al., "The bottlenose dolphin community of Doubtful Sound features a large proportion of long-lasting associations." 
#' Behavioral Ecology and Sociobiology 54(4), 396-405 (2003)., https://doi.org/10.1007/s00265-003-0651-y [@sci-hub]

# 1.2) load the file "edges.csv" as dataframe and then as graph

#  2) Save the graph as is, in edgelist format

g1 <- read.csv('data/graph/dolphin/edges.csv')
library(igraph)

g1 <- graph_from_data_frame(g1, directed = F)
class(g1)
plot(g1)

g1.nodes <- read.csv('data/graph/dolphin/nodes.csv')

g1 <- graph_from_data_frame(g1, directed = F,vertices = g1.nodes)
class(g1)
plot(g1, edge.size=0.00002)

write_graph(g1, 'data/graph/dolphin/dolphin2.gml', format = 'gml')

g2 <- read_graph('data/graph/dolphin/dolphin2.gml',format = 'gml')
plot(g2)

#  3) Load the florentine families graph and assign as g1
#     You need the library netrank
library('netrankr')
data("florentine_m")
g1 <- (florentine_m)

#write_graph(g1,'data/graph/florentinefamilies.gml', format = 'gml')

#   4) Get all simple information from the graph, number of vertices and edges
str(g1)
vcount(g1)
ecount(g1)

gsize(g1)

#   5) Check if the graph is connected

#    connected means that any two vertices are reachable from each other with a 
#    multihop path i.e. not isolated vertices

is.connected(g1)

plot(g1)
#   6) delete Florentine families with a Null degree and check if is connected
g1.conn <- delete_vertices(g1, which(degree(g1)==0))

g1

is.connected(g1.conn)
plot(g1.conn)

#   7) plot the simple graph of florentine families

plot(g1)

#   7.1) plot the simple graph of florentine families, 
#   plot size of vertices by wealth of family, then color the label of vertex in black
#   then color the vertex in white (note that wealth is 1)

plot(g1, vertex.size= degree(g1)*3)
plot(g1, vertex.size= V(g1)$wealth*0.4,
     vertex.color='red')




#   8) plot with a different layout
help('layout_')

lay1 <- layout_(g1, as_tree())
lay2 <- layout_(g1, in_circle())

plot(g1,
     vertex.color='red', layout=lay1)
plot(g1,
     vertex.color='red', layout=lay2)
#    9)Get the Diameter of a graph
#    The diameter of a graph is the length of the longest geodesic path. 

diameter(g1, directed = F)
diam <- get_diameter(g1, directed=F)
diam

plot(g1)
library(igraph)
#    10) Get the degree of the graph and plot the histogram the value of the degree, 
#     plot also the degree cumulative deistribution.
deg <- degree(g1, mode = 'all')
hist(deg, xlim=c(0,16))

V(g1)$degrees <- deg

deg.dist <- degree_distribution(g1, cumulative=T, mode="all")
plot( x=0:max(deg), y=1-deg.dist, pch=19, cex=1.2, col="orange", xlab="Degree", ylab="Cumulative Frequency")
#    12) Calculate the average path length of the graph and all possible distances

mean_distance(g1, directed=F)

distances(g1)

#    13) Calculate some basic centrality measures of the graph




#    14) Calculate Eigenvector centrality measure and plot it in a proper way with proper color
#        set the maximum four digits

options(digits =4, scipen = 99)

eigenvec <- eigen_centrality(g1)$vector
sort(eigenvec, decreasing = T)

bins <- unique(quantile(eigenvec, seq(0,1, length.out=35)))
vals <- cut(eigenvec, bins, labels=F, include.lowest = T)


colr <-  heat.colors(length(bins))
colorsVals <- rev(colr)[vals]

V(g1)$color <- colorsVals

set.seed(1)

plot.igraph(g1, vertex.size=V(g1)$deg, 
            vertex.label.cex=V(g1)$wealth*0.011, 
            vertex.label.color="black",
            vertex.frame.color="gray")

subgraph = subgraph_centrality(g1)

#    15) Calculate Betweenness centrality measure, find its correlation with the eigenvector centrality
#        plot it properly

betw <- betweenness(g1)
plot(g1)

sort(betw,decreasing=F)[1:10]

cor(betw,eigenvec)


bins <- unique(quantile(betw, seq(0,1,length.out=30)))
vals <- cut(betw, bins, labels=FALSE, include.lowest=TRUE)

colorVals <- rev(terrain.colors(length(bins)))[vals]
V(g1)$color <- colorVals
set.seed(1)
plot.igraph(g1, vertex.size=V(g1)$wealth/10, 
            vertex.label.color="black")

#    16) Calculate the Edge Betweenness centrality measure it is basically a clustering measure and plot it

eb <- edge.betweenness.community(g1)

sort(table(eb$membership))

V(g1)$color <- rep('white',length(eb$membership))

kpt <- names(sizes(eb))[(sizes(eb))>3]

matchver <- match(eb$membership, kpt)

colorVals <- rainbow(5)[matchver[!is.na(matchver)]]

V(g1)$color[!is.na(matchver)] <- colorVals

plot.igraph(g1)
