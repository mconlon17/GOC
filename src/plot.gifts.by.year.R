plot.gifts.by.year <- function(date) {
  # plot bar chart of gifts by date. to include the ciurrent partial year, pass a date in next year

  end_date <- floor_date(date, "year") - days(1)

  gifts <- get.gifts() %>%
    filter(flo_gift_date <= end_date)

  tab <- gifts %>%
    mutate(Year = year(as_date(flo_gift_date))) %>%
    group_by(Year) %>%
    summarise(`Yearly Total` = sum(flo_gift_amount))

  # ft <- flextable(tab) %>%
  #     autofit() %>%
  #     colformat_num(j = 2, big.mark = ",", prefix = "$") %>%
  #     colformat_num(j = 1, big.mark = "")
  # ft

  ggplot(tab, aes(`Year`, weight = `Yearly Total`)) +
    geom_bar(fill = "#79B956") +
    ggtitle("Gifts by Year") +
    ylab("Dollars") +
    theme(plot.title = element_text(hjust = 0.5, size = rel(2.5), face = "bold"))
}
