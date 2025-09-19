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
#' @examplesIf FALSE
#' session_info()
#' session_info("sessioninfo")

session_info <- function(
  pkgs = c("loaded", "attached", "installed")[1],
  include_base = FALSE,
  info = c("auto", "all", "platform", "packages", "python", "external"),
  dependencies = NA,
  to_file = FALSE
) {
  if (missing(info)) {
    info <- "auto"
  }
  choices <- c("platform", "packages", "python", "external")
  if ("all" %in% info) {
    info <- choices
  } else if ("auto" %in% info) {
    info <- c(
      "platform",
      "packages",
      if (should_show_python(pkgs)) "python"
    )
  } else {
    info <- match.arg(info, choices, several.ok = TRUE)
  }

  stopifnot(is_flag(to_file) || is_string(to_file))
  if (is_flag(to_file) && to_file) {
    to_file <- "session-info.txt"
  }

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

  c(
    if (!"platform" %in% names(x)) {
      rule("Session info", double = TRUE)
    },
    if ("platform" %in% names(x)) {
      c(rule(paste("Session info")), format(x$platform), "")
    },
    if ("packages" %in% names(x) && nrow(x$packages) > 0) {
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

has_emoji <- function() {
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

#' @export

print.session_info <- function(x, ...) {
  cat(format(x), sep = "\n")
}

#' Convert session_info object to LaTeX
#'
#' @param object A `session_info` object created by [session_info()].
#' @param ... Not currently used.
#' @return `toLatex()` creates a character vector of class "Latex" containing
#'   LaTeX markup. To render the output in Quarto or R Markdown, set the chunk
#'   option `results` to `"asis"`.
#' @rdname session_info
#' @importFrom utils toLatex
#' @export
#' @examples
#' \dontrun{
#' si <- session_info()
#' toLatex(si)
#'
#' # If using in Quarto or R Markdown, set results to "asis":
#' #
#' # ```{r}
#' # #| results: asis
#' # toLatex(sessioninfo::session_info())
#' # ```
#' }
toLatex.session_info <- function(object, ...) {
  z <- character()

  # Platform section
  if (!is.null(object$platform)) {
    z <- c(z, "\\textbf{Session info}", "\\begin{itemize}\\raggedright")

    for (name in names(object$platform)) {
      value <- object$platform[[name]]
      if (!is.null(value) && nzchar(value)) {
        display_name <- switch(
          name,
          "os" = "OS",
          "ui" = "UI",
          "tz" = "Time zone",
          str_sentence(name)
        )
        z <- c(z, paste0("  \\item ", display_name, ": \\verb|", value, "|"))
      }
    }
    z <- c(z, "\\end{itemize}")
  }

  # Packages section
  if (!is.null(object$packages)) {
    z <- c(z, "\\textbf{Packages}", "\\begin{itemize}\\raggedright")

    pkg_df <- object$packages
    base_pkgs <- pkg_df$package[pkg_df$is_base]
    other_pkgs <- pkg_df[!pkg_df$is_base, ]

    if (length(base_pkgs) > 0) {
      z <- c(
        z,
        strwrap(
          paste(
            "  \\item Base packages: ",
            paste(sort(base_pkgs), collapse = ", ")
          ),
          indent = 2,
          exdent = 4
        )
      )
    }

    if (nrow(other_pkgs) > 0) {
      # Use ondiskversion when loadedversion is NA (for installed but
      # not loaded packages)
      versions <- ifelse(
        is.na(other_pkgs$loadedversion),
        other_pkgs$ondiskversion,
        other_pkgs$loadedversion
      )
      pkg_strings <- paste0(other_pkgs$package, " (", versions, ")")
      z <- c(
        z,
        strwrap(
          paste(
            "  \\item Other packages: ",
            paste(pkg_strings, collapse = ", ")
          ),
          indent = 2,
          exdent = 4
        )
      )
    }
    z <- c(z, "\\end{itemize}")
  }

  # External software section
  if (!is.null(object$external)) {
    z <- c(z, "\\textbf{External software}", "\\begin{itemize}\\raggedright")

    # Handle BLAS/LAPACK specially like base R
    z <- c(z, format_blas_lapack(object$external))

    # Add other external software (excluding BLAS/LAPACK which we handled)
    other_external <- object$external[
      !names(object$external) %in%
        c("BLAS", "lapack", "lapack_version")
    ]

    for (name in names(other_external)) {
      value <- other_external[[name]]
      if (!is.null(value) && nzchar(value)) {
        display_name <- switch(
          name,
          "png" = "PNG",
          "jpeg" = "JPEG",
          "tiff" = "TIFF",
          "tcl" = "TCL",
          "curl" = "cURL",
          "zlib" = "zlib",
          "bzlib" = "bzlib",
          "xz" = "XZ",
          "deflate" = "deflate",
          "PCRE" = "PCRE",
          "ICU" = "ICU",
          "TRE" = "TRE",
          "iconv" = "iconv",
          "readline" = "readline",
          str_sentence(name)
        )
        z <- c(z, paste0("  \\item ", display_name, ": \\verb|", value, "|"))
      }
    }
    z <- c(z, "\\end{itemize}")
  }

  # Python section
  if (!is.null(object$python)) {
    z <- c(z, "\\textbf{Python configuration}", "\\begin{itemize}\\raggedright")
    python_status <- as.character(object$python)

    if (grepl("not available", python_status, ignore.case = TRUE)) {
      z <- c(z, "  \\item Python is not available")
    } else {
      z <- c(z, paste0("  \\item Python: \\verb|", python_status, "|"))
    }
    z <- c(z, "\\end{itemize}")
  }

  class(z) <- "Latex"
  z
}

# Function for formatting BLAS/LAPACK info like utils::toLatex.sessionInfo()
format_blas_lapack <- function(external) {
  z <- character()

  blas <- external$BLAS
  lapack <- external$lapack

  if (!is.null(blas) && !is.null(lapack) && nzchar(blas) && nzchar(lapack)) {
    if (blas == lapack) {
      z <- c(z, paste0("  \\item BLAS/LAPACK: \\verb|", blas, "|"))
    } else {
      z <- c(z, paste0("  \\item BLAS: \\verb|", blas, "|"))
      z <- c(z, paste0("  \\item LAPACK: \\verb|", lapack, "|"))
    }
  } else {
    if (!is.null(blas) && nzchar(blas)) {
      z <- c(z, paste0("  \\item BLAS: \\verb|", blas, "|"))
    }
    if (!is.null(lapack) && nzchar(lapack)) {
      z <- c(z, paste0("  \\item LAPACK: \\verb|", lapack, "|"))
    }
  }

  # Add LAPACK version if available and different
  lapack_ver <- external$lapack_version
  if (
    !is.null(lapack_ver) &&
      nzchar(lapack_ver) &&
      !is.null(lapack) &&
      nzchar(lapack) &&
      !grepl(lapack_ver, lapack, fixed = TRUE)
  ) {
    z <- c(z, paste0("  \\item LAPACK version: \\verb|", lapack_ver, "|"))
  }

  z
}
