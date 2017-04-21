
#' @importFrom clisymbols symbol

rule <- function (..., pad = NULL) {
  if (is.null(pad)) pad <- symbol$line
  title <- if (length(list(...))) paste0(" ", ..., " ") else ""

  width <- max(getOption("width") - nchar(title) - 3, 0)
  cat(pad, title, paste(rep(pad, width, collapse = "")), "\n", sep = "")
}
