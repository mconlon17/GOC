get.birthdays <- function(date=Sys.Date())  {

members <- get.members(active.only=T)

contacts <- get.contacts() %>%
  select(id, c2_groups) %>%
  filter(!grepl("Deceased", c2_groups))

tab <- members %>%
  inner_join(contacts, by = c("contact_id_c" = "id")) %>%
  mutate(birthday = ymd(paste(year(Sys.Date()), month(birthdate), day(birthdate), sep = "-"), quiet=T)) %>%
  select(first_name, last_name, birthday) %>%
  filter(birthday == date)

  if (nrow(tab) == 0) { "No birthdays today"} else { paste(tab$first_name, collapse=", ") }

}
