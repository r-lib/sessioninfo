
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

## License

GPL-2
