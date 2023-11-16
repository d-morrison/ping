temp = readLines("inst/extdata/ping_data.txt")

library(dplyr)
ping = tibble(
  obs = 1:length(temp),
  ping = if_else(
    grepl(fixed = TRUE, pattern = "Request timeout",x = temp),
    Inf,
    gsub(".*time=(.*) ms", "\\1", temp) |> as.numeric()
  ),
  `1/ping (ms)` = 1/ping,
  gap = c(FALSE, ping[-length(ping)] |> is.infinite())
)

library(ggplot2)
ggplot(ping, aes(x = obs, y = ping, col = gap, group = 1)) +
  # scale_y_continuous(trans = scales::reciprocal_trans()) +
  geom_point() +
  geom_line()

usethis::use_data(ping, overwrite = TRUE)
