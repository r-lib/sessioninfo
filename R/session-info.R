
#' Print session information
#'
#' This is [base::sessionInfo()] re-written from scratch to both exclude
#' data that's rarely useful (e.g., the full collate string or base packages
#' loaded) and include stuff you'd like to know (e.g., where a package was
#' installed from).
#'
#' @details
#' Columns in the *printed* package list:
#' * `package`: package name
#' * `*`: whether the package is attached to the search path
#' * `version`: package version
#' * `date`: when the package was built, if this information is available.
#'   This is the `Date/Publication` or the `Built` field from
#'   `DESCRIPTION`. (These are usually added automatically by R.)
#'   Sometimes this data is not available, then it is `NA`.
#' * `source`: where the package was built or installed from, if available.
#'   Examples: `CRAN (R 3.3.2)`, `Github (r-lib/pkgbuild@8aab60b)`,
#'   `Bioconductor`, `local`.
#'
#' See [package_info()] for the list of columns in the data frame that
#' is *returned* (as opposed to *printed*).
#'
#' @inheritParams package_info
#' @export
#' @examples
#' session_info()
#' session_info("sessioninfo")

session_info <- function(pkgs = NULL, include_base = FALSE) {
  structure(
    list(
      platform = platform_info(),
      packages = package_info(pkgs, include_base = include_base)
    ),
    class = "session_info"
  )
}

#' @export

as.character.session_info <- function(x, ...) {
  c(rule("Session info"),
    as.character(x$platform),
    "",     # empty line
    rule("Packages"),
    as.character(x$packages)
  )
}
#' @export

print.session_info <- function(x, ...) {
  cat(as.character(x), sep = "\n")
}
