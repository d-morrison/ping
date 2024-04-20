#' `autoplot()` method for `"pings"` objects
#'
#' @param object a `"pings"` object created using [process_pings_file()]
#' @param filepath [character()] path to a .txt file containing ping data
#' @returns a [ggplot2::ggplot()]
#' @export
#'
#' @examples
#' fs::path_package(
#'   package = "ping",
#'   "extdata/data_2023-11-20.txt") |>
#' process_pings_file() |>
#' autoplot(data1)
autoplot.pings = function(
    object,
    log_y = FALSE,
    ...)
{
  plot1 = ping |>
    ggplot2::ggplot(ggplot2::aes(x = time, y = ping)) +
    # scale_y_continuous(trans = scales::reciprocal_trans()) +
    ggplot2::geom_point() +
    ggplot2::geom_line() +
    ggplot2::xlab('time ping sent (approx)')

  if(log_y)
    plot1 = plot1 +
      ggplot2::scale_y_log10()

  return(plot1)

}
