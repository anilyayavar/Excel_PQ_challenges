library(readxl)
library(tidyverse)
library(janitor)

df <- read_excel("OM Challanges/CH-038 Duration Since Last Visit.xlsx", 
           skip = 1) %>% 
  select(1:2)

df %>% 
  clean_names() %>% 
  mutate(date = as.Date(date)) %>% 
  group_by(year = year(date), month = month(date), agent_id) %>% 
  slice_max(order_by = date, n = 1) %>% 
  ungroup() %>% 
  mutate(end = as.Date(ceiling_date(date, "month") - 1)) %>% 
  complete(agent_id, nesting(year, month, end)) %>% 
  arrange(agent_id, year, month) %>% 
  fill(date, .direction = "down") %>% 
  group_by(month) %>% 
  summarise(
    avg = as.numeric(mean(end - date))
  ) %>% 
  filter(avg > 0)

  
  