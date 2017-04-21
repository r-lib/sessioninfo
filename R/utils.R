
#' @importFrom withr with_collate

sort_ci <- function(x) {
  with_collate("C", x[order(tolower(x), x)])
}
