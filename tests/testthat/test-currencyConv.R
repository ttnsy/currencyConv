testthat::test_that("gives correct conversion",{
  data <- data.frame(
    var1 = c(200, 100, 300),
    var2 = c(400, 100, 0),
    currency_source = c("USD","DKK","USD"),
    currency_target = c("GBP", "GBP", "GBP")
  )

  data_y <- tibble(
    from = data$currency_source,
    to = "GBP"
  )  %>%
    mutate(
      getQuote(paste0(from, to, "=X"))[paste0(from, to, "=X"), ] %>%
        select(rate = Last)
    ) %>%
    select(rate) %>%
    cbind(data) %>%
    mutate_at(c("var1", "var2"), ~ ifelse(is.na(rate), ., (. * rate))) %>%
    select(-rate)

  expect_equal(currencyConv(data, c("var1","var2"), "currency_source"), data_y)

})
