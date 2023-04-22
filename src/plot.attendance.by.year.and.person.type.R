plot.attendance.by.year.and.person.type <- function() {
    
  # Staff, Member, and Volunteer, and Other eqach have lines on a plot
  # showing attendance at the GOC over time
    
  attendance <- get.attendance() %>%
    mutate(
      Year = year(da_date_of_attendance),
      YearMonth = ymd(paste0(Year, "-", month(da_date_of_attendance), "-01"))
    )

  contacts <- get.contacts() %>%
    mutate(PersonType = "Other") %>%
    mutate(PersonType = ifelse(grepl("Staff", c2_groups), "Staff", PersonType)) %>%
    mutate(PersonType = ifelse(grepl("Member", c2_groups), "Member", PersonType)) %>%
    mutate(PersonType = ifelse(grepl("Volunteer", c2_groups), "Volunteer", PersonType)) %>%
    filter(PersonType == "Member" | PersonType == "Staff" | PersonType == "Volunteer")

  # tab <- contacts %>%ls()
  #     group_by(PersonType) %>%
  #     tally()
  #
  # ft <- goc.table(tab,"Contacts by type")
  # ft

  attendance <- attendance %>%
    inner_join(contacts, by = c("contact_2_id" = "id"))

  # tab <- attendance %>%
  #     group_by(Year,PersonType) %>%
  #     tally() %>%
  #     filter(Year < 2023) %>%
  #     spread(PersonType,n)

  # ft <- goc.table(tab,"Recorded Attendance by Year")
  # ft

  tab <- attendance %>%
    rename(`Person Type` = PersonType) %>%
    group_by(Year, `Person Type`) %>%
    tally() %>%
    filter(Year < 2023)

  ggplot(tab, aes(x = Year, y = n, color = `Person Type`)) +
    geom_line(linewidth = 1.5) +
    ggtitle("GOC Recorded Attendance by Year and Person Type") +
    ylab("Attendance") +
    theme(plot.title = element_text(hjust = 0.5, size = rel(2.5), face = "bold"))
}
