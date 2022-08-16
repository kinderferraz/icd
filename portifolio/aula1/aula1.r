## Alkindar Rodrigues #
##     SP3029956      #
#######################

library(VennDiagram)

# Helper function to display Venn diagram
display_venn <- function(x, ...){
  grid.newpage()
  venn_object <- venn.diagram(x, filename = NULL, ...)
  grid.draw(venn_object)
}

## exercicio 1
## Quantidade de serviços oferecidos por shopping
shopping <- read.csv(file="portifolio/aula1/shopping.csv",
                     header = TRUE, sep = ";")

shopping %>% count()


display_venn(x = shopping,
             fill=c("#0073C2FF", "#EFC000FF", "#868686FF", "#CD534CFF"))

## exercicio 2
## Shoppings com a melhor avaliação média, por completude de
## serviços

shopping2 <- read.csv(file="portifolio/aula1/shopping2.csv",
                      header = TRUE, sep = ";")

## exercicio 4
## Informações extraidas da tabela de dados de fumantes

