remotes::install_github("https://github.com/pharmaverse/admiral")
library(admiral)
library(tidyverse)


haven::write_sas(admiral::admiral_adsl, path = "data/adsl.sas7bdat")
write_csv(admiral::admiral_adsl, file = "data/adsl.csv")

# test
adsl <- haven::read_sas("data/adsl.sas7bdat") %>% 
  mutate_if(is_character, na_if, "")
adsl.csv <- read_csv("data/adsl.csv")


all.equal(adsl.csv, admiral_adsl)
all.equal(adsl, admiral_adsl)


## some information got lost when writing and loading the adsl dataset. 
## is the data/adsl.sas7bdat good enough for the workshop? Is there a 
## better package to write and read sas files that you know?
