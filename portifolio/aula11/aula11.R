# clusterização

## preprocessamento
## na
## categoricos
## padronização: scale

library(cluster)
library(factoextra)

arrest <- scale(USArrests)
arrest.dist <- get_dist(arrest, method = "pearson")
head(round(as.matrix(arrest.dist), 2))[, 1:6]

## plot.default(arrest.dist, )

# Visualizar a matriz de dissimilaridade
fviz_dist(arrest.dist, lab_size = 8)
ar.dist <- dist(arrest, method = "euclidean")
fviz_dist(ar.dist, lab_size = 8)
fviz_nbclust(arrest, kmeans, method = "gap_stat")

#k-means - função geral
#eclust(x, FUNcluster = "kmeans", hc_metric = "euclidean", ...)
#x: vector numérico, matriz ou data frame
#FUNcluster: escolher o tipo de cluster: “kmeans”, “pam”, “clara”, “fanny”, “hclust”, “agnes” e “diana”.
#hc_metric: cadeia de caracteres especificando a métrica a ser usada para calcular diferenças entre observações. Os valores permitidos são aqueles aceitos pela função dist() [incluindo “euclidean”, “manhattan”, “maximum”, “canberra”, “binary”, “minkowski”] e medidas de distância baseadas em correlação [“pearson”, “spearman” ou “kendall”]. Usado apenas quando FUNcluster é uma função de agrupamento hierárquico, como “hclust”, “agnes” ou “diana”.

set.seed(1234)
km.res <- kmeans(arrest, 4, nstart = 25)  ## outra opção
# km.res <- eclust(arrest, "kmeans", nstart = 25)
fviz_gap_stat(km.res$gap_stat)
# Visualizar
fviz_cluster(km.res, data = arrest, palette = "jco",
             ggtheme = theme_minimal())

#res.hc <- hclust(dist(arrest),  method = "ward.D2") - outra opção
res.hc <- eclust(arrest, "hclust")
fviz_dend(res.hc, cex = 0.5, k = 4, palette = "jco") 

#Silhouette
fviz_silhouette(km.res)
km.res$nbclust

fviz_silhouette(res.hc)
res.hc$nbclust
fviz_dend(res.hc, rect = TRUE)
