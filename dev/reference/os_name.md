# Human readable name of the current operating system

For example Windows 8.1 instead of Windows version 6.3.9600. On macOS it
includes the code names, on Linux it includes the distribution names and
codenames if appropriate.

## Usage

``` r
os_name()
```

## Value

A character scalar.

## Details

It uses
[`utils::sessionInfo()`](https://rdrr.io/r/utils/sessionInfo.html), but
simplifies its output a bit on Windows, to make it more concise.
