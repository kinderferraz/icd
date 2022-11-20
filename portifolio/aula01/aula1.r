## Alkindar Rodrigues #
##     SP3029956      #
#######################

library(dplyr)
library(VennDiagram)

## aux vars
inputFolder <- function(filename){
    paste("portifolio/input/", filename, sep = "")
}

outputFolder <- function(filename){
    paste("portifolio/aula01/", filename, sep = "")
}

display_diagram <- function(x, filename){
    grid.newpage()
    venn_data <- venn.diagram(x = x,
                 filename = outputFolder(filename),
                 fill=c("#0073C2FF", "#EFC000FF", "#868686FF", "#CD534CFF"))
    grid.draw(venn_data)
}


## exercicio 1
## Quantidade de serviços oferecidos por shopping
shopping <- read.csv(file=inputFolder("shopping.csv"),
                     header = TRUE, sep = ";")

shopping %>% count()

display_diagram(shopping, "shoppingCount.png")

## exercicio 2
## Shoppings com a melhor avaliação média, por completude de
## serviços

shopping2 <- read.csv(file="portifolio/input/shopping2.csv",
                      header = TRUE, sep = ";")

## exercicio 4
## Informações extraidas da tabela de dados de fumantes
