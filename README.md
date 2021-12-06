
# sessioninfo

> R Session Information

<!-- badges: start -->
[![Lifecycle: stable](https://lifecycle.r-lib.org/articles/figures/lifecycle-stable.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![R build status](https://github.com/r-lib/sessioninfo/workflows/R-CMD-check/badge.svg)](https://github.com/r-lib/sessioninfo/actions)
[![](https://www.r-pkg.org/badges/version/sessioninfo)](https://www.r-pkg.org/pkg/sessioninfo)
[![CRAN RStudio mirror downloads](https://cranlogs.r-pkg.org/badges/sessioninfo)](https://www.r-pkg.org/pkg/sessioninfo)
[![Coverage Status](https://img.shields.io/codecov/c/github/r-lib/sessioninfo/master.svg)](https://codecov.io/github/r-lib/sessioninfo?branch=master)
<!-- badges: end -->

Query and print information about the current R session. It is similar to
`utils::sessionInfo()`, but includes more information about packages, and
where they were installed from.

## Differences from `utils::sessionInfo()`

* Additional platform details: time zone, pandoc version, RStudio version,
  etc.
* Information about package sources, e.g. GitHub repo and hash for packages
  installed from GitHub.
* Highlight package installation problems, e.g. if the loaded and on-disk
  versions are different, if the MD5 checksum of the package DLL is wrong,
  etc.
* Highlight packages from unusual sources.
* Information about external software via `external_info()`.
* Information about the Python configuration is the reticulate package is
  loaded and configured.
* Information about package libraries.
* Compare two session info outputs with the `session_diff()` function.
* Option to show loaded (default), attached or installed packages, or
  the recursive dependencies of the specified packages.

## Installation

```r
install.packages("sessioninfo")
```

## Usage

Example output:

```r
sessioninfo::session_info()
```

<img width="1000" src="https://raw.githubusercontent.com/r-lib/sessioninfo/620d140018fd85c7116517d2c3ab1062f3b356f7/man/figures/session-info.svg">

### Copying to the clipboard

You can use the
[`clipr` package](https://cran.r-project.org/package=clipr) to copy
the session info to the clipboard:

```r
clipr::write_clip(session_info())
```

(The current `clipr` version prints a warning, but you can ignore that.)

### Writing to a file

You can use the `to_file` argument of `session_info()`:

```r
session_info(to_file = "session.log")
```

### External software

```r
sessioninfo::session_info(info = "external")
```

```
═ Session info ═══════════════════════════════════════════════════════════════
─ External software ──────────────────────────────────────────────────────────
 setting        value
 cairo          1.14.12
 cairoFT        2.10.0/2.13.1
 pango
 png            1.6.37
 jpeg           9.4
 tiff           LIBTIFF, Version 4.1.0
 tcl            8.6.6
 curl           7.54.0
 zlib           1.2.11
 bzlib          1.0.6, 6-Sept-2010
 xz             5.2.4
 PCRE           10.34 2019-11-21
 ICU            62.1
 TRE            TRE 0.8.0 R_fixes (BSD)
 iconv          GNU libiconv 1.11
 readline       5.2
 BLAS           /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRblas.0.dylib
 lapack         /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRlapack.dylib
 lapack_version 3.9.0

──────────────────────────────────────────────────────────────────────────────
```

### Python configuration

```r
sessioninfo::session_info(info = "python")
```

```
═ Session info ═══════════════════════════════════════════════════════════════
─ Python configuration ───────────────────────────────────────────────────────
 python:         /Users/gaborcsardi/Library/r-miniconda/envs/r-reticulate/bin/python
 libpython:      /Users/gaborcsardi/Library/r-miniconda/envs/r-reticulate/lib/libpython3.6m.dylib
 pythonhome:     /Users/gaborcsardi/Library/r-miniconda/envs/r-reticulate:/Users/gaborcsardi/Library/r-miniconda/envs/r-reticulate
 version:        3.6.13 | packaged by conda-forge | (default, Sep 23 2021, 07:55:15)  [GCC Clang 11.1.0]
 numpy:          /Users/gaborcsardi/Library/r-miniconda/envs/r-reticulate/lib/python3.6/site-packages/numpy
 numpy_version:  1.19.5

──────────────────────────────────────────────────────────────────────────────
```

### Comparing session information

`session_diff()` can retrieve the session info from an URL or the clipboard
and compare it to the current session information:

```r
sessioninfo::session_diff(new = "https://github.com/r-lib/sessioninfo/issues/6")
```

```diff
--- local
+++ https://github.com/r-lib/sessioninfo/issues/6
  Session info ──────────────────────────────────────────────────────────────────
  setting  value
  version  R version 4.1.1 (2021-08-10)
  os       macOS Mojave 10.14.6
  system   x86_64, darwin17.0
  ui       X11
  language (EN)
  collate  en_US.UTF-8
  ctype    en_US.UTF-8
  tz       Europe/Madrid
  pandoc   2.7.3 @ /usr/local/bin/pandoc

 ─ Packages ─────────────────────────────────────────────────────────────────────
  package     * version     date (UTC) lib source
- asciicast     1.0.0.9000  2021-10-10 [1] local
- cli           3.0.1.9000  2021-10-13 [1] local
+ cachem        1.0.6       2021-08-19 [1] CRAN (R 4.1.0)
+ callr         3.7.0.9000  2021-10-01 [1] Github (r-lib/callr@ea5c3df)
+ cli           3.0.1.9000  2021-10-07 [1] Github (r-lib/cli@e9758aa)
+ clipr         0.7.1       2020-10-08 [1] CRAN (R 4.1.0)
+ commonmark    1.7         2018-12-01 [1] CRAN (R 4.1.0)
  crayon        1.4.1       2021-02-08 [1] CRAN (R 4.1.0)
- curl          4.3.2       2021-06-23 [1] CRAN (R 4.1.0)
  desc          1.4.0.9000  2021-10-04 [1] local
+ devtools      2.4.2       2021-06-07 [1] CRAN (R 4.1.0)
+ digest        0.6.28      2021-09-23 [1] CRAN (R 4.1.0)
  ellipsis      0.3.2       2021-04-29 [1] CRAN (R 4.1.0)
  fansi         0.5.0       2021-05-25 [1] CRAN (R 4.1.0)
+ fastmap       1.1.0       2021-01-25 [1] CRAN (R 4.1.0)
+ fs            1.5.0       2020-07-31 [1] CRAN (R 4.1.0)
  glue          1.4.2       2021-10-04 [1] local
- jsonlite      1.7.2       2020-12-09 [1] CRAN (R 4.1.0)
+ knitr         1.34        2021-09-09 [1] CRAN (R 4.1.0)
  lifecycle     1.0.1       2021-09-24 [1] CRAN (R 4.1.0)
  magrittr      2.0.1       2020-11-17 [1] CRAN (R 4.1.0)
+ memoise       2.0.0       2021-01-26 [1] CRAN (R 4.1.0)
  pillar        1.6.3       2021-09-26 [1] CRAN (R 4.1.1)
+ pkgbuild      1.2.0       2020-12-15 [1] CRAN (R 4.1.0)
  pkgconfig     2.0.3       2019-09-22 [1] CRAN (R 4.1.0)
  pkgload       1.2.2       2021-09-11 [1] CRAN (R 4.1.0)
  prettycode    1.1.0       2019-12-16 [1] CRAN (R 4.1.0)
+ prettyunits   1.1.1       2020-01-24 [1] CRAN (R 4.1.0)
  processx      3.5.2.9000  2021-09-15 [1] local
  prompt        1.0.0       2021-03-02 [1] local
  ps            1.6.0       2021-02-28 [1] CRAN (R 4.1.0)
+ purrr         0.3.4       2020-04-17 [1] CRAN (R 4.1.0)
  R6            2.5.1       2021-08-19 [1] CRAN (R 4.1.0)
- Rcpp          1.0.7       2021-07-07 [1] CRAN (R 4.1.0)
- rlang         0.4.11      2021-04-30 [1] CRAN (R 4.1.0)
+ remotes       2.4.0       2021-06-02 [1] CRAN (R 4.1.0)
+ rlang         0.99.0.9000 2021-10-07 [1] Github (r-lib/rlang@3ba19df)
+ roxygen2      7.1.2       2021-10-04 [1] local
  rprojroot     2.0.2       2020-11-15 [1] CRAN (R 4.1.0)
- sessioninfo * 1.1.1.9000  2021-10-13 [?] load_all()
- testthat    * 3.1.0       2021-10-04 [1] CRAN (R 4.1.0)
- tibble        3.1.5       2021-09-30 [1] CRAN (R 4.1.0)
+ rstudioapi    0.13        2020-11-12 [1] CRAN (R 4.1.0)
+ sessioninfo * 1.1.1.9000  2021-10-05 [?] load_all()
+ stringi       1.7.4       2021-08-25 [1] CRAN (R 4.1.0)
+ stringr       1.4.0       2019-02-10 [1] CRAN (R 4.1.0)
+ testthat    * 3.0.4       2021-07-01 [1] CRAN (R 4.1.0)
+ tibble        3.1.4       2021-08-25 [1] CRAN (R 4.1.0)
+ usethis       2.0.1       2021-02-10 [1] CRAN (R 4.1.0)
  utf8          1.2.2       2021-07-24 [1] CRAN (R 4.1.0)
- uuid          0.1-4       2020-02-26 [1] CRAN (R 4.1.0)
- V8            3.4.2       2021-05-01 [1] CRAN (R 4.1.0)
  vctrs         0.3.8       2021-04-29 [1] CRAN (R 4.1.0)
  withr         2.4.2       2021-04-18 [1] CRAN (R 4.1.0)
+ xfun          0.26        2021-09-14 [1] CRAN (R 4.1.0)
+ xml2          1.3.2       2020-04-23 [1] CRAN (R 4.1.0)

  [1] /Users/gaborcsardi/Library/R/x86_64/4.1/library
  [2] /Library/Frameworks/R.framework/Versions/4.1/Resources/library
```

## License

GPL-2
