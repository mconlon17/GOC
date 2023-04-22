get.ada <- function(days=30) {
  attendance <- get.attendance(days=days*1.5) %>%
    mutate(date_of_attendance=as_datetime(da_date_of_attendance))
   
  contacts <- get.contacts() %>%
    filter(grepl("Member", c2_groups)) 

  attendance <- attendance %>%
     inner_join(contacts, by = c("contact_2_id" = "id"))  

  attendance <- attendance %>%  
    group_by(date_of_attendance) %>%
    tally() %>%
    filter(wday(date_of_attendance) >1 & wday(date_of_attendance) <7) %>%
    arrange(desc(date_of_attendance)) %>%
    top_n(days, date_of_attendance)

  ada <- mean(attendance$n)
  ada
}
