# Setup libraries and defaults for R scripts

load("~/Documents/GOC/.RData")
library(knitr)
library(tidyverse)
library(lubridate)
library(RMySQL)
library(uuid)
library(flextable)
library(officer)
library(keyring)
library(stringdist)
knitr::opts_chunk$set(echo = FALSE,message=FALSE, warning=FALSE)
set_flextable_defaults(font.size = 10, theme_fun = theme_signin, padding = 6, background.color = "#EFEFEF")