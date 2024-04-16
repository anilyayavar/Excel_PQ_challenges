library(janitor)
library(readxl)
library(tidyverse)

df <- read_xlsx("PQ/Power_Query_Challenge_167.xlsx", range = cell_cols(LETTERS[1:4]))

df %>% 
  clean_names() %>% 
  group_by(dummy = cumsum(!is.na(as.integer(camp_no)))) %>% 
  group_split(.keep = FALSE) %>% 
  map_dfr(~ .x %>% 
         mutate(camp_no = camp_no[1],
                name = vaccine,
                vaccine = vaccine[1]) %>% 
        filter(row_number() != 1)) %>% 
  mutate(notification_date = "Yes") %>% 
  complete(camp_no, name, fill = list(notification_date = "No")) %>% 
  fill(vaccine, .direction = "down") 


?fill
