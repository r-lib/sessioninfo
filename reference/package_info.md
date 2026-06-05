# Information about the currently loaded packages, or about a chosen set

Information about the currently loaded packages, or about a chosen set

## Usage

``` r
package_info(
  pkgs = c("loaded", "attached", "installed")[1],
  include_base = FALSE,
  dependencies = NA
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

- dependencies:

  Whether to include the (recursive) dependencies as well. See the
  `dependencies` argument of
  [`utils::install.packages()`](https://rdrr.io/r/utils/install.packages.html).

## Value

A data frame with columns:

- `package`: package name.

- `ondiskversion`: package version (on the disk, which is sometimes not
  the same as the loaded version).

- `loadedversion`: package version. This is the version of the loaded
  namespace if `pkgs` is `NULL`, and it is the version of the package on
  disk otherwise. The two of them are almost always the same, though.

- `path`: path to the package on disk.

- `loadedpath`: the path the package was originally loaded from.

- `attached`: logical, whether the package is attached to the search
  path.

- `is_base`: logical, whether the package is a base package.

- `date`: the date the package was installed or built, in UTC.

- `source`: where the package was installed from. E.g. `CRAN`, `GitHub`,
  `local` (from the local machine), etc.

- `md5ok`: Whether MD5 hashes for package DLL files match, on Windows.
  `NA` on other platforms.

- `library`: factor, which package library the package was loaded from.
  For loaded packages, this is (the factor representation of)
  `loadedpath`, for others `path`.

See
[`session_info()`](https://sessioninfo.r-lib.org/reference/session_info.md)
for the description of the *printed* columns by `package_info` (as
opposed to the *returned* columns).

## Examples

``` r
if (FALSE) {
package_info()
package_info("sessioninfo")
}
```
