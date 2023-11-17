# get data from "ping ucdavis.edu" or similar
temp = readLines("inst/extdata/ping_data.txt")
library(lubridate)
start_time = today() + hours(14)
library(dplyr)
ping = tibble(
  time = start_time + (1:length(temp) |> lubridate::seconds()),
  # note: man ping says default is 1 second between pings; couldn't find a way to timestamp send times, only receive times.
  ping = if_else(
    grepl(fixed = TRUE, pattern = "Request timeout",x = temp),
    Inf,
    gsub(".*time=(.*) ms", "\\1", temp) |> as.numeric()
  ),
  `1/ping (ms)` = 1/ping,
  gap = c(FALSE, ping[-length(ping)] |> is.infinite())
)

library(ggplot2)
plot1 = ggplot(ping, aes(x = time, y = ping)) +
  # scale_y_continuous(trans = scales::reciprocal_trans()) +
  geom_point() +
  geom_line() +
  xlab('time ping sent (approx)')

plot1 |>  plotly::ggplotly() |> print()
usethis::use_data(ping, overwrite = TRUE)
