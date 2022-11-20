library(arules)
library(RColorBrewer)
library(arulesViz)
library(dplyr)

sinasc.orig <- read.csv("input/SINASC_2020_comp.csv") %>%
  select(  "IDADEMAE"
         , "PARTO"
         , "ESCMAE2010"
         , "KOTELCHUCK"
         , "LOCNASC"
         , "QTDFILVIVO"
         , "SEXO") %>%
  na.omit()
sinasc <- data.frame(sinasc.orig)

sinasc$ESCMAE2010 <- as.factor(sinasc.orig$ESCMAE2010)
sinasc$KOTELCHUCK <- as.factor(sinasc.orig$KOTELCHUCK)
sinasc$QTDFILVIVO <- as.factor(sinasc.orig$QTDFILVIVO)

sinasc$IDADEMAE <- ordered(cut(sinasc.orig[[ "IDADEMAE"]], c(13,18,30,45,100)),
                           labels = c("adolescente", "jovem", "meia-idade", "velha"))
sinasc$PARTO <- cut(sinasc.orig[[ "PARTO"]], c(0,1,2,10),
                    right = TRUE,
                    labels = c("natural", "cesarea", "ignorado"))
sinasc$SEXO <- cut(sinasc.orig[[ "PARTO"]], c(-1,0,1,2),
                    right = TRUE,
                    labels = c("IGNORADO", "MASCULINO", "FEMININO"))

sinasc$LOCNASC <- cut(sinasc.orig[[ "LOCNASC"]], c(0,1,2,3,4,5),
                   right = TRUE,
                   labels = c("HOSPITAL", "CLINICAS", "CASA", "OUTROS", "ALDEIA"))

summary(sinasc)
head(sinasc)

sinasc.transactions <- transactions(sinasc)
sinasc.transactions
inspect(sinasc.transactions)

arules::itemFrequencyPlot(sinasc.transactions, topN = 20,
                          col = brewer.pal(8, 'Pastel2'),
                          main = 'Frequência absoluta',
                          type = "absolute",
                          ylab = "Frequência do item (Absoluta)")

aParam  = new("APparameter", "support" =0.01,  "confidence" = 0.7, "maxlen"= 10)
sinasc.association.rule <-apriori(sinasc.transactions,aParam)
summary(sinasc.association.rule)
inspect(head(sinasc.association.rule, 15))

locnasc.casa.ft.rule <- apriori(sinasc.transactions, parameter = list(support=0.01, confidence = 0.8, minlen = 2, maxlen = 10), 
                                  appearance = list(rhs = c("LOCNASC=OUTROS"), default="lhs"))
plot(locnasc.casa.ft.rule)
