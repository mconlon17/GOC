plot.active.members.over.time <- function(start_date = "2022-01-01") {
  if (as_date(start_date) == as_date(Sys.Date())) {
    start_date <- start_date - days(365) # if the widget is set to today, show a plot of one year's duration
  }
  ndays <- as.integer(as_date(Sys.Date()) - as_date(start_date)) + 1
  
  progress <- shiny::Progress$new()
  on.exit(progress$close())
  progress$set(message = "Getting Members", value = 0)

  contacts <- get.contacts() %>%
    filter(grepl("Member", c2_groups))
  
  progress$set(message = "Getting Attendance", value = 0.1)

  member.attendance <- get.attendance(days = ndays) %>%
    inner_join(contacts, by = c("contact_2_id" = "id")) %>% # Inner join must be a Member with attendance
    select(contact_2_id, da_date_of_attendance)
  
  progress$set(message = "Counting Active Members", value = 0.2)

  dates <- seq(from = as_date(start_date), to = Sys.Date() - 7, by = "weeks")
  ndates <- length(dates)

  active.members <- c()
  for (date in dates) {
    n <- nrow(member.attendance %>%
      mutate(Since = as_date(date) - as_date(da_date_of_attendance)) %>%
      group_by(contact_2_id) %>%
      summarise(MostRecent = min(abs(Since))) %>%
      filter(MostRecent < 90)) # Active members on the date
    active.members <- c(active.members, n)
    
    progress$inc(0.8*(1 / ndates), detail = format(as_date(date), "%Y %b %d"))
  }
  active <- data.frame(dates = dates, active.members = active.members)

  average <- mean(active$active.members)


  active %>% ggplot(aes(x = dates, y = active.members)) +
    geom_line() +
    geom_vline(color = "darkgrey", xintercept = seq(as_date(start_date), Sys.Date(), by = "quarter")) +
    geom_hline(color = "blue", yintercept = average) +
    ggtitle(paste0("Active Members from ", start_date, "\nAverage Active Members = ", format(average, digits = 3))) +
    theme(plot.title = element_text(hjust=0.5, size=20, face="bold")) + 
    ylab("Active Members")
}
