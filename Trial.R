library(readxl)
library(janitor)
library(tidyverse)

grades <- data.frame(
  grade = c("C", "B", "A", "A+"),
  rank = 1:4
)

df <- read_xlsx("OM Challanges/CH-035 Up and Down Grades.xlsx",
                 range = cell_cols(LETTERS[2:4]),
                 skip = 1) %>% 
  row_to_names(1)

df %>% 
  clean_names() %>% 
  mutate(date = excel_numeric_to_date(as.numeric(date))) %>% 
  left_join(grades,
            by = "grade") %>% 
  group_by(year = lubridate::year(date),
           month = lubridate::month(date), 
           agent_id) %>% 
  slice_max(n = 1, order_by = date) %>% 
  ungroup() %>% 
  mutate(date = floor_date(date, "month")) %>% 
  mutate(change = c(NA, diff(rank)), .by = agent_id) %>% 
  drop_na(change) %>% 
  ungroup() %>% 
  mutate(change = case_when(change > 0 ~ "Upgrade",
                            change == 0 ~ "NoChange",
                            change < 0 ~ "Downgrade"),
         month = month(date)) %>% 
  summarise(value = n(), .by = c(month, change)) %>% 
  pivot_wider(id_cols = month, values_from = value, names_from = change)

df <- read_xlsx("PQ/PQ_Challenge_174.xlsx", range = cell_cols(LETTERS[1:4]))

?case_match

factor(c(12, 1:4), levels = c(12, 1:4), ordered = TRUE)
