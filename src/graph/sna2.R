rm(list=ls(all=TRUE))
g<- read.graph("facebook.ncol", format="ncol", directed=TRUE)
g2<- read.graph("facebook.ncol", format="ncol", directed=FALSE)
g2
vvv<- V(g)
vvv$weight
eee<- E(g)
eee$weight
# vertex ed edge sono delle liste, se si prende il wedge del grafo si prende da head

testa<-head(E(g)$weight, n = 20)
coda<- tail(E(g)$weight, n=20)

# preso un vettore prende i primi 20 elementi, il corrispettivo e tail

aaa<-write.graph(g, "pappa.ncol", format=c("ncol"))
bbb<-write.graph(g, "pappa.pajek", format=c("pajek"))
df <- read.table("./facebook.ncol", col.names = c("V1", "V2", "weight"))
df
head (df)
gdf = graph_from_data_frame(df, directed = TRUE)
gdf
outdf = as_data_frame(gdf)
#### per leggere non dai file di testo ma passando dai dataframe

ccc<-write.table(outdf, "facebook2.ncol", col.names = FALSE, row.names = FALSE)
####

ddd<- read.table("./toy_graph.ncol")
eee=matrix(NA, nrow = length(ddd[,end]), ncol=3)
eee

####
tt<-read.table("toy_graph.ncol", col.names = c("V1", "V2", "weight"))

tdf<-graph_from_data_frame(tt, directed=TRUE)
outtdf=as_data_frame(tdf)
ttt<-str(tdf, v=TRUE, e=TRUE)
toy_g<-tdf
toy_g = toy_g + graph.formula(6+-+7, 5-+6)

#######
toy_df = read.table("./toy_graph.ncol", header = TRUE)
toy_g = graph_from_data_frame(toy_df, directed = TRUE)
str(toy_g, v=TRUE, e=TRUE)

toy_g = toy_g + graph.formula(6+-+7, 5-+6)
toy_g = delete_vertices(toy_g, c(6,7))
toy_g = toy_g + vertices(6,7)
toy_g = toy_g + edges(c(6,7), c(7,6), c(5,6))
str(toy_g, v=TRUE)
toy_g = toy_g - vertices(6,7)
toy_g1 = graph.formula(6+-+7)
toy_g = union(toy_g, toy_g1) + edges(c(5,6))
str(toy_g, v=TRUE)
###
#questo serve per appendere al grafo che abbiamo dei nuovi grafi direzionali
toy_g

outtdf1=as_data_frame(toy_g)

toy_g = toy_g + graph.formula(6+-+7, 7-+6, 5+-+6)

toy_g = delete_vertices(toy_g, c(6,7))
###questa elimina i vertici e tutti i giuochini
toy_g = toy_g + vertices(6,7)
### si appendono due vertici con operatore senza alcun edge
toy_g = toy_g + edges(c(6,7), c(7,6), c(5,6))
# questa aggiunge anche gli edge
str(toy_g, v=TRUE)
toy_g
outtdf1=as_data_frame(toy_g)

#####inserita il 5 maggio
###serve per dare pesi al grafo non pesato
weightSim <- function(g) {
  all_sims = similarity(g, V(g), mode = "all", method = "jaccard")
  #
  endpoints = ends(g, E(g), names = FALSE)
  #prendo l'd del nodo di partenza e del nodo di destinazione
  # restituendo un dataframe con nodidi partenza e di arrivo
  # e lo porto nel dataframe
  #out weights sono i pesi di arrivo
  out_weights = NULL
  for (i in 1:dim(endpoints)[1]) {
    V1 = endpoints[i,][1]
    V2 = endpoints[i,][2]
    out_weights[i] = all_sims[V1,V2]
  }
  return (out_weights)
}
#save the weights for future use
old_weights = E(toy_g)$weight
E(toy_g)$weight = weightSim(toy_g)
E(toy_g)$weight


###################


