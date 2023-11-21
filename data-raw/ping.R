load_all()
library(plotly)
# get data from "ping ucdavis.edu" or similar

# ping = process_pings_file("inst/extdata/ping_data.txt")

ping = process_pings_file(
  file = "inst/extdata/ping_data.txt",
  start_time = lubridate::as_datetime("2023-11-17 10:08:45")
)

ping |> graph_pings()


ping = process_pings_file(
  file = "inst/extdata/data_2023-11-20.txt",
  start_time = lubridate::as_datetime("2023-11-20 10:08:45")
)

ping |> graph_pings()

ping = process_pings_file(
  file = "inst/extdata/zoom_call_2023-11-21.txt",
  start_time = lubridate::as_datetime("2023-11-20 10:08:45")
)

ping |> graph_pings()


ping = process_pings_file(
  file = "inst/extdata/after-restart-2023-11-21.txt",
  start_time = lubridate::as_datetime("2023-11-21 14:16:02")
)

ping |> graph_pings() |> plotly::ggplotly()

