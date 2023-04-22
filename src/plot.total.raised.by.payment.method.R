plot.total.raised.by.payment.method <- function (date=Sys.Date()) {

  gifts <- get.gifts() %>%
    mutate(Year=year(as_date(flo_gift_date)))

  tab <- gifts %>%
  mutate(Count=1) %>%
  group_by(flo_gift_campaign) %>%
  summarise(`Number Of Donations`=sum(Count),
            `Number of Donors`=n_distinct(contact_2_id),Total=sum(flo_gift_amount)) %>%
  arrange(desc(flo_gift_campaign)) %>%
  rename(Campaign = flo_gift_campaign)
 
  ggplot(gifts, aes(x=reorder(flo_gift_payment_method, 
                            flo_gift_amount, function(x) sum(x)))) +
    geom_bar(aes(weight=flo_gift_amount), fill="red") + 
    ggtitle("Total Raised by Payment Method") +
    ylab("Total Dollars Raised") + 
    xlab("Payment Method") +
    theme(plot.title = element_text(hjust = 0.5, size = rel(2.5), face = "bold"))
}