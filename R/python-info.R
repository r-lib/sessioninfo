should_show_python <- function(pkgs) {
  "reticulate" %in%
    pkgs ||
    (isNamespaceLoaded("reticulate") &&
      reticulate::py_available(initialize = FALSE))
}

#' Python configuration
#'
#' @return
#' Returns a [reticulate::py_config] object, which also has the
#' `python_info` class. It is a named list of values.
#'
#' If reticulate is not installed or Python is not configured,
#' then it return a `python_info` object that is a character vector, and
#' it does not have a `py_config` class.
#'
#' @export
#' @examplesIf FALSE
#' python_info()
#' session_info(info = "all")

python_info <- function() {
  conf <- if (
    isNamespaceLoaded("reticulate") &&
      reticulate::py_available(initialize = FALSE)
  ) {
    tryCatch(
      reticulate::py_config(),
      error = function(err) {
        c("`reticulate::py_config()` failed with error:", conditionMessage(err))
      }
    )
  } else {
    "Python is not available"
  }

  class(conf) <- unique(c("python_info", class(conf), "list"))
  conf
}

#' @export

format.python_info <- function(x, ...) {
  x <- NextMethod()
  paste0(" ", unlist(strsplit(x, "\n", fixed = TRUE)))
}

#' @export

as.character.python_info <- function(x, ...) {
  old <- options(cli.num_colors = 1)
  on.exit(options(old), add = TRUE)
  format(x, ...)
}

#' @export

print.python_info <- function(x, ...) {
  cat(format(x, ...), sep = "\n")
}
