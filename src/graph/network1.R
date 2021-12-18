remove(list = ls())
library(igraph)
library(ggplot2)

#https://icon.colorado.edu/#!/networks

#https://snap.stanford.edu/data/

#http://konect.cc/

set.seed(1)

#read_graph
g01 <- read.csv('data/graph/network.csv/edges.csv')
g01.nodes <- read.csv('data/graph/nodes.csv')
g02 <- read.delim('data/graph/russiantrade/russiantrade/russiantrade_edges.txt',sep  ='\t')



g
#' prop_name, value
#'name,dolphins
#'description,"An undirected social network of frequent associations observed among 62 dolphins 
#'(Tursiops) in a community living off Doubtful Sound, New Zealand, from 1994-2001."

g11 <- read_graph('data/graph/power/power.gml', format='gml')

g1 <- graph_from_data_frame(g02, directed = T,vertices = g01.nodes)
g1 <- graph_from_data_frame(g02, directed=F)
plot(g1)




g2 <- graph_from_data_frame(g02, directed = T)
plot(g2)



# Diameter----
# ==========
diameter(g2, directed=F)
diam <- get_diameter(g2, directed=F)
diam


# Node degree
# ==========
deg <- degree(g2, mode="all")
plot(g2, vertex.size=deg)


# Node degree
# ==========
degreeg2 <- degree(g2, mode = 'out')
hist(degreeg2)


deg.df <- as.data.frame(degreeg2)
deg.df$name <- row.names(deg.df)

ggplot(deg.df,aes(degreeg2))+geom_histogram(binwidth = 1, bins = 10)

hist(deg, breaks=1:vcount(g2)-1, main="Histogram of node degree")


# Degree distribution
# ==========
deg.dist <- degree_distribution(g2, cumulative=T, mode="all")
plot( x=0:max(deg), y=1-deg.dist, pch=19, cex=1.2, col="orange", xlab="Degree", ylab="Cumulative Frequency")


# Distances and paths
# ==========
mean_distance(g2, directed=F)


# Distances and paths
# ==========
distances(g2)


# Graph Centrality
# ==========
eigenCent <- evcent(g2)$vector
sort(eigenCent,decreasing=TRUE)[1:10]



# Graph Centrality
# ==========
options(scipen=999)

# calculating 30 values (bins) using the quantile function
# in each bin there is the same number (frequency) of scores
bins <- unique(quantile(eigenCent, seq(0,1,length.out=30)))


# Graph Centrality
# ==========
bins


# Graph Centrality
# ==========
# cut identifies the corresponding bin for each score
vals <- cut(eigenCent, bins, labels=FALSE, include.lowest=TRUE)
length(vals); head(vals)
# heat.colors creates a vector of n contiguous colors
my_col = heat.colors(length(bins))
head(my_col)


# Graph Centrality
# ==========
# now we assign the heatest colors (more red) to the highest scores
colorVals <- rev(my_col)[vals] #sort of subsetting

V(g2)$color <- colorVals


# Graph Centrality
# ==========
plot.igraph(g2, 
            vertex.label=NA, vertex.size=5,
            edge.arrow.size=0.1)


# Graph Centrality
# ==========
betweenCent <- betweenness(g2)
sort(betweenCent,decreasing=TRUE)[1:10]
cor(betweenCent,eigenCent)


# Graph Centrality
# ==========
bins <- unique(quantile(betweenCent, seq(0,1,length.out=30)))
vals <- cut(betweenCent, bins, labels=FALSE, include.lowest=TRUE)
colorVals <- rev(heat.colors(length(bins)))[vals]
V(g2)$color <- colorVals


# Graph Centrality
# ==========
plot.igraph(g2, vertex.label=NA, vertex.size=5
          ,edge.arrow.size=0.1)


# Graph Communities
# ==========
w <- edge.betweenness.community(g2)
sort(table(w$membership))


# Graph Communities
# ==========
sort(table(w$membership))


# Graph Communities
# ==========
V(g2)$color <- rep("white", length(w$membership))
keepTheseCommunities <- names(sizes(w))[sizes(w) > 3]
matchIndex <- match(w$membership, keepTheseCommunities) # like %in%
colorVals <- rainbow(5)[matchIndex[!is.na(matchIndex)]]
V(g2)$color[!is.na(matchIndex)] <- colorVals


# Graph Communities
# ==========
plot.igraph(g2, vertex.label=NA, vertex.size=5,
            edge.arrow.size=0.1)



