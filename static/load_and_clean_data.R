library(tidyverse)

## CLEAN the data
CO2_emissions <- read_csv(here::here("dataset", "historical_emissions.csv"))
CO2_emissions_clean <- CO2_emissions
write_csv(CO2_emissions_clean, file = here::here("dataset", "historical_emissions.csv"))
save(CO2_emissions_clean, file = here::here("dataset/CO2_emission.RData"))

annual_temperature <- read_csv(here::here("dataset", "annual_temperature.csv"))
annual_temperature_clean <- annual_temperature
write.csv(annual_temperature_clean, file = here::here("dataset", "annual_temperature.csv"))
save(annual_temperature_clean, file = here::here("dataset/annual_temperature.RData"))

fossil_fuel<-read.csv(here::here("dataset", "global_fossil_fuel_consumption.csv"))
fossil_fuel_clean <- fossil_fuel
write.csv(fossil_fuel_clean, file = here::here("dataset", "global_fossil_fuel_consumption.csv"))
save(fossil_fuel_clean, file = here::here("dataset/global_fossil_fuel_consumption.RData"))

Forest_area<-read_csv(here::here("dataset", "API_AG.LND.FRST.ZS_DS2_en_csv_v2_4701080.csv"))
Forest_area_clean <- Forest_area
write.csv(Forest_area_clean, file = here::here("dataset", "API_AG.LND.FRST.ZS_DS2_en_csv_v2_4701080.csv"))
save(Forest_area_clean, file = here::here("dataset/(Forest_area.RData"))

World_population<-read_csv(here::here("dataset", "API_SP.POP.TOTL_DS2_en_csv_v2_4701113.csv"))
World_population_clean <- World_population
write.csv(World_population_clean, file = here::here("dataset", "API_SP.POP.TOTL_DS2_en_csv_v2_4701113.csv"))
save(World_population_clean, file = here::here("dataset/World_population.RData"))