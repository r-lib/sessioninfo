
#' Human readable name of the current operating system
#'
#' For example Windows 8.1 instead of Windows version 6.3.9600.
#' On macOS it includes the code names, on Linux it includes the
#' distribution names and codenames if appropriate.
#'
#' It uses [utils::sessionInfo()], but simplifies its output a bit
#' on Windows, to make it more concise.
#'
#' @return A character scalar.
#'
#' @export

os_name <- function() {
  x <- utils::sessionInfo()$running

  # Regexps to clean up long windows strings generated at
  # https://github.com/wch/r-source/blob/af7f52f70101960861e5d995d3a4bec010bc89e6/src/library/utils/src/windows/util.c

  x <- gsub("Service Pack", "SP", x)
  x <- gsub(" \\(build \\d+\\)", "", x)

  x
}
