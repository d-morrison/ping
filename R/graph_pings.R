#' Graph pings
#'
#' @param ping a [data.frame()] from [process_pings_file()]
#'
#' @returns a [ggplot2::ggplot()]
#' @export
#'
#' @examples
#' #' data1 =
#' fs::path_package(
#'   package = "ping",
#'   "extdata/data_2023-11-20.txt") |>
#' process_pings_file()
#' graph_pings(data1)
graph_pings = function(ping)
{
  library(ggplot2)
  plot1 = ggplot(ping, aes(x = time, y = ping)) +
    # scale_y_continuous(trans = scales::reciprocal_trans()) +
    geom_point() +
    geom_line() +
    xlab('time ping sent (approx)')

  plot1

}
