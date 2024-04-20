library(janitor)
library(readxl)
library(tidyverse)

df <- read_xlsx("PQ/PQ_Challenge_164.xlsx", range = cell_cols(LETTERS[1:5])) 
df %>% 
  pivot_longer(-Group, names_pattern = "([A-z]+)(\\d+)", names_to = c(".value", "num")) %>% 
  separate(Number, into = c("Type", "Code"), sep = 2) %>% 
  select(-num)


bifid <- function(WORD, KEY = "ROSE"){
  mat <- KEY %>% 
    toupper() %>% 
    str_split("") %>% 
    unlist() %>% 
    unique() %>% 
    {c(., subset(LETTERS, !LETTERS %in% c(., "J")))} %>% 
    matrix(nrow=5, byrow = TRUE)
  
  str_split(WORD, "")  %>% 
    unlist() %>% 
    map(~ which(mat == .x, arr.ind = TRUE) %>% as.vector()) %>% 
    unlist() %>% 
    matrix(ncol = 2, byrow = TRUE) %>% 
    as.vector() %>% 
    split.default(., ((seq_along(.) - 1) %/% 2) + 1 ) %>% 
    map_chr(~mat[.x[1], .x[2]]) %>% 
    str_c(collapse = "")
}

bifid("BATTLE", "ROTORS")


"ROSE" %>% 
  toupper() %>% 
  str_split("") %>% 
  unlist() %>% 
  {c(., subset(LETTERS, !LETTERS %in% c(., "J")))} %>% 
  matrix(nrow=5, byrow = TRUE)



