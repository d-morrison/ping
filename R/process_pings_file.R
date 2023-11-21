process_pings_file = function(file, start_time = NULL)
{
  all_data = file |> readLines()
  temp = all_data[-(1:3)]
  if(is.null(start_time))
  {

    start_time =
      all_data[1] |>
      sub(
        # pattern = "([[:digit:]]{2}\\:[[:digit:]]{2}\\:[[:digit:]]{2}).*",
        pattern = "^Last login\\: [[:alpha:]]+ (.*) on .*$",
        replacement = "\\1") |> strsplit(" ") |> unlist() |> print()

    # month = start_time[1] |>
    # day = start_time[2]
    library(lubridate)
    start_time = today() + hours(14)
  }

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
}
