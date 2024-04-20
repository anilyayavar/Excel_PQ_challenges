library(tidyr)
data <- tibble::tribble(
                                 ~State,   ~Category,                        ~Name, ~Status,
          "Andaman and Nicobar Islands",    "Animal",                     "Dugong",    "VU",
          "Andaman and Nicobar Islands",      "Bird",       "Andaman wood pigeon[",    "NT",
          "Andaman and Nicobar Islands",      "Tree",            "Andaman redwood",    "VU",
                        "Daman and Diu",      "Bird",                           NA,      NA,
                        "Daman and Diu",      "Tree",                           NA,      NA,
                       "Madhya Pradesh",    "Animal",                 "Swamp deer",    "VU",
                       "Madhya Pradesh",      "Bird", "Indian Paradise Flycatcher",    "LC",
                       "Madhya Pradesh",      "Tree",                     "Banyan",      NA,
                          "Maharashtra",    "Animal",      "Indian giant squirrel",    "LC",
                          "Maharashtra",      "Bird", "Yellow-footed green pigeon",    "LC",
                          "Maharashtra", "Butterfly",                "Blue Mormon",      NA,
                            "Rajasthan",    "Animal",                      "Camel",      NA,
                            "Rajasthan",    "Animal",                   "Chinkara",    "LC",
                            "Rajasthan",      "Bird",       "Great Indian Bustard",    "CR",
                            "Rajasthan",      "Tree",         "Prosopis Cineraria",      NA
          )

data %>% 
  complete(State, Category, fill = list(Name = "Unknown"), explicit = FALSE)

