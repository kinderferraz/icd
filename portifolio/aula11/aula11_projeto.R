# deps
library(dplyr)
library(cluster)
library(factoextra)

# carregar base
sinasc <- read.csv("input/SINASC_2020_comp.csv") %>%
  select(  "IDADEMAE"
         , "ESCMAE"
         , "QTDFILMORT"
         , "QTDFILVIVO"
         , "GESTACAO"
    #     , "PESO"
         , "RACACOR"
         , "RACACORMAE"
         ) %>%
  na.omit() 
sinasc <- sinasc[1:500,]

sinasc$ESCMAE <- as.factor(sinasc$ESCMAE)
sinasc$SEXO <- as.factor(sinasc$SEXO)
sinasc$RACACOR <- as.factor(sinasc$RACACOR)

nrow(sinasc)
head(sinasc)
sinasc <- scale(sinasc)

# preprocessamento
sinasc.dist.pearson <- get_dist(sinasc, method = "pearson")
fviz_dist(sinasc.dist.pearson, lab_size = 8)

sinasc.dist.euclidean <- get_dist(sinasc, method = "euclidean")
fviz_dist(sinasc.dist.euclidean, lab_size = 8)

# clusterizar
set.seed(123)
sinasc.km.res <- eclust(sinasc, "kmeans", nstart = 25)
sinasc.km.res3 <- eclust(sinasc, "kmeans", nstart = 25, center = 3)
sinasc.km.res4 <- eclust(sinasc, "kmeans", nstart = 25, center = 4)

fviz_gap_stat(sinasc.km.res$gap_stat)

sinasc.res.hc <- eclust(sinasc, "hclust")
fviz_dend(sinasc.res.hc, cex = 0.5, k = 4, palette = "jco") 
