
#' Information about related software
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
#' @examples
#' external_info()

external_info <- function() {

  ex <- c(get_grsoft_version(), tcl = get_tcl_version(),
          curl = libcurlVersion(), extSoftVersion())
  ex["lapack"] <- get_la_library()
  ex["lapack_version"] <- get_la_version()
  names(ex) <- gsub("^lib", "", names(ex))

  structure(as.list(ex), class = "external_info")
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

#' @export

print.external_info <- function(x, ...) {
  df <- data.frame(setting = names(x), value = unlist(x), stringsAsFactors = FALSE)
  withr::local_options(list(max.print = 99999, width = 10000))
  print(df, right = FALSE, row.names = FALSE)
}

#' @export
#' @importFrom utils capture.output

as.character.external_info <- function(x, ...) {
  capture.output(print(x))
}
