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

CO2_clean<-CO2_emissions %>% select(Country,34:6)
CO2_clean$`1990`<-as.double(CO2_clean$`1990`)
CO2_clean_1 <- CO2_clean %>% 
  pivot_longer(cols = c("1990":"2018"),names_to = "Year",values_to = "CO2emission")
CO2_clean_1<- CO2_clean_1 %>% group_by(Country,Year)

global_temp<-annual_temperature %>% filter(Source=="GCAG") %>% select(Year,Mean)
global_temp$Year<-as.character(global_temp$Year)
World_data<-CO2_clean_1 %>% filter(Country=="World") %>% 
  inner_join(global_temp)

colnames(fossil_fuel)[which(names(fossil_fuel)=="Gas..TWh..direct.energy.")]<- "Gas"
colnames(fossil_fuel)[which(names(fossil_fuel)=="Oil..TWh..direct.energy.")]<- "Oil"
colnames(fossil_fuel)[which(names(fossil_fuel)=="Coal..TWh..direct.energy.")]<- "Coal"
fossil_fuel<-fossil_fuel %>% select(Year:Coal)
fossil_fuel$Year<-as.character(fossil_fuel$Year)
World_data<-fossil_fuel %>% inner_join(World_data)

world_pop<-population %>% filter(`Country Name`=="World") %>% 
  select(`Country Name`,"1960":"2021") %>% 
  pivot_longer(cols = c("1960":"2021"),names_to = "Year",values_to = "population")
World_data<-world_pop %>% inner_join(World_data)

world_forest_area<-forest_area %>% filter(`Country Name`=="World") %>% 
  select(`Country Name`,"1960":"2021") %>% 
  pivot_longer(cols = c("1960":"2021"),names_to = "Year",values_to = "forest area")
World_data<-world_forest_area %>% inner_join(World_data)

World_data<-World_data %>% select(- Country)
colnames(World_data)[9]<-"temperature"
colnames(World_data)[1]<-"Country_Name"
colnames(World_data)[3]<-"forest_area"






