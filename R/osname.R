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
  x <- suppressWarnings(utils::sessionInfo("base")$running)
  if (is.null(x)) return(NA_character_)

  x <- gsub("Service Pack", "SP", x)

  x
}
