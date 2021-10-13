
#' Print session information
#'
#' This is [utils::sessionInfo()] re-written from scratch to both exclude
#' data that's rarely useful (e.g., the full collate string or base packages
#' loaded) and include stuff you'd like to know (e.g., where a package was
#' installed from).
#'
#' @details
#' Columns in the *printed* package list:
#' * `package`: package name
#' * `*`: whether the package is attached to the search path
#' * `version`: package version. If the version is marked with `(!)` that
#'   means that the loaded and the on-disk version of the package are
#'   different.
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
#' @param info What information to show, it can be `"auto"` to choose
#'   automatically, `"all"` to show everything, or a character vector
#'   with elements from:
#'   * `"platform"`: show platform information via [platform_info()],
#'   * `"packages"`: show package information via [package_info()],
#'   * `"python"`: show Python configuration via [python_info()],
#'   * `"external"`: show information about external software, via
#'      [external_info()].
#' @param to_file Whether to print the session information to a file.
#'   If `TRUE` the name of the file will be `session-info.txt`, but
#'   `to_file` may also be a string to specify the file name.
#'
#' @return
#' A `session_info` object.
#'
#' If `to_file` is not `FALSE` then it is
#' returned invisibly. (To print it to both a file and to the screen,
#' use `(session_info(to_file = TRUE))`.)
#'
#' @export
#' @examples
#' session_info()
#' session_info("sessioninfo")

session_info <- function(
    pkgs = c("!loaded", "!attached", "!installed")[1],
    include_base = FALSE,
    info = c("auto", "all", "platform", "packages", "python", "external"),
    dependencies = NA,
    to_file = FALSE) {

  if (missing(info)) info <- "auto"
  choices <- c("platform", "packages", "python", "external")
  if (info != "auto" && info != "all") {
    info <- match.arg(info, choices, several.ok = TRUE)
  }
  if ("all" %in% info) {
    info <- choices
  } else if ("auto" %in% info) {
    info <- c(
      "platform",
      "packages",
      if (should_show_python(pkgs)) "python"
    )
  }

  stopifnot(is_flag(to_file) || is_string(to_file))
  if (is_flag(to_file) && to_file) to_file <- "session-info.txt"

  si <- structure(
    drop_null(list(
      platform = if ("platform" %in% info) platform_info(),
      packages = if ("packages" %in% info) {
        package_info(
          pkgs,
          include_base = include_base,
          dependencies = dependencies
        )
      },
      external = if ("external" %in% info) external_info(),
      python = if ("python" %in% info) python_info()
    )),
    class = c("session_info", "list")
  )

  si <- add_hash(si)

  if (is_string(to_file)) {
    old <- options(cli.num_colors = 1)
    on.exit(options(old), add = TRUE)
    writeLines(format(si), to_file)
    invisible(si)
  } else {
    si
  }
}

#' @export

format.session_info <- function(x, ...) {

  has_platform <- !is.null(x$platform)

  c(if (!"platform" %in% names(x)) {
      c(rule(paste("Session info", emo_hash(x)), double = TRUE), text_hash(x))
    },
    if ("platform" %in% names(x)) {
      c(rule(paste("Session info", emo_hash(x))),
        text_hash(x),
        format(x$platform),
        ""
      )
    },
    if ("packages" %in% names(x)) {
      c(rule("Packages"), format(x$packages), "")
    },
    if ("external" %in% names(x)) {
      c(rule("External software"), format(x$external), "")
    },
    if ("python" %in% names(x)) {
      c(rule("Python configuration"), format(x$python), "")
    },
    rule()
  )
}

#' @export

as.character.session_info <- function(x, ...) {
  old <- options(cli.num_colors = 1)
  on.exit(options(old), add = TRUE)
  format(x, ...)
}

has_emoji <- function () {
  if (isTRUE(opt <- getOption("sessioninfo.emoji"))) {
    TRUE
  } else if (identical(opt, FALSE)) {
    FALSE
  } else if (!cli::is_utf8_output()) {
    FALSE
  } else {
    Sys.info()[["sysname"]] == "Darwin"
  }
}

emo_hash <- function(x) {
  if (is.null(x$hash)) return("")
  if (has_emoji()) {
    paste0(" ", paste(x$hash$emoji, " ", collapse = ""))
  } else {
    ""
  }
}

text_hash <- function(x) {
  c(paste0(" hash: ", paste(x$hash$emo_text, collapse = ", ")), "")
}

#' @export

print.session_info <- function(x, ...) {
  cat(format(x), sep = "\n")
}
