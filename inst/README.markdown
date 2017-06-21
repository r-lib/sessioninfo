
# sessioninfo

> R Session Information

[![Linux Build Status](https://travis-ci.org/r-lib/sessioninfo.svg?branch=master)](https://travis-ci.org/r-lib/sessioninfo)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/github/r-lib/sessioninfo?svg=true)](https://ci.appveyor.com/project/gaborcsardi/sessioninfo)
[![](http://www.r-pkg.org/badges/version/sessioninfo)](http://www.r-pkg.org/pkg/sessioninfo)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/sessioninfo)](http://www.r-pkg.org/pkg/sessioninfo)
[![Coverage Status](https://img.shields.io/codecov/c/github/r-lib/sessioninfo/master.svg)](https://codecov.io/github/r-lib/sessioninfo?branch=master)

Query and print information about the current R session. It is similar to
`utils::sessionInfo()`, but includes more information about packages, and
where they were installed from.

## Installation

```r
devtools::install_github("r-lib/sessioninfo")
```

## Usage

Example output:

```r
sessioninfo::session_info()
```

```r
─ Session info ───────────────────────────────────────────────────────────────
 setting  value
 version  R version 3.3.3 (2017-03-06)
 os       OS X Yosemite 10.10.5
 system   x86_64, darwin13.4.0
 ui       X11
 language (EN)
 collate  en_US.UTF-8
 tz       Europe/London
 date     2017-04-21

─ Packages ───────────────────────────────────────────────────────────────────
 package       * version     date       source
 backports       1.0.5       2017-01-18 CRAN (R 3.3.2)
 BiocInstaller * 1.24.0      2016-10-18 Bioconductor
 clisymbols      1.1.0       2017-01-27 CRAN (R 3.3.2)
 covr            2.2.2       2017-01-05 CRAN (R 3.3.2)
 crayon          1.3.2       2016-06-28 CRAN (R 3.3.0)
 devtools        1.12.0.9000 2017-04-13 Github (hadley/devtools@ab176e6)
 digest          0.6.12      2017-01-27 CRAN (R 3.3.2)
 gitty           1.0.0       2017-03-19 Github (gaborcsardi/gitty@67a6e3e)
 lazyeval        0.2.0       2016-06-12 CRAN (R 3.3.0)
 magrittr        1.5         2014-11-22 CRAN (R 3.3.0)
 memoise         1.1.0       2017-04-21 cran (@1.1.0)
 mockery         0.3.0       2016-12-16 CRAN (R 3.3.2)
 parr            3.3.0       2017-03-19 Github (gaborcsardi/parr@3a2564e)
 pkgbuild        0.0.0.9000  2017-04-13 Github (r-lib/pkgbuild@8aab60b)
 pkgload         0.0.0.9000  2017-04-13 Github (r-lib/pkgload@9093b96)
 praise          1.0.0       2015-08-11 CRAN (R 3.3.0)
 prettycode    * 1.0.0       2017-01-27 CRAN (R 3.3.2)
 prompt          1.0.0       2017-03-19 Github (gaborcsardi/prompt@5327667)
 R6              2.2.0       2016-10-05 CRAN (R 3.3.0)
 rex             1.1.1       2016-03-11 CRAN (R 3.3.0)
 rprojroot       1.2         2017-01-16 CRAN (R 3.3.2)
 rstudioapi      0.6         2016-06-27 CRAN (R 3.3.0)
 sessioninfo   * 0.0.0.9000  <NA>       local
 testthat      * 1.0.2.9000  2017-04-13 Github (hadley/testthat@b72a228)
 tracer        * 1.0.0       2017-03-19 Github (gaborcsardi/tracer@053bf79)
 whisker         0.3-2       2013-04-28 CRAN (R 3.3.0)
 withr           1.0.2       2016-06-20 CRAN (R 3.3.0)
```

### Copying to the clipboard

You can use the
[`clipr` package](https://cran.rstudio.com/web/packages/clipr/) to copy
the session info to the clipboard:

```r
clipr::write_clip(session_info())
```

(The current `clipr` version prints a warning, but you can ignore that.)

## License

GPL-2
