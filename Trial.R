library(readxl)
library(janitor)
library(tidyverse)


df <- read_xlsx("PQ/PQ_Challenge_173.xlsx", range = cell_cols(LETTERS[1:2]))

df %>% 
  group_by(
    Year = year(Date),
    Quarter = as.factor(quarter(Date)),
    Month = month(Date, abbr = TRUE, label = TRUE)
  ) %>% 
  summarise(
    `Total Sale` = sum(Sale),
    .groups = 'drop'
  ) %>% 
  mutate(
    `Sale %` = scales::percent(`Total Sale`/sum(`Total Sale`),
                               accuracy = 1),
    .by = Year
  ) %>% 
  group_split(Year) %>% 
  map_dfr(janitor::adorn_totals) %>% 
  mutate(`Sale %` = ifelse(`Sale %` == "-", "100%", `Sale %`)) %>% 
  #mutate(Year = if_else(row_number() == 1, Year, NA_character_), .by = Year) %>% 
  mutate(Quarter = if_else(row_number() == 1, Quarter, NA_character_), .by = c(Year, Quarter))
  


