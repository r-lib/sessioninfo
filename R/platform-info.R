
#' Information about the current platform
#'
#' @return A list with elements:
#'   * `version`: the R version string.
#'   * `os`: the OS name in human readable format, see [os_name()].
#'   * `system`: CPU, and machine readable OS name, separated by a comma.
#'   * `ui`: the user interface, e.g. `Rgui`, `RTerm`, etc. see `GUI`
#'     in [base::.Platform].
#'   * `language`: The current language setting. The `LANGUAGE` environment
#'     variable, if set, or `(EN)` if unset.
#'   * `collate`: Collation rule, from the current locale.
#'   * `ctype`: Native character encoding, from the current locale.
#'   * `tz`: The current time zone.
#'   * `date`: The current date.
#'   * `rstudio_version`: RStudio format string, only added in RStudio.
#'
#' @seealso Similar functions and objects in the base packages:
#'   [base::R.version.string], [utils::sessionInfo()], [base::version],
#'   [base::.Platform], [base::Sys.getlocale()], [base::Sys.timezone()].
#'
#' @export
#' @examples
#' platform_info()

platform_info <- function() {
  structure(drop_null(list(
    version = R.version.string,
    os = os_name(),
    system = version$system,
    ui = .Platform$GUI,
    language = Sys.getenv("LANGUAGE", "(EN)"),
    collate = Sys.getlocale("LC_COLLATE"),
    ctype = Sys.getlocale("LC_CTYPE"),
    tz = Sys.timezone(),
    date = format(Sys.Date()),
    rstudio_version = get_rstudio_version(),
    pandoc_version = get_pandoc_version()
  )), class = "platform_info")
}

get_rstudio_version <- function() {
  tryCatch({
    ver <- get("RStudio.Version", "tools:rstudio")()
    paste0(ver$long_version, " ", ver$release_name, " (", ver$mode, ")")
  }, error = function(e) NULL)
}

get_pandoc_version <- function() {
  if (isNamespaceLoaded("rmarkdown")) {
    ver <- rmarkdown::find_pandoc()
    if (is.null(ver$dir)) {
      "NA (via rmarkdown)"
    } else {
      paste0(ver$version, " @ ", ver$dir, "/ (via rmarkdown)")
    }
  } else {
    path <- Sys.which("pandoc")
    if (path == "") {
      "NA"
    } else {
      ver <- parse_pandoc_version(path)
      paste0(ver, " @ ", path)
    }
  }
}

parse_pandoc_version <- function(path) {
  tryCatch({
    out <- system2(path, "--version", stdout = TRUE)[1]
    last(strsplit(out, " ", fixed = TRUE)[[1]])
  }, error = function(e) "NA")
}

#' @export

format.platform_info <- function(x, ...) {
  df <- data.frame(
    setting = names(x),
    value = unlist(x),
    stringsAsFactors = FALSE
  )
  format_df(df)
}

#' @export

print.platform_info <- function(x, ...) {
  cat(format(x, ...), sep = "\n")
}

#' @export

as.character.platform_info <- function(x, ...) {
  format(x, ...)
}
