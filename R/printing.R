
#' @importFrom cli symbol

rule <- function (..., pad = NULL) {
  if (is.null(pad)) pad <- symbol$line
  title <- if (length(list(...))) paste0(" ", ..., " ") else ""

  width <- max(cli::console_width() - nchar(title) - 3, 0)
  paste(pad, title, paste(rep(pad, width), collapse = ""), sep = "")
}

dash <- function(n = 2) {
  paste(rep(symbol$line, n), collapse = "")
}

cat_ln <- function(..., sep = "") {
  cat(..., "\n", sep = sep)
}

col_align <- function(x, align = c("left", "center", "right")) {
  x <- encodeString(x)
  mw <- max(cli::ansi_nchar(x, "width"))
  cli::ansi_align(x, align = align, width = mw)
}

format_column <- function(name, x) {
  col_align(c(name, x))
}

format_df <- function(x) {
  cols <- mapply(
    names(x),
    x,
    FUN = format_column,
    USE.NAMES = FALSE,
    SIMPLIFY = FALSE
  )

  # remove trailing space, to avoid superfluous wrapping
  trimws(do.call("paste", c("", cols)), "right")
}