# a differenza di graph.formula si ha che con + vertex ed edges, lo riappende senza 
# anche otlre l'etichetta
toy_g = delete_vertices(toy_g, c('V1','V2'))
#####
toy_g = toy_g - vertices(6,7)
toy_g1 = graph.formula(6+-+7)
str(toy_g1, v=TRUE)
toy_g = union(toy_g, toy_g1) + edges(c(5,6))
### si crea un altro grafo e lo si appende al nodo toy_g
# per apesare i pesi si fa n l'egde list ?? una lista che prende un operatore
str(toy_g, e=TRUE)
#si vede come non ci siano dei pesi tra i grafi, per assegnarli
E(toy_g)[5%->%6]$weight = 0.03
E(toy_g)[7%->%6]$weight = 0.01
E(toy_g)[6%->%7]$weight = 0.02
E(toy_g)[10%->%9]$weight = 0.03
E(toy_g)[10%->%7]$weight = 0.03
E(toy_g)[9%->%10]$weight = 0.03
str(toy_g, e=TRUE)
###### se voglio assegnare un attributo colore
V(toy_g)$color = "red"
str(toy_g, v=TRUE)
# tutti i nodi che hanno un estremo 1-2 e l'altro estremo 3-4 devono essere dei tipi 
#a o b, per estremo si intende che si parte da 1 o 2 fino a 3 o 4
E(toy_g)$type = "type_B" # equivalent,
E(toy_g)[setdiff(E(toy_g), E(toy_g)[c(1,2)%--%c(3,4)])]$type = "type_B"
#la set diff fa tutta l'opearazione tranne per il tipo di set che ?? selezionato
# in questo caso abbiamo 1-2 e 3-4, 
E(toy_g)[c(1,2)%--%c(3,4)]$type = "type_A"
str(toy_g, e=TRUE)
#questa assegna ai nuovi vertidi un nuovo attributo
V(toy_g)[6]$color = "blue"
str(toy_g, v=TRUE)
#################################################################
#modificare un grafo per estrarne dei componenti 
#per verificare seun grafo e connesso (data una coppia di nodi esiste un path di lu
#lughezza finita che li connette)
is.connected(toy_g)

components(toy_g)
#####sono allineata
facebook_comp<- components(g)
head(facebook_comp$csize,20)
#l'output prip ?? un giant component, di tipo dominante sugli altri, la frazione dei component
#nel primo elemento ?? giant component, non ?? sempre vero.


toy_components = components(toy_g)
gc_index = which.max(toy_components$csize) # index of the GC in the csize vector
# indices of vertices that are member of the GC
toy_gc_indices = which(toy_components$membership == gc_index) 
# chiama il set  del giant component,
toy_gc_vertices = V(toy_g)[toy_gc_indices]
#estrae il set dei vertici del giant component
toy_gc_vertices
#####
toy_gc = induced.subgraph(toy_g, toy_gc_vertices)
toy_gc
#si prende come primo parametro un grafo e come secondo prevede il set dei vertici,
#restituisce il sotto grafo del giant component del toygraph
#per restituire si prende l'indice dei nodi,presi dal giant component. che restituisce
#ilgrafo.
fb_components<- components(g)
fb_gc_index = which.max(fb_components$csize)
fb_gc_indices = which(fb_components$membership == fb_gc_index) 
fb_gc_vertices = V(g)[fb_gc_indices]
g1 = induced.subgraph(g, fb_gc_vertices)
g1
vcount(g1)
#verifichiamo se il sottografo ?? connesso 
is.connected(g1)
##### per vedere la stessa cosa di prima con gli archi sopranominati
fb.positive <- subgraph.edges(g, which(E(g)$weight > 100))
#questi sono gli indici che prende il grafo come primo parametro e il set di indici
#secondo
vcount(fb.positive)
#####
ecount(fb.positive)



extract_component <- function (grafo, indice=-1) {
  comps=components(grafo)
  if (indice==-1){
    indice<- which.max(comps$csize) 
  }
  res <- induced.subgraph(grafo, V(grafo)[which(comps$membership == indice)])
  
  vertcount <- vcount(res)
  
  edgecount <- ecount(res)
  aaa<-list("pippo" = res, "vertice" = vertcount, "archi"=edgecount)
  return (aaa)
}

aaaaa<-extract_component(g)  
aaaaa
aaaaa.edgecount
aaaaa$vertice
aaaaa$archi
a
cat ("Index of min element: ", which.min(a), "\n", sep="")
cat ("Min element: ", a[which.min(a)], "\n", sep="")
cat ("Index of max element: ", which.max(a), "\n", sep="")
cat ("Max element: ", a[which.max(a)], "\n", sep="")


toy_components = components(toy_g)
gc_index = which.max(toy_components$csize) # index of the GC in the csize vector
# indices of vertices that are member of the GC
toy_gc_indices = which(toy_components$membership == gc_index) 
toy_gc_vertices = V(toy_g)[toy_gc_indices]
toy_gc_vertices



toy_gc = induced.subgraph(toy_g, toy_gc_vertices)

g.positive <- subgraph.edges(g, which(E(g)$weight > 100))
vcount(g.positive)
ecount(g.positive)


#PLOTTINGGRAPH

toyg_layout = layout_(toy_g, with_fr()) # use the Fruchterman-Reingold algorithm
plot(toy_g, layout = toyg_layout)


