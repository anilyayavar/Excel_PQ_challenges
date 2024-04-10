library(readxl)
library(janitor)

df <- read_excel("Excel/Excel_Challenge_431 - Top 3 Rankings.xlsx", range = cell_cols(LETTERS[1:8]))


df <- read_xlsx("PQ/PQ_Challenge_172.xlsx", range = cell_cols(LETTERS[1:6]))
df %>% 
  clean_names() %>% 
  separate(share_percent, into = paste0("Share", 1:2), convert = TRUE) %>% 
  pivot_longer(cols = c(starts_with("agent"), starts_with("Share")), 
               names_pattern = "(\\D*)(\\d)",
               names_to = c(".value", "num"),
               values_drop_na = TRUE) %>% 
  complete(fill = list(Share = 100)) %>% 
  mutate(amt = amount * commission_percent * Share/10000) %>% 
  summarise(Commission = sum(amt), .by = agent) %>% 
  janitor::adorn_totals()
  



