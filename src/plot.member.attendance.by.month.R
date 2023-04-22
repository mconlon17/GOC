plot.member.attendance.by.month <- function(end_date=Sys.Date()) {
    
  # Plot member attendance by month from the founding through today
  
  end_date <- rollback(end_date)

  contacts <- get.contacts() %>%
    filter(grepl("Member", c2_groups))

  attendance <- get.attendance() %>%
    inner_join(contacts, by = c("contact_2_id" = "id")) %>%
    mutate(da_date_of_attendance = as_date(da_date_of_attendance)) %>%
    filter(da_date_of_attendance <= end_date & da_date_of_attendance > as_date("2008-01-01")) %>%
    mutate(YearMonth = rollback(da_date_of_attendance, roll_to_first=T)) %>%
    select(da_date_of_attendance, YearMonth) %>%
    arrange(desc(da_date_of_attendance))
  
  # ft <- goc.table(head(attendance, n=600))
  # ft

  tab <- attendance %>%
    group_by(YearMonth) %>%
    tally()

  # ft <- goc.table(tab)
  # ft

  ggplot(tab, aes(x = YearMonth, y = n)) +
    geom_line() +
    geom_vline(color = "darkgrey", xintercept = seq(ymd("2009-01-01"), ymd(end_date), by = "year")) +
    ggtitle("Member Attendance by Month") +
    theme(plot.title = element_text(hjust = 0.5, size = rel(2.5), face = "bold")) +
    ylab("Attendance")
}
