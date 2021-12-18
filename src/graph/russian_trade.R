remove(list = ls())
library(igraph)

g02 <- read.delim('data/graph/russiantrade/russiantrade/russiantrade_edges.txt',sep  ='\t')
g03 <- read.delim('data/graph/marvel.csv',sep  =';')

g1 <- graph_from_data_frame(g02,directed = F)
g2 <- graph_from_data_frame(g03,directed = F)

str(g1, v=TRUE)
#get the vertex and edges sequences
V(g1)
E(g1)
vcount(g1)
ecount(g1)
### show the whealth attributes for each vertex

#check if the graph is connected
#connected means that any two vertices are reachable from each other with a multi-hop path
#i.e. not isolated vertices

is.connected(g1)




#delete Florentine families with a Null degree
g1.1 <- delete_vertices(g1,which(degree(g1)==0))

is.connected(g1.1)




#plot the simplegraph of florentine families, plot size of vertices by degree of vertex * 6
plot(g1,vertex.size=degree(g1)*6)
plot(g2,vertex.size=degree(g1)*6)

#plot the simplegraph by degree of vertex * 6
plot.igraph(g1,
            vertex.size=degree(g1)*6,
     vertex.label.color="black",
     vertex.color="white",
     vertex.frame.color="gray")


#plot with a different layout
help('layout_')

ffl <- layout_(g1, layout = with_kk())
ff2 <- layout_(g1, layout = as_tree())

plot(g1,vertex.size=degree(g1)*6, layout=ffl)
plot(g1,vertex.size=degree(g1)*6, layout=ff2)



# Get the Diameter of a graph
#The diameter of a graph is the length of the longest geodesic. 
diameter(g1, directed=F)
diam <- get_diameter(g1, directed=F)
diam



# Get the degree of the graph and plot the graph based the value of the degree, then plot the histogram
# ==========
deg <- degree(g1, mode="all")
plot.igraph(g1,
            vertex.size=deg^2, 
            vertex.label.color="black",
            vertex.color="red",
            vertex.frame.color="gray")


hist(deg, breaks=1:vcount(g1)-1, main="Histogram of node degree")


# Degree distribution
#rember that degree of a vertex is its most basic structural property, the number of its adjacent edges.

deg.dist <- degree_distribution(g1, cumulative=T, mode="all")
plot( x=0:max(deg), y=1-deg.dist, pch=19, cex=1.2, col="orange", xlab="Degree", ylab="Cumulative Frequency")
#remember that they are cumulate


# Calculate the average path length of the graph and all possible distances

mean_distance(g1, directed=F)

distances(g1)


#calculate some basic centrality measures of the graph


##Calculate Eigenvector centrality measure and plot it in a proper way with proper color
options(digits=4)
eigencen = eigen_centrality(g1)$vector
sort(eigencen, decreasing = T)

bins <- unique(quantile(eigencen, seq(0,1,length.out=30)))
# cut identifies the corresponding bin for each score
vals <- cut(eigencen, bins, labels=FALSE, include.lowest=TRUE)
length(vals); head(vals)

#then we will assignt the color of each bin to a variable
my_col = heat.colors(length(bins))
head(my_col)
colorVals <- rev(my_col)[vals]

V(g1)$color <- colorVals
set.seed(1)
plot.igraph(g1, vertex.size=5, 
            vertex.label.cex=V(g1)$wealth*0.011, 
            vertex.label.color="black",
            vertex.frame.color="gray")

subgraph = subgraph_centrality(g1)

#calculate betweenees centrality measure, find its correlation with the eigenvector centrality
#plot it properly
betweenness = betweenness(g1)

sort(betweenness,decreasing=TRUE)[1:10]

cor(betweenness,eigencen)


bins <- unique(quantile(betweenness, seq(0,1,length.out=30)))
vals <- cut(betweenness, bins, labels=FALSE, include.lowest=TRUE)

colorVals <- rev(terrain.colors(length(bins)))[vals]
V(g1)$color <- colorVals
set.seed(1)
plot.igraph(g1, vertex.size=V(g1)$wealth/10, 
            vertex.label.cex=V(g1)$wealth*0.011, 
            vertex.label.color="black")




# Calculate the Edge betwenees centrality measure it is basically a clustering measure and plot it
# ==========
w <- edge.betweenness.community(g1)
sort(table(w$membership))



V(g1)$color <- rep("white", length(w$membership))
keepTheseCommunities <- names(sizes(w))[sizes(w) > 3]
matchIndex <- match(w$membership, keepTheseCommunities) # like %in%
colorVals <- rainbow(5)[matchIndex[!is.na(matchIndex)]]
V(g1)$color[!is.na(matchIndex)] <- colorVals


plot.igraph(g1, vertex.size=5)





