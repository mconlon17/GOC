get.staff.names <- function()  {

contacts <- get.contacts() %>%
  filter(grepl("Staff", c2_groups)) %>%
  mutate(name = paste0(last_name, ", ", first_name)) %>%
  select(name) %>%
  arrange(name)

  contacts$name

}
