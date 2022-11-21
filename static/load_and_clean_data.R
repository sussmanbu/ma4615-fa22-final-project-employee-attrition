library(tidyverse)
library(readxl)

## Load and CLEAN the data
CO2_emissions <- read_csv(here::here("dataset", "historical_emissions.csv"))
CO2_emissions_clean <- CO2_emissions
write_csv(CO2_emissions_clean, file = here::here("dataset", "historical_emissions.csv"))
save(CO2_emissions_clean, file = here::here("dataset/CO2_emission.RData"))

annual_temperature <- read_csv(here::here("dataset", "annual_temperature.csv"))
annual_temperature_clean <- annual_temperature%>%select(Source,Year,Mean)
write.csv(annual_temperature_clean, file = here::here("dataset", "annual_temperature.csv"))
save(annual_temperature_clean, file = here::here("dataset/annual_temperature.RData"))

fossil_fuel<-read.csv(here::here("dataset", "global_fossil_fuel_consumption.csv"))
fossil_fuel_clean <- fossil_fuel
write.csv(fossil_fuel_clean, file = here::here("dataset", "global_fossil_fuel_consumption.csv"))
save(fossil_fuel_clean, file = here::here("dataset/global_fossil_fuel_consumption.RData"))

population<-read_excel(here::here("dataset", "API_SP.POP.TOTL_DS2_en_excel_v2_4701288.xls"))
population_clean <- population
write.csv(population_clean, file = here::here("dataset", "API_SP.POP.TOTL_DS2_en_excel_v2_4701288.csv"))
save(population_clean, file = here::here("dataset/API_SP.POP.TOTL_DS2_en_excel_v2_4701288.RData"))

forest_area<-read_excel(here::here("dataset", "API_AG.LND.FRST.ZS_DS2_en_excel_v2_4700430 (1).xls"))
forest_area_clean <- forest_area
write.csv(forest_area_clean, file = here::here("dataset", "API_AG.LND.FRST.ZS_DS2_en_excel_v2_4700430 (1).csv"))
save(forest_area_clean, file = here::here("dataset/API_AG.LND.FRST.ZS_DS2_en_excel_v2_4700430 (1).RData"))







