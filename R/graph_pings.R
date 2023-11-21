graph_pings = function(ping)
{
  library(ggplot2)
  plot1 = ggplot(ping, aes(x = time, y = ping)) +
    # scale_y_continuous(trans = scales::reciprocal_trans()) +
    geom_point() +
    geom_line() +
    xlab('time ping sent (approx)')

  plot1 |>  plotly::ggplotly() |> print()
  usethis::use_data(ping, overwrite = TRUE)

}