g.sub = induced_subgraph(g, V(g)[which(degree(g) > 100)])
layout_gsub = layout_(g.sub, with_fr())
plot(g.sub, layout = layout_gsub, edge.arrow.size=0.2, edge.width=E(g.sub)$weight/50, vertex.size=3, vertex.label=NA)

#DEGREE 

head(degree(g))
#la prima riga da il grado del nodo e il secondo da il grado del relativo nodo (per colonna)
max(degree(g))
v = V(g)[which.max(degree(g))]
v
neighbors(g, v, mode = "total")
length(neighbors(g, v, mode="total")) 
# calcola i vicini di un certo nodo, prednde un grafo, restituisce i vicini del nodo
# dato.
length(neighbors(g, v))


d.g = degree(g) #restituisce al primo elemento il dd[1], isolati a seguire quelli di
#grado n in base alla cardinalit??
dd = degree.distribution(g) #che il grado sia minore di un certo valore.
#di per se calcola la density
library(sm)
sm.density(d.g)
dd = dd[-1] # torno indietro di 1
#costruisco ora una sequenza di array da 1 al massimo grado, e prendo quelli che sono 
# diversi da zero
d = 1:max(d.g)
ind <- (dd != 0)
sm.density(ind)
sm.density(dd[ind])
sm.density()
#plotta la densit?? del grado in lg-lg scale
plot(d[ind], dd[ind], log="xy", col="red",
     xlab=c("Log-Degree"), ylab=c("Log-Intensity"),
     main="Log-Log Degree Density Function")

plot(d[ind], dd[ind], col="blue",
     xlab=c("Degree"), ylab=c("Intensity"),
     main="(Lin-lin) Degree Density Function")
### si plotta per istogrammi
hist(degree(g), freq = FALSE, breaks = d, right = FALSE, col="blue", xlab=c("Degree"), ylab=c("Intensity"),
     main="Histogram of the Degree Density")

hist(degree(g), freq = FALSE, breaks = d, right = FALSE, col="blue", xlab=c("Degree"), ylab=c("Intensity"),
     main="Histogram of the Degree Density", xlim = c(1,50))
h = hist(degree(g), breaks = d, right = FALSE, plot = FALSE)
head(h$counts)
head(h$density)
plot(h, freq = FALSE, col="blue", xlab=c("Degree"), ylab=c("Intensity"),
     main="Histogram of the Degree Density", xlim = c(1,50))

#si calcola la statistica CCDF
F <- ecdf(d.g) #empirical cumulative distribution function
# prende un set di valori e calcola la cumulative distribution function
x <- seq(min(d.g), max(d.g), 1)

sm.density(x)
# io qui sto pottando la ccdf complementare e plotto su scala logaritmica
plot(x, 1 - F(x), log="xy", main="Degree CCDF", ylab="P(X>d)", 
     xlab="Degree (d)", xlim=c(1,1000), col="red")

#si intende plottare non la funzione empirica, che si pu?? applicare ai valori che voglio
#calcolandola poi a tutti i valori possibili applicando
#trovare power law su grafi reali ?? piuttosto raro, pi?? facile che la coda caschi come
# power law, 


## ASSORTATIVITY
#preso ogni edge che da due nodi e prendo valore a sx e dx e creo gli array
#e calcolo la correlazione, se la positiva trovo correlaizone in modo che valori
#alti a sx da valory a dx alti. # si calcola quindi l'assortatuvty

a.nn.deg <- graph.knn(g,V(g))$knn
#graph.knn prende due parametri e calcola i valor
#tutti i valori medi sono memorizati nel vettore knn, per ogni nodo da il valor medio
# dei vicini di quel nodo

plot(degree(g), a.nn.deg, log="xy",
     col="goldenrod", xlab=c("Log Vertex Degree"),
     ylab=c("Log Average Neighbor Degree"))
#per ogni nodo si restuisce il grado, che ha i valri del grado di ogni nodo, si plottano
#sulle x tutti i gradi e sulle y si calcolano si il grado dei vicini del nodo g
a.nn.avg.deg = graph.knn(g,V(g))$knnk
# knnk ?? ul grado medio dei vicini che hanno un grado k, 
# plotto se valore crescente ho una rete assortativa e viceversa disassortativa se 
# degrescente

plot(1:max(degree(g)), a.nn.avg.deg, log="xy",
     col="goldenrod", xlab=c("Log Vertex Degree"),
     ylab=c("knnk index"))

out<-lm(1:max(degree(g))~a.nn.avg.deg)


summary(out)#per tutti nodi calcolo il grado medio dei vicini
#il plot prende e prende la media dei valori di ognuno sulle asse x
assortativity.degree(g)

