
#' @importFrom cli symbol

rule <- function (..., pad = NULL, double = FALSE) {
  if (is.null(pad)) pad <- if (double) symbol$double_line else symbol$line
  title <- if (length(list(...))) paste0(" ", ..., " ") else ""

  width <- max(cli::console_width() - cli::ansi_nchar(title, "width") - 3, 0)
  rule <- paste(pad, title, paste(rep(pad, width), collapse = ""), sep = "")
  cli::style_bold(cli::col_cyan(rule))
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

format_df <- function(x, highlighters = NULL) {
  cols <- mapply(
    names(x),
    x,
    FUN = format_column,
    USE.NAMES = FALSE,
    SIMPLIFY = FALSE
  )

  cols <- lapply(cols, function(x) {
    if (length(x) > 0) x[1] <- cli::col_grey(cli::style_italic(x[1]))
    x
  })

  for (idx in seq_along(highlighters)) {
    colname <- names(highlighters)[idx]
    colnum <- match(colname, names(x))
    if (is.na(colnum)) next
    cols[[colnum]][-1] <- highlighters[[idx]](cols[[colnum]][-1])
  }

  # remove trailing space, to avoid superfluous wrapping
  cli::ansi_trimws(do.call("paste", c("", cols)), "right")
}

highlight_version <- function(x) {
  ver <- package_version(trimws(x))
  large <- vapply(ver, function(x) any(unlist(x) >= 1234), logical(1))
  x[large] <- cli::style_bold(cli::col_magenta(x[large]))
  x
}
