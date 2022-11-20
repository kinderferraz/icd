library(arules)
library(RColorBrewer)
library(arulesViz)
library(dplyr)
data("AdultUCI")
str(AdultUCI)
#Remover ou substituir variáveis não utilizadas
adult<-AdultUCI%>%
  select(-fnlwgt,-5)
#adult[["education-num"]] <- NULL
#Converter para factor
adult[[ "age"]] <- ordered(cut(adult[[ "age"]], c(15,25,45,65,100)),
                           labels = c("jovem", "meia-idade", "senior", "idoso"))
adult[[ "hours-per-week"]] <- ordered(cut(adult[[ "hours-per-week"]],
                                          c(0,25,40,60,168)),
                                      labels = c("parcial", "full-time", "hora-extra", "workaholic"))
adult[[ "capital-gain"]] <- ordered(cut(adult[[ "capital-gain"]],
                                        c(-Inf,0,median(adult[[ "capital-gain"]][adult[[ "capital-gain"]]>0]),
                                          Inf)), labels = c("nenhum", "baixo", "alto"))
adult[[ "capital-loss"]] <- ordered(cut(adult[[ "capital-loss"]],
                                        c(-Inf,0, median(adult[[ "capital-loss"]][adult[[ "capital-loss"]]>0]),
                                          Inf)), labels = c("nenhum", "baixo", "alto"))

#Converter os dados para o tipo transaction
adult_tran <- transactions(adult)
adult_tran
summary(adult_tran)

inspect(head(adult_tran))
#Interpretação: Depois de chamar a função inspect para a parte inicial e final das 
#transações, podemos obter uma lista de transações e seus IDs. As transações são 
#conjuntos de itens ou conjuntos de itens organizados juntos por meio de ID. 
#O dataframe após a conversão em transação está no formato de arquivo simples. 
#Quando o arquivo está neste formato significa que cada linha representa 
#a transação onde os itens da cesta estão representados por coluna. Uma vez que os 
#dados de fatores ordenados originais são coagidos para transações, os dados estão 
#prontos para mineração de conjuntos de itens ou regras.

#Criar um gráfico de frequência de item absoluto e relativo
arules::itemFrequencyPlot(adult_tran, topN = 20,
                          col = brewer.pal(8, 'Pastel2'),
                          main = 'Frequência absoluta',
                          type = "absolute",
                          ylab = "Frequência do item (Absoluta)")

arules::itemFrequencyPlot(adult_tran, topN = 20,
                          col = brewer.pal(8, 'Pastel2'),
                          main = 'Frequência relativa',
                          type = "relative",
                          ylab = "Frequência do item (Relativa)")

#Criando a priori com support = 1%, confidence = 80% e comprimento máximo da regra como 10.
aParam  = new("APparameter", "support" =0.01,  "confidence" = 0.8, "maxlen"= 10)
association.rule <-apriori(adult_tran,aParam)
summary(association.rule)
#Interpretação
#1. 197371 número de regras criadas com o parâmetro de suporte = 1%, confiança = 80% e max-len = 10. 
#2. Distribuições de comprimento de regras onde o número de conjuntos de itens envolvidos nas regras são definidos. 
#O número máximo de regras envolveu 6 conjuntos de itens. (isso também é mediano) 
#3. A medida resumida para suporte, confiança e cobertura também pode ser visualizada, 
#o que mostra que a mediana de suporte está próxima de 1, o que significa que a 
#maioria das regras está próxima do limite (geração de conjuntos de itens não muito frequente) 
#4. O probabilidade condicional (A|B) ou confiança é maior, o que significa que as 
#chances de co-ocorrência são maiores. [já que o limite é maior, ou seja, 80%]
inspect(head(association.rule, 10))

#Crie uma nova regra como “hours.per.week.ft.rule” com “hour-per-week=Full-time” no RHS 
#com suporte de 1%, confiança de 80%, duração máxima de 10 e duração mínima de 2.

hours.per.week.ft.rule <- apriori(adult_tran, parameter = list(support=0.01, confidence = 0.8, minlen = 2, maxlen = 10), 
                                  appearance = list(rhs = c("marital-status=Married-spouse-absent"), default="lhs"))

#Para filtrar as regras criadas com o Apriori, podemos usar o parâmetro de appearance. 
#A appearance pode ser alterada ajustando o parâmetro de lhs e rhs. Para este problema, criamos rhs para 
#ser hours-per-week=full-time e o padrão para ser lhs. Todas as regras que 
#possuem rhs de hours-per-week=full-time foi impressa. Algumas dessas regras 
#têm aumento maior que 1, o que significa que essas regras ocorrem simultaneamente. Esta regra 
#implica que existe uma relação positiva entre lhs e rhs.

plot(hours.per.week.ft.rule)
plot(hours.per.week.ft.rule, method="two-key plot")

#Gráfico interativo
plot(hours.per.week.ft.rule, method = "graph",  engine = "htmlwidget")

