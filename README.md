# cransays

<!-- badges: start -->
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
![Dashboard status](https://github.com/llrs/crandeadlines/workflows/Render-dashboard/badge.svg)
[![R-CMD-check](https://github.com/llrs/crandeadlines/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/llrs/crandeadlines/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of crandeadlines is to retrieve the CRAN deadlines of packages, to find each deadline is, and to 
make a [dashboard](https://llrs.github.io/crandeadlines/articles/dashboard.html).

## Installation

``` r
remotes::install_github("llrs/crandeadlines")
```

## Example

This is a basic example :

``` r
cran_outgoing <- crandeadlines::take_snapshot()
```

The vignette produces a [handy dashboard](https://llrs.github.io/crandeadlines/articles/dashboard.html) that we update every hour via [GitHub Actions](https://github.com/llrs/crandeadlines/actions).

## Historical data

Hourly snapshots of the ftp server are saved in the [`history` branch](https://github.com/llrs/crandeadlines/tree/history), as part of our [rendering workflow](https://github.com/llrs/crandeadlines/blob/c54ec4bf7c05e9c91510176dd933d103b59a6779/.github/workflows/render-dashboard.yml#L48-L67). 
A short script to load this historical data as a `data.frame` is also provided in the package:

``` r
historical_data <- crandeadlines::download_history()
```

## Related work

* Using code originally adapted from https://github.com/r-hub/cransays and 

* Code adapted from https://github.com/hadley/cran-deadlines


## Contributing

Wanna report a bug or suggest a feature? Great stuff! For more information on how to contribute check out [our contributing guide](.github/CONTRIBUTING.md). 

Please note that this R package is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this package project you agree to abide by its terms.

