# R code snippets from slides
# Slide file: -CM0579 Network Analysis with R/11-CM0579


# A Basic Graph
# ==========
library(igraph)
g <- graph.empty(directed=TRUE)


# A Basic Graph
# ==========
g <- g + vertex("Elizabeth II") 
g <- g + vertex("Philip")
g <- g + vertex("Charles")
g <- g + vertex("Diana")
g <- g + vertex("William")
g <- g + vertex("Harry")
g <- g + vertex("Catherine")
g <- g + vertex("George")


# A Basic Graph
# ==========
g <- g + edges("Elizabeth II", "Charles")
g <- g + edges("Philip", "Charles")
g <- g + edges("Charles", "William")
g <- g + edges("Diana", "William")
g <- g + edges("Charles", "Harry")
g <- g + edges("Diana", "Harry")
g <- g + edges("William", "George")
g <- g + edges("Catherine", "George")


# A Basic Graph
# ==========
g


# A Basic Graph
# ==========
plot.igraph(g)


# Create Networks
# ==========
g1 <- graph( edges=c(1,2, 2,3, 3,1), n=3, directed=F); plot(g1)


# Create Networks
# ==========
g2 <- graph( edges=c(1,2, 2,3, 3,1), n=10)
plot(g2) 


# Create Networks
# ==========
g1
g2


# Create Networks
# ==========
g3 <- graph( c("John", "Jim", "Jim", "Jill", "Jill", "John")) # named vertices
plot(g3) 


# Create Networks
# ==========
g3

g4 <- graph( c("John", "Jim", "Jim", "Jack", "John", "John"), 
             isolates=c("Jesse", "Janis", "Jennifer", "Justin")
            ) 


# Create Networks
# ==========
plot(g4, edge.arrow.size=.5, vertex.color="gold", vertex.size=15, vertex.frame.color="gray", vertex.label.color="black", vertex.label.cex=0.8, vertex.label.dist=2, edge.curved=0.2)


# Create Networks
# ==========
plot(graph_from_literal(a---b, b---c)) # the number of dashes doesn't matter


# Create Networks
# ==========
plot(graph_from_literal(a--+b, b+--c))


# Create Networks
# ==========
plot(graph_from_literal(a+-+b, b+-+c)) 


# Create Networks
# ==========
plot(graph_from_literal(a:b:c---c:d:e))


# Create Networks
# ==========
gl <- graph_from_literal(a-b-c-d-e-f, a-g-h-b, h-e:f:i, j)
plot(gl)


# Edge, vertex, and network attributes
# ==========
plot(g4, edge.arrow.size=.5, vertex.color="gold", vertex.size=15, vertex.frame.color="gray", vertex.label.color="black", vertex.label.cex=0.8, vertex.label.dist=2, edge.curved=0.2)


# Edge, vertex, and network attributes
# ==========
E(g4) # Edges of the object
V(g4) # Vertices of the object


# Edge, vertex, and network attributes
# ==========
g4[]


# Edge, vertex, and network attributes
# ==========
V(g4)$name # automatically generated when we created the network.


# Edge, vertex, and network attributes
# ==========
V(g4)$gender <- c("male", "male", "male", "male", "female", "female", "male")

E(g4)$type <- "email" # Edge attribute, assign "email" to all edges

E(g4)$weight <- 10    # Edge weight, setting all existing edges to 10


# Edge, vertex, and network attributes
# ==========
edge_attr(g4)


# Edge, vertex, and network attributes
# ==========
vertex_attr(g4)


# Edge, vertex, and network attributes
# ==========
g4 <- set_graph_attr(g4, "name", "Email Network")
graph_attr_names(g4)
g4 <- set_graph_attr(g4, "something", "A thing")
graph_attr_names(g4)


# Edge, vertex, and network attributes
# ==========
graph_attr(g4, "name")
graph_attr(g4)


# Edge, vertex, and network attributes
# ==========
g4 <- delete_graph_attr(g4, "something")
graph_attr(g4)


# Edge, vertex, and network attributes
# ==========
plot(g4, edge.arrow.size=.5, vertex.label.color="black", vertex.label.dist=1.5, vertex.color=c( "pink", "skyblue")[1+(V(g4)$gender=="male")] )


# Edge, vertex, and network attributes
# ==========
g4s <- simplify( g4, remove.loops = T, 
                edge.attr.comb=c(weight="sum", type="ignore") )
plot(g4s, vertex.label.dist=1.5)


# Edge, vertex, and network attributes
# ==========
g4s


# Edge, vertex, and network attributes
# ==========
g4s


# Specific graphs and graph models
# ==========
eg <- make_empty_graph(40)
plot(eg, vertex.size=10, vertex.label=NA)


# Specific graphs and graph models
# ==========
fg <- make_full_graph(40)
plot(fg, vertex.size=10, vertex.label=NA)


# Specific graphs and graph models
# ==========
tr <- make_tree(40, children = 3, mode = "undirected")
plot(tr, vertex.size=10, vertex.label=NA) 


# Specific graphs and graph models
# ==========
st <- make_star(40)
plot(st, vertex.size=10, vertex.label=NA) 


# Specific graphs
# ==========
rn <- make_ring(40)
plot(rn, vertex.size=10, vertex.label=NA)


# Specific graphs
# ==========
zach <- graph("Zachary") # the Zachary Karate Club
plot(zach, vertex.size=10, vertex.label=NA)


# Diameter
# ==========
diameter(zach, directed=F)
diam <- get_diameter(zach, directed=F)
diam


# Node degree
# ==========
deg <- degree(zach, mode="all")
plot(zach, vertex.size=deg*3)


# Node degree
# ==========
hist(deg, breaks=1:vcount(zach)-1, main="Histogram of node degree")


# Degree distribution
# ==========
deg.dist <- degree_distribution(zach, cumulative=T, mode="all")
plot( x=0:max(deg), y=1-deg.dist, pch=19, cex=1.2, col="orange", xlab="Degree", ylab="Cumulative Frequency")


# Distances and paths
# ==========
mean_distance(zach, directed=F)


# Distances and paths
# ==========
distances(zach)

