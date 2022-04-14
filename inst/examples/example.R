x <- data.frame(
  var1 = c(100,200,300),
  var2 = c(200, 99, 350),
  source = c("USD","DKK","USD"),
  target = c("GBP","GBP","GBP")
)

currencyConv(x, "var1")
currencyConv(x, "var1", "source")
currencyConv(x, "var1",target_currency = "GBP")
