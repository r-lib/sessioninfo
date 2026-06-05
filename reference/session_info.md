# Print session information

This is
[`utils::sessionInfo()`](https://rdrr.io/r/utils/sessionInfo.html)
re-written from scratch to both exclude data that's rarely useful (e.g.,
the full collate string or base packages loaded) and include stuff you'd
like to know (e.g., where a package was installed from).

## Usage

``` r
session_info(
  pkgs = c("loaded", "attached", "installed")[1],
  include_base = FALSE,
  info = c("auto", "all", "platform", "packages", "python", "external"),
  dependencies = NA,
  to_file = FALSE
)
```

## Arguments

- pkgs:

  Which packages to show. It may be:

  - `NULL` or `"loaded"`: show all loaded packages,

  - `"attached"`: show all attached packages,

  - `"installed"`: show all installed packages,

  - a character vector of package names. Their (hard) dependencies are
    also shown by default, see the `dependencies` argument.

- include_base:

  Include base packages in summary? By default this is false since base
  packages should always match the R version.

- info:

  What information to show, it can be `"auto"` to choose automatically,
  `"all"` to show everything, or a character vector with elements from:

  - `"platform"`: show platform information via
    [`platform_info()`](https://sessioninfo.r-lib.org/reference/platform_info.md),

  - `"packages"`: show package information via
    [`package_info()`](https://sessioninfo.r-lib.org/reference/package_info.md),

  - `"python"`: show Python configuration via
    [`python_info()`](https://sessioninfo.r-lib.org/reference/python_info.md),

  - `"external"`: show information about external software, via
    [`external_info()`](https://sessioninfo.r-lib.org/reference/external_info.md).

- dependencies:

  Whether to include the (recursive) dependencies as well. See the
  `dependencies` argument of
  [`utils::install.packages()`](https://rdrr.io/r/utils/install.packages.html).

- to_file:

  Whether to print the session information to a file. If `TRUE` the name
  of the file will be `session-info.txt`, but `to_file` may also be a
  string to specify the file name.

## Value

A `session_info` object.

If `to_file` is not `FALSE` then it is returned invisibly. (To print it
to both a file and to the screen, use `(session_info(to_file = TRUE))`.)

## Details

Columns in the *printed* package list:

- `package`: package name

- `*`: whether the package is attached to the search path

- `version`: package version. If the version is marked with `(!)` that
  means that the loaded and the on-disk version of the package are
  different.

- `date`: when the package was built, if this information is available.
  This is the `Date/Publication` or the `Built` field from
  `DESCRIPTION`. (These are usually added automatically by R.) Sometimes
  this data is not available, then it is `NA`.

- `source`: where the package was built or installed from, if available.
  Examples: `CRAN (R 3.3.2)`, `Github (r-lib/pkgbuild@8aab60b)`,
  `Bioconductor`, `local`.

See
[`package_info()`](https://sessioninfo.r-lib.org/reference/package_info.md)
for the list of columns in the data frame that is *returned* (as opposed
to *printed*).

## Examples

``` r
if (FALSE) {
session_info()
session_info("sessioninfo")
}
```
