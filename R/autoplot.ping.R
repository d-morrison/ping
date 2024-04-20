#' `autoplot()` method for `"pings"` objects
#'
#' @param log_y whether to display the y axis with logarithmic spacing
#' @param ... unused
#' @param object a `"pings"` object created using [process_pings_file()]
#'
#' @returns a [ggplot2::ggplot()]
#' @export
#'
#' @examples
#' fs::path_package(
#'   package = "ping",
#'   "extdata/data_2023-11-20.txt") |>
#' process_pings_file() |>
#' autoplot()
autoplot.pings = function(
    object,
    log_y = FALSE,
    ...)
{
  plot1 = object |>
    ggplot2::ggplot(ggplot2::aes(x = .data$time, y = .data$ping)) +
    # scale_y_continuous(trans = scales::reciprocal_trans()) +
    ggplot2::geom_point() +
    ggplot2::geom_line() +
    ggplot2::ylab("ping (ms)") +
    ggplot2::xlab('time ping sent (approx)') +
    ggplot2::theme_bw()

  if(log_y)
  {
    plot1 = plot1 +
      ggplot2::scale_y_log10(labels = scales::comma)

  } else
  {
    plot1 = plot1 +
      ggplot2::scale_y_continuous(labels = scales::comma)
  }
  return(plot1)

}

#' @export
#' @importFrom ggplot2 autoplot
ggplot2::autoplot
