
#' @importFrom cli symbol

rule <- function (..., pad = NULL) {
  if (is.null(pad)) pad <- symbol$line
  title <- if (length(list(...))) paste0(" ", ..., " ") else ""

  width <- max(getOption("width") - nchar(title) - 3, 0)
  paste(pad, title, paste(rep(pad, width), collapse = ""), sep = "")
}

dash <- function(n = 2) {
  paste(rep(symbol$line, n), collapse = "")
}

cat_ln <- function(..., sep = "") {
  cat(..., "\n", sep = sep)
}
