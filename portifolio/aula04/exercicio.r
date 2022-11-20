## Alkindar José Ferraz Rodrigues
## aula 4
## analise da base sinasc em conjunto com municipios
####################################################

## Dependencias
setwd("./portifolio/aula4")
library("dplyr")

## input de dados
sinasc <- read.csv("./input/SINASC_2020.csv", sep = ";", header = TRUE) %>%
    select("CODMUNNASC", "LOCNASC", "ESCMAE", "PARTO", "SEXO", "RACACOR")

municipios <- read.csv("./input/municipios.csv", header = TRUE) %>%
    select("CODMUNIC", "uf_code", "uf")

## analise dados de nascimento
## media de nascimento por escolaridade
## tipo de parto por raça

## analise combinada
## sexo da criança por região
