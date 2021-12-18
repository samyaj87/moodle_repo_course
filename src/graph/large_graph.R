remove(list = ls())
library(igraph)
#https://networkrepository.com/cit-DBLP.php

data <- read.delim('data/graph/cit-DBLP/cit-DBLP.edges', sep = '')

g1 <- graph_from_data_frame(data)

V(g1)
E(g1)

g1 <- add_edges(g1, c(1,13))
is.connected(g1)

plot.igraph(g1, vertex.label=NA, edge.arrow.size=0.5,vertex.label.cex=0.8, 
            vertex.label.family="Helvetica")

g1comp <- components(g1)

avg_dist = distances(g1)
hist(avg_dist[ !is.infinite(avg_dist) & avg_dist <= 20 ], right = FALSE, breaks = 0:20, freq = FALSE, main="Estimated avg sp length for FB social graph", xlab="sp length", col="red")
abline(v = mean(avg_dist[ !is.infinite(avg_dist) & avg_dist <= 20 ]), col = "yellow", lw=3)
mean_dst <- mean(avg_dist[ !is.infinite(avg_dist)])

deg <- degree(g1, mode="all")

gc_index = which.max(g1comp$csize)
gc_indices = which(g1comp$membership == gc_index) 
gc_vertices = V(g1)[gc_indices]


gc_g1 = induced.subgraph(g1, gc_vertices)
length(V(g1))
length(V(gc_g1))
vcount((g1))
vcount((gc_g1))
is.connected(g1)
is.connected(gc_g1)

toyg_layout = layout_(gc_g1, as_tree()) # use the three algorithm
plot(gc_g1, layout = toyg_layout, vertex.label=NA)

max_degree <- max(degree(gc_g1))

#degree density function
d.g = degree(gc_g1)
dd = degree.distribution(gc_g1)
dd = dd[-1] 
d = 1:max(d.g)
ind <- (dd != 0)
     
plot(d[ind], dd[ind], log="xy", col="blue",
     xlab=c("Log-Degree"), ylab=c("Log-Intensity"),
     main="Log-Log Degree Density Function")


hist(degree(gc_g1), freq = FALSE, breaks = d, right = FALSE, col="blue", xlab=c("Degree"), ylab=c("Intensity"),xlim = c(1,60),
     main="Histogram of the Degree Density")




#' clustering
#' is the “global” transitivity, i.e., the overall ratio between triangles and triplets in the entire graph
transitivity(gc_g1)

#'transitivity(g,"local") is the “local” transitivity, i.e., the average of the clustering computed on each and every vertex of g.
#' When computing local transitivity, NaNs are produced in case no triplets are centered on a node. 
#' Zeros are produced in case no closed triangles exists, but there is at least one triplet. 
#' Therefore, we need to remove NaNs from the average (na.rm=TRUE).

mean(transitivity(gc_g1, "local"), na.rm = TRUE)


#Centrality Measure
#closeness(g,vs) computes the closeness index for the vertices provided in vs


closeness(gc_g1, vids = V(gc_g1)[1])


# Community detection
g.sub1 <- induced.subgraph(gc_g1, V(gc_g1)[which(degree(gc_g1) > 180)])
g.sub1.u <- as.undirected(g.sub1)
fg.comm <- fastgreedy.community(g.sub1.u)
dendPlot(fg.comm, mode="hclust")


plot(fg.comm, g.sub1.u)
