library(RSQLite)
library(pool)

conn <- dbPool(RSQLite::SQLite(), dbname = "../dados/dados.sqlite")
