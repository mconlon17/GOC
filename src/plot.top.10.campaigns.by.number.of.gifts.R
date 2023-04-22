plot.top.10.campaigns.by.number.of.gifts <- function() {
  gifts <- get.gifts() %>%
    mutate(Year=year(as_date(flo_gift_date))) %>%
    filter(!(flo_gift_campaign %in% c("2022_satch_squared_rufc", "2022_carwash", "2021_carwash", "2021_belk")))

  tab <- gifts %>%
    mutate(Count=1) %>%
    group_by(flo_gift_campaign) %>%
    summarise(`Number of Gifts`=sum(Count),
            `Number of Donors`=n_distinct(contact_2_id),Total=sum(flo_gift_amount)) %>%
    arrange(desc(`Number of Gifts`)) %>%
    top_n(10) %>%
    rename(Campaign = flo_gift_campaign)

  dat <- tab
  dat$fraction = dat$`Number of Gifts` / sum(dat$`Number of Gifts`)
  dat = dat[order(dat$fraction), ]
  dat$ymax = cumsum(dat$fraction)
  dat$ymin = c(0, head(dat$ymax, n=-1))
  
  ggplot(dat, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill = Campaign)) +
    geom_rect(colour="grey30") +
    coord_polar(theta = "y") +
    theme_bw() +
    xlim(c(0,4)) +
    theme(axis.ticks=element_blank()) +
    theme(axis.text=element_blank()) +
    theme(panel.grid=element_blank()) +
    ggtitle("Top 10 Campaigns by Number of Gifts") + xlab("") + ylab("") + 
    theme(plot.title = element_text(hjust = 0.5, size = rel(2.5), face = "bold"))
}
