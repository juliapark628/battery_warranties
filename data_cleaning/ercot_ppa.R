# This file calculates revenue for ESR resources.

rm(list = ls())
setwd(here::here())



# SET UP
library(tidyverse)
library(readxl)

data_path <- "data_cleaning/external/google_drive/"

df <- read_excel(paste0(data_path, "2025 Utility-Scale Solar Data Update.xlsx"), sheet = "Individual_Project_Data")

df_ercot <-
  df %>% filter(Region == "ERCOT", str_detect(`Hybrid?`, "Storage"))


df_caiso <- 
  df %>% filter(Region == "CAISO", str_detect(`Hybrid?`, "Storage"))

df_nm <- 
  df %>% filter(State == "NM", str_detect(`Hybrid?`, "Storage"))