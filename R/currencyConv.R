#' Convert numeric column from one currency to another currency.
#'
#' @param data A dataframe with values to be converted.
#' @param vars A list containing column names of source values.
#' @param source_currency_column A character vector of the source currency's column name. (No need to define if the `source_currency` is filled)
#' @param target_currency_column A character vector of the target currency's column name. (No need to define if the `target_currency` is filled)
#' @param source_currency A character vector defining the source currency.
#' @param target_currency A character vector defining the target currency. If empty, it will convert values to GBP.
#'
#' @return A dataframe.
#' @export
#'
#' @example inst/examples/example.R
#' @import dplyr
#' @import quantmod
#' @import jsonlite

currencyConv <- function(
  data,
  vars,
  source_currency_column = NULL,
  target_currency_column = NULL,
  source_currency = NULL,
  target_currency = "GBP"
){
  rate=Last=NULL
  data <- as.data.frame(data)

  if(is.null(source_currency_column)){
    from <- source_currency
  } else {
    from <- pull(data, source_currency_column)
  }

  if(is.null(target_currency_column)){
    to <- target_currency
  } else {
    to <- pull(data, target_currency_column)
  }

  out <- tibble(
    from = from,
    to = to
  )  %>%
    mutate(
      getQuote(paste0(from, to, "=X"))[paste0(from, to, "=X"), ] %>%
        select(rate = Last)
    ) %>%
    select(rate) %>%
    cbind(data) %>%
    mutate_at(vars, ~ ifelse(is.na(rate), ., (. * rate))) %>%
    select(-rate)
  return(out)
}
