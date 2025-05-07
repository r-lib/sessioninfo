`%||%` <- function(l, r) if (is.null(l)) r else l

sort_ci <- function(x) {
  old <- Sys.getlocale("LC_COLLATE")
  on.exit(Sys.setlocale("LC_COLLATE", old), add = TRUE)
  Sys.setlocale("LC_COLLATE", "C")
  x[order(tolower(x), x)]
}

is_string <- function(x) {
  is.character(x) && length(x) == 1 && !is.na(x)
}

is_flag <- function(x) {
  is.logical(x) && length(x) == 1 && !is.na(x)
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

drop_null <- function(x) {
  x[!vapply(x, is.null, logical(1))]
}

last <- function(x) {
  x[length(x)]
}

empty <- function(x) {
  grepl("^\\s*$", x)
}

str_trim <- function(x, width) {
  stopifnot(width >= 2)
  if (nchar(x) <= width) {
    x
  } else {
    paste0(substr(x, 1, width - 1), "~")
  }
}
