# Information about the current platform

Information about the current platform

## Usage

``` r
platform_info()
```

## Value

A list with elements:

- `version`: the R version string.

- `os`: the OS name in human readable format, see
  [`os_name()`](https://sessioninfo.r-lib.org/reference/os_name.md).

- `system`: CPU, and machine readable OS name, separated by a comma.

- `ui`: the user interface, e.g. `Rgui`, `RTerm`, etc. see `GUI` in
  [base::.Platform](https://rdrr.io/r/base/Platform.html).

- `hostname`: the name of the machine known on the network, see
  `nodename` in
  [`base::Sys.info()`](https://rdrr.io/r/base/Sys.info.html). For
  privacy, it is only included if the `sessioninfo.include_hostname`
  option is set to `TRUE`.

- `language`: The current language setting. The `LANGUAGE` environment
  variable, if set, or `(EN)` if unset.

- `collate`: Collation rule, from the current locale.

- `ctype`: Native character encoding, from the current locale.

- `tz`: The current time zone.

- `date`: The current date.

- `rstudio`: RStudio format string, only added in RStudio.

- `pandoc`: pandoc version and path

- `quarto`: quarto version and path

## See also

Similar functions and objects in the base packages:
[base::R.version.string](https://rdrr.io/r/base/Version.html),
[`utils::sessionInfo()`](https://rdrr.io/r/utils/sessionInfo.html),
[base::version](https://rdrr.io/r/base/Version.html),
[base::.Platform](https://rdrr.io/r/base/Platform.html),
[`base::Sys.getlocale()`](https://rdrr.io/r/base/locales.html),
[`base::Sys.timezone()`](https://rdrr.io/r/base/timezones.html).

## Examples

``` r
if (FALSE) {
platform_info()
}
```
