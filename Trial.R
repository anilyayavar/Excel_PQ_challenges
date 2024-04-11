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
  


df <- data.frame(
  stringsAsFactors = FALSE,
              Col1 = c("A1", "A2", "A3", "A4", NA, "A6"),
              Col2 = c("B1", NA, NA, "B4", NA, NA),
              Col3 = c("C1", NA, "C3", NA, "C5", "C6"),
              Col4 = c("D1", "D2", NA, "D4", NA, "D6"),
              Col5 = c("E1", "E2", NA, "E4", "E5", NA),
              Col6 = c("F1", "F2", NA, NA, "F5", NA)
      )

n <- 600

split.default(seq(n), ((seq(n) -1) %% 3) + 1) %>% 
  map_dfr(~df %>% 
        select(all_of(.x)) %>% 
        rename_with(~ paste0("Col", 1:2))) %>% 
  filter(if_any(everything(), ~!is.na(.)))


chars <- rev(LETTERS)
LETTERS %>% 
  as_tibble() %>% 
  set_names("char") %>% 
  mutate(x = row_number(),
         y = 1)

library(tidyverse)  
map_dfr(1:26,
    ~ seq(from = 2*.x -1, length.out = 27 - .x) %>% 
      as_tibble() %>% 
      set_names("x") %>% 
      mutate(char = LETTERS[seq(27 - .x)],
             y = 27 - .x)) %>% 
  ggplot(aes(x, y, label = char)) +
  geom_text() +
  scale_x_reverse() +
  theme_void()

for(i in 26:1){
  cat(rep(" ", i), rev(LETTERS[seq(i)]), "\n")
}



