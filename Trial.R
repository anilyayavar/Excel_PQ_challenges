library(readxl)
library(janitor)
library(tidyverse)


df <- read_xlsx("PQ/PQ_Challenge_169.xlsx", range = cell_cols(LETTERS[1]))
df %>% 
  mutate(Codes = map_chr(String, ~ str_extract_all(.x, pattern = "(?<=\\b)[A-Z]+\\d+[A-Z0-9]+(?=\\b)") %>% 
                           unlist() %>% 
                           str_c(collapse = ", ")))


df <- read_excel("Excel/Excel_Challenge_433 - Text Split.xlsx", range = cell_cols(LETTERS[1]))

output <- df %>% 
  separate(Text, into = c("Levels", "Names"), sep = " : ") %>% 
  separate(Levels, into = paste0("Level", 1:3), sep = "\\.", fill = "right") %>% 
  separate(Names, into = c("First Name", "Last Name"), sep = " ", fill = "right")


result <- read_excel("Excel/Excel_Challenge_433 - Text Split.xlsx", range = cell_cols(LETTERS[3:7]))
identical(output, result)
