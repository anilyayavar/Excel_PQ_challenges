library(readxl)
library(janitor)
library(tidyverse)


df <- read_xlsx("PQ/PQ_Challenge_169.xlsx", range = cell_cols(LETTERS[1]))
df %>% 
  mutate(Codes = map_chr(String, ~ str_extract_all(.x, pattern = "(?<=\\b)[A-Z]+\\d+[A-Z0-9]+(?=\\b)") %>% 
                           unlist() %>% 
                           str_c(collapse = ", ")))


df <- read_excel("Excel/Excel_Challenge_433 - Text Split.xlsx", range = cell_cols(LETTERS[1]))

df %>% 
  separate(Text, into = c("Levels", "Names"), sep = ":") 
