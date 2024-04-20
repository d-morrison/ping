#' Import ping data
#'
#' @param file path to a file containing ping data
#' @param start_time optional start time to align the data
#'
#' @returns a [tibble::tibble()]
#' @export
#'
#' @examples
#' data1 =
#' fs::path_package(
#'   package = "ping",
#'   "extdata/data_2023-11-20.txt") |>
#' process_pings_file()
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
        replacement = "\\1") |> strsplit(" ") |> unlist()

    start_time = lubridate::hms(start_time[3])

    # month = start_time[1] |>
    # day = start_time[2]

    start_time = lubridate::today() + start_time
  }

  ping = tibble::tibble(
    time = start_time + (1:length(temp) |> lubridate::seconds()),
    # note: man ping says default is 1 second between pings; couldn't find a way to timestamp send times, only receive times.
    ping =
      dplyr::if_else(
        grepl(fixed = TRUE,
              pattern = "Request timeout",
              x = temp) |
          grepl(fixed = TRUE,
                pattern = "ping: cannot resolve",
                x = temp)
          ,
        Inf,
        gsub(".*time=(.*) ms", "\\1", temp) |> as.numeric() |> suppressWarnings()
      ),
    `1/ping (ms)` = 1/ping,
    gap = c(FALSE, ping[-length(ping)] |> is.infinite())
  )
}
