plot.number.of.gifts.vs.total.raised.by.campaign <- function() {

  gifts <- get.gifts() %>%
    mutate(Year=year(as_date(flo_gift_date))) %>%
    filter(!(flo_gift_campaign %in% c("2022_satch_squared_rufc", "2022_carwash", "2021_carwash", "2021_belk")))

  tab <- gifts %>%
  mutate(Count=1) %>%
  group_by(flo_gift_campaign) %>%
  summarise(`Number Of Gifts`=sum(Count),
            `Number of Donors`=n_distinct(contact_2_id),Total=sum(flo_gift_amount)) %>%
  arrange(desc(flo_gift_campaign)) %>%
  rename(Campaign = flo_gift_campaign)

  ggplot(tab, aes(`Number Of Gifts`,Total, 
                             label=Campaign)) + geom_text() + 
    ggtitle("Number of Gifts vs Total Raised by Campaign") +
    ylab("Total Raised") + 
    xlab("Number of Gifts") + 
    theme(plot.title = element_text(hjust = 0.5, size = rel(2.5), face = "bold"))
 }
