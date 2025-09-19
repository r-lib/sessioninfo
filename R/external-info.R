#' Information about related software
#'
#' @details
#' Note that calling this function will attempt to load the tcltk and
#' grDevices packages.
#'
#' @return A list with elements:
#'   * `cairo`: The cairo version string.
#'   * `libpng`: The png version string.
#'   * `jpeg`: The jpeg version string.
#'   * `tiff`: The tiff library and version string used.
#'   * `tcl`: The tcl version string.
#'   * `curl`: The curl version string.
#'   * `zlib`: The zlib version string.
#'   * `bzlib`: The zlib version string.
#'   * `xz`: The zlib version string.
#'   * `PCRE`: The Perl Compatible Regular Expressions (PCRE) version string.
#'   * `ICU`: The International Components for Unicode (ICU) version string.
#'   * `TRE`: The TRE version string.
#'   * `iconv`: The iconv version string.
#'   * `readline`: The readline version string.
#'   * `BLAS`: The path with the implementation of BLAS in use.
#'   * `LAPACK`: The path with the implementation of LAPACK in use.
#'
#'
#' @seealso Similar functions and objects in the base packages:
#'   [utils::sessionInfo()], [base::extSoftVersion], [tcltk::tclVersion()]
#'   [base::La_library], [base::La_version()], [base::libcurlVersion()].
#'
#' @export
#' @examplesIf FALSE
#' external_info()

external_info <- function() {
  ex <- c(
    get_grsoft_version(),
    tcl = get_tcl_version(),
    curl = libcurlVersion(),
    rtools = get_rtools_version(),
    extSoftVersion()
  )
  ex["lapack"] <- get_la_library()
  ex["lapack_version"] <- get_la_version()
  names(ex) <- gsub("^lib", "", names(ex))

  structure(as.list(ex), class = c("external_info", "list"))
}

get_tcl_version <- function() {
  tryCatch(
    suppressWarnings(tcltk::tclVersion()),
    error = function(err) ""
  )
}

get_grsoft_version <- function() {
  grDevices::grSoftVersion()
}

get_la_library <- function() {
  tryCatch(base::La_library(), error = function(err) NA_character_)
}

get_la_version <- function() {
  tryCatch(base::La_version(), error = function(err) NA_character_)
}

get_rtools_version <- function() {

  if (!requireNamespace("pkgbuild", quietly = TRUE)) {
    return()
  }

  # Currently no way to get version directly, see <https://github.com/r-lib/pkgbuild/issues/214>
  tryCatch(
    gsub(
      ".+ ([0-9.]+).+",
      "\\1",
      utils::capture.output(pkgbuild::find_rtools(debug = TRUE))[1]
    ),
    error = function(err) NA_character_)

}

#' @export

format.external_info <- function(x, ...) {
  df <- data.frame(
    setting = names(x),
    value = unlist(x),
    stringsAsFactors = FALSE
  )
  format_df(df)
}

#' @export

print.external_info <- function(x, ...) {
  cat(format(x, ...), sep = "\n")
}

#' @export

as.character.external_info <- function(x, ...) {
  old <- options(cli.num_colors = 1)
  on.exit(options(old), add = TRUE)
  format(x, ...)
}
