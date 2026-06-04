# Python configuration

Python configuration

## Usage

``` r
python_info()
```

## Value

Returns a
[reticulate::py_config](https://rstudio.github.io/reticulate/reference/py_config.html)
object, which also has the `python_info` class. It is a named list of
values.

If reticulate is not installed or Python is not configured, then it
return a `python_info` object that is a character vector, and it does
not have a `py_config` class.

## Examples

``` r
if (FALSE) {
python_info()
session_info(info = "all")
}
```