#CLustering

transitivity(g, local)
mean(transitivity(g, "local"), na.rm = TRUE)
#si calcolano con questo il # di angoli e le triplette e si fa la media di tutta la rete
# si fa un un'indice di clustering locale e si fanno i campioni partendo da 
# transitivity(g, "local"), inoltre si rimuovono i NA se non ci sono ne angoli ne triplette
#se le triplette ci sono abbiamo uno 0, con quesro coefficiente si pu?? vedere il clustetinh
#in funzione dei nodi available


### 3.4. Centrality

closeness(g, vids=V(g)[1])
# con questo 1/lasommadelledistanze, la funzione prende un grafo e un set di nodi
# su cui calcolare la closeness, in questo caso calcolato su un nodo solo
# tale possono essere pesanti da calcolare computazionalmente
betweenness(g.sub, v=V(g.sub)[which.max(degree(g.sub))])
# prendo il vettore del grafo indotto e prendo il grado massimo 
edge_bet = edge.betweenness(g.sub)
# s ipulcalcolare anche per gli edge dei grafi attraverso la funziona sopra, qui 
# dargli del tutto il sottografo
index_max = which.max(edge_bet) 
# indice del primo nodo con betweenness massimo
edge_max = E(g.sub)[index_max]
#qua prendo quello con edge massimo
max_bet = edge_bet[index_max]
#calcolo la massima betweeness
cat ("Index of the edge with max betweenness: ", index_max, "\n", sep = "")
cat ("Edge with max betweenness\n")
edge_max
cat ("Max betweenness: ", max_bet, "\n", sep = "")
# come output si tenga presente che igraph presenta gli output di quello che calcola
# l'output presena qle righe es nodo 2 da quel valore 2.101 e-09


### 3.5. Community detection
#si calcolano le comunit?? partendo da un degree soglia e calcolo l'indiretto del grafo
# cio?? quello non dedotto, si parte prendendo il sottografo, 
g.sub1 <- induced.subgraph(g, V(g)[which(degree(g) > 180)])
g.sub1.u <- as.undirected(g.sub1)
# il grafo ?? come spra senza i vari pesi
fg.comm <- fastgreedy.community(g.sub1.u)
#?? oggetto di tipo communities che riuslta utile per fare nel dendogramma
dendPlot(fg.comm, mode="hclust")

#altro modo per prlottare le comunit?? 
plot(fg.comm, g.sub1.u)
#questo plotta le community come da dendogramma ma con visualizzazione per grafi

#un oggetto di tipo community da la possibilit?? di applicare una funzione meberschip che
# da un valore per ogni vertice del grafo, dando un valore member per l'oggetto community
# restituiendo l'indice della community nodo per nodo, altre cose, vd help "communities"

### 3.6 Social graphs vs. Interaction graphs
#differenze di analisi tra grafo pesato e non pesato, gli shortest path sono corti, se si
#considerano i grafi pesati e non pesati, questo ?? vero sempre, analizzando i social ntework
# e considerando l'interazione tra i nodi. Si vede l'analisi degli shortest path

# mi calcolo il sottoi/media/SAMMIE_1_TB_FUSE/Academia/Courses_and_Schools/Master_Big_Data/SNA/SNA_Project/OSNA/esercizio28aprosna.Rnsieme tra i grafi facendo un random sample di dimensione 150 facendo
# nun random sample.
from_sample = sample(V(g), 150)
to_sample = sample(V(g), 150)

sp.g.u = distances(g, v=from_sample, to = to_sample, weights = NA, mode = "all")
#considera nel grafo g i path da da v from a to, calcola gli shortest path, senza i pesi
# mode="all" considera i grafo come undirected, calcola le distanze
hist(sp.g.u[ !is.infinite(sp.g.u) & sp.g.u <= 20 ], right = FALSE, breaks = 0:20, 
     freq = FALSE, main="Estimated avg sp length for FB social graph",
     xlab="sp length", col="red")
#prendo i valori degli shortest path minori di 20m se volessi calcolare una distribuzione 
#senzata, abbiamo degli infiniti perch?? abbiamo un sample quindi tra nodi
# possiamo avere lunghezza infinita
abline(v = mean(sp.g.u[ !is.infinite(sp.g.u) & sp.g.u <= 20 ]), col = "yellow", lw=3)



