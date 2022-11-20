library("dplyr")

#########################
# read the data
#########################
births_conn <- file("./input/SINASC_2020_selecionado.csv", "r")

data_frame <- data.frame(read.csv(births_conn, nrows=2, sep=";", header=TRUE))

process_chunks <- function(conn, i) {
  chunk <- 1000
  piece <- read.csv(conn, skip=chunk * i, header=FALSE) %>% 
     # filter unwanted columns
    select("CODMUNNASC", "IDADEMAE")
  piece
}

rbind(data_frame, process_chunks(births_conn, 1))

births <- read.csv(births_conn, header=TRUE, sep=",", as.factor(c("ESCMAE", "RACACOR")))

##########################

