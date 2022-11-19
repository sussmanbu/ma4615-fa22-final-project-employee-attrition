library(tidyverse)


CO2_emissions <- read_csv(here::here("dataset", "historical_emissions.csv"))

## CLEAN the data
CO2_emissions_clean <- CO2_emissions

write_csv(CO2_emissions_clean, file = here::here("dataset", "historical_emissions.csv"))

save(CO2_emissions_clean, file = here::here("dataset/CO2_emission.RData"))


global_temp <- read.csv(here::here("dataset", "annual_csv.csv"))


## CLEAN the data
global_temp_clean <- global_temp

write.csv(global_temp_clean, file = here::here("dataset", "annual_csv.csv"))

save(global_temp_clean, file = here::here("dataset/annual_csv.RData"))