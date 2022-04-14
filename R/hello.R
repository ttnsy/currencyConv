currencyConv <- function(
  data,
  vars,
  source_currency_column = NULL,
  target_currency_column = NULL,
  source_currency = NULL,
  target_currency = "GBP"
){
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
