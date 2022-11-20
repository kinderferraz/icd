library(dplyr)

estacoes <- read.csv("trabalho/input/spAirPollution/estacoes-cetesb.csv/estacoes-cetesb.csv") %>%
    select("DATA", "ID", "Indice", "POLUENTE", "Municipio", "Nome", "Situacao_Rede", "Tipo_Rede") %>%
    filter(Municipio == "SAO PAULO") %>%
    transmute(data = as.Date(DATA),
              id = id
              indice = Indice,
              tipo_rede = as.factor(Tipo_Rede),
              poluente = as.factor(POLUENTE),
              )

head(estacoes)
str(estacoes)
