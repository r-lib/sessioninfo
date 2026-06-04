# Compare session information from two sources

Compare session information from two sources

## Usage

``` r
session_diff(
  old = "local",
  new = "clipboard",
  packages = c("diff", "merge"),
  ...
)
```

## Arguments

- old, new:

  A `session_info` object (the return value of
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)),
  or a pointer to
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  output. See details below.

- packages:

  How to compare the package info for `old` and `new`:

  - `"diff"`: line diffs, in the style of `diff -u`

  - `"merge"`: merge the information into one data frame, with one row
    per package. Only package `version` and `source` are compared.

- ...:

  Passed to any new
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  calls.

## Details

Various way to specify `old` and `new`:

- A `session_info` object.

- `"local"` runs
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  in the current session, and uses its output.

- `"clipboard"` takes the session info from the system clipboard. If the
  clipboard contains a URL, it is followed to download the session info.

- The URL where you inspect the results for a GitHub Actions job.
  Typically has this form:

      https://github.com/OWNER/REPO/actions/runs/RUN_ID/jobs/HTML_ID

  Internally, this URL is parsed so we can look up the job id, get the
  log file, and extract session info.

- Any other URL starting with `http://` or `https://`. `session_diff()`
  searches the HTML (or text) page for the session info header to find
  the session info.

## Examples

``` r
if (FALSE) {
session_diff()
}
```
