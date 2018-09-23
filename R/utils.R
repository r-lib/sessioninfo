
#' @importFrom withr with_collate

sort_ci <- function(x) {
  with_collate("C", x[order(tolower(x), x)])
}

is_string <- function(x) {
  is.character(x) && length(x) == 1 && !is.na(x)
}

order_by_name <- function(x) {
  if (!length(x)) {
    x
  } else if (is.null(names(x))) {
    stop("Cannot order by name, no names")
  } else {
    x[order(names(x))]
  }
}
