
<!-- README.md is generated from README.Rmd. Please edit that file -->

# currencyConv

<!-- badges: start -->
<!-- badges: end -->

Use `currencyConv()` to convert values in data.frame from one currency
to another currency.

## Installation

``` r
# install.packages("devtools")
devtools::install_github("ttnsy/currencyConv")
```

## Example

``` r
library(currencyConv)
#> Loading required package: dplyr
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
#> Loading required package: quantmod
#> Loading required package: xts
#> Loading required package: zoo
#> 
#> Attaching package: 'zoo'
#> The following objects are masked from 'package:base':
#> 
#>     as.Date, as.Date.numeric
#> 
#> Attaching package: 'xts'
#> The following objects are masked from 'package:dplyr':
#> 
#>     first, last
#> Loading required package: TTR
#> Registered S3 method overwritten by 'quantmod':
#>   method            from
#>   as.zoo.data.frame zoo
#> Loading required package: jsonlite
## basic example code

x <- data.frame(
  var1 = c(100,200,300),
  var2 = c(200, 99, 350),
  source = c("USD","DKK","USD"),
  target = c("GBP","GBP","GBP")
)

currencyConv(x, "var1") # When source target is not define, it will by default current the sources to GBP
#>      var1 var2 source target
#> 1  76.704  200    USD    GBP
#> 2 153.408   99    DKK    GBP
#> 3 230.112  350    USD    GBP
currencyConv(x, "var1", "source")
#>      var1 var2 source target
#> 1  76.704  200    USD    GBP
#> 2  22.120   99    DKK    GBP
#> 3 230.112  350    USD    GBP
currencyConv(x, "var1",target_currency = "GBP")
#>      var1 var2 source target
#> 1  76.704  200    USD    GBP
#> 2 153.408   99    DKK    GBP
#> 3 230.112  350    USD    GBP
```