### qua si prende il peso dei grafi
E(g)
str(g)
e_inv<-1/eee$weight
e_inv
pesi
sp.g = distances(g, v=from_sample, to = to_sample, mode = "all")
hist(sp.g[ !is.infinite(sp.g) & sp.g <= 20 ], right = FALSE, breaks = 0:20, freq = FALSE, main="Estimated avg weighted sp length for FB social graph", xlab="sp length", col="blue")
abline(v = mean(sp.g[ !is.infinite(sp.g) & sp.g <= 20 ]), col = "yellow", lw=3)
# pesi invertiti
sp.g.u = distances(g, v=from_sample, to = to_sample, weights = e_inv, mode = "all")
#considera nel grafo g i path da da v from a to, calcola gli shortest path, senza i pesi
# mode="all" considera i grafo come undirected, calcola le distanze
hist(sp.g.u[ !is.infinite(sp.g.u) & sp.g.u <= 20 ], right = FALSE, breaks = 0:20, 
     freq = FALSE, main="Estimated avg sp length for FB social graph",
     xlab="sp length", col="red")
#prendo i valori degli shortest path minori di 20m se volessi calcolare una distribuzione 
#senzata, abbiamo degli infiniti perch?? abbiamo un sample quindi tra nodi
# possiamo avere lunghezza infinita
abline(v = mean(sp.g.u[ !is.infinite(sp.g.u) & sp.g.u <= 20 ]), col = "yellow", lw=3)

### 4.1. Random graphs [@erdos1959onrandom]

er.p.sub1 = mean(degree(g.sub1.u))/vcount(g.sub1.u)

r.g.sub1.u <- erdos.renyi.game(vcount(g.sub1.u), er.p.sub1)
#numero dei nodi, numero dei nodi equivalenti 
plot(g.sub1.u, layout=layout.circle, vertex.label=NA, main="Original graph (sample)")
plot(r.g.sub1.u, layout=layout.circle, vertex.label=NA, main="Random graph")


#compare the distribution of the FB versus other ER graph

g.u = extract_component(g)
g.u = delete_edge_attr(g.u$pippo, "weight")
er.p = mean(degree(g.u))/vcount(g.u)
r.g <- erdos.renyi.game(vcount(g.u), er.p)
hist(degree(r.g), right=FALSE, main="Random graph",freq=FALSE, col="red", xlab = "Degree")
hist(degree(g.u), right=FALSE, main="Original graph", freq=FALSE, col="blue", xlab = "Degree")

### 4.3. Watts-Strogats model [@watts1998collective]

cc.sub1.u = transitivity(g.sub1.u)
avg.deg = mean(degree(g.sub1.u))
# estimate of the p parameter to get an equivalent clustering coefficient
ws.p = 1 - ((cc.sub1.u * (2*(2*avg.deg-1)/(3*(avg.deg-1)))) ^ (1/3))
w.s.sub1 <- watts.strogatz.game(1, size = vcount(g.sub1.u), nei=avg.deg, p=ws.p)
#nei sta per vicino, and avg.deg ?? il grado medio, con p, si fa un processo di rewiring
# ws.p 
# l'average degree pu?? cambiare , si pu?? provare ad usar ci?? si costruisce una rete usando il 
# parametro p, se il coefficiente di clustering ?? vicino da quello in cui partite
# allora si ha unqualcosa di similare.
plot(w.s.sub1, layout=layout.circle, vertex.label=NA, main="WS-graph")
plot(g.sub1.u, layout=layout.circle, vertex.label=NA, main="FB graph (sample")




#####Clustering comparison


transitivity(g.sub1.u)
transitivity(w.s.sub1)

#le reti di questo tpo servono per aere una ricerca della distribuzione precisa per le 
#power law. 

#La rete small wordl ?? una rete con path corto ?? un clustering alto, per cui se si ha che
# fare 

mean_distance(g.sub1.u, directed = FALSE)
mean_distance(w.s.sub1, directed = FALSE)

cc.u = transitivity(g.u)
avg.deg = mean(degree(g.u))
# estimate of the p parameter to get an equivalent clustering coefficient
ws.p = 1 - ((cc.u * (2*(2*avg.deg-1)/(3*(avg.deg-1)))) ^ (1/3))
# in this case the approximate ws.p does not work well, so ... manual tuning
w.s <- watts.strogatz.game(1, size = vcount(g.u), nei=avg.deg, p=0.3)

hist(degree(w.s), right=FALSE, main="WS model",freq=FALSE, col="red", xlab = "Degree")
hist(degree(g.u), right=FALSE, main="Original graph", freq=FALSE, col="blue", xlab = "Degree")
# la distribuzione ha valori concentrati vicino ad una power law, effetgtivamete
# con i parametri usati, abbiamo una distribuzione discreta.

#

#per i progetti si prendono dei dataset che non sono pesati e mettere i pesi, con coefficiente con 
# di jaccard