# Information about related software

Information about related software

## Usage

``` r
external_info()
```

## Value

A list with elements:

- `cairo`: The cairo version string.

- `libpng`: The png version string.

- `jpeg`: The jpeg version string.

- `tiff`: The tiff library and version string used.

- `tcl`: The tcl version string.

- `curl`: The curl version string.

- `zlib`: The zlib version string.

- `bzlib`: The zlib version string.

- `xz`: The zlib version string.

- `PCRE`: The Perl Compatible Regular Expressions (PCRE) version string.

- `ICU`: The International Components for Unicode (ICU) version string.

- `TRE`: The TRE version string.

- `iconv`: The iconv version string.

- `readline`: The readline version string.

- `BLAS`: The path with the implementation of BLAS in use.

- `LAPACK`: The path with the implementation of LAPACK in use.

## Details

Note that calling this function will attempt to load the tcltk and
grDevices packages.

## See also

Similar functions and objects in the base packages:
[`utils::sessionInfo()`](https://rdrr.io/r/utils/sessionInfo.html),
[base::extSoftVersion](https://rdrr.io/r/base/extSoftVersion.html),
[`tcltk::tclVersion()`](https://rdrr.io/r/tcltk/TclInterface.html)
[base::La_library](https://rdrr.io/r/base/La_library.html),
[`base::La_version()`](https://rdrr.io/r/base/La_version.html),
[`base::libcurlVersion()`](https://rdrr.io/r/base/libcurlVersion.html).

## Examples

``` r
if (FALSE) {
external_info()
}
```
