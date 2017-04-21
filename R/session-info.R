
#' Print session information
#'
#' This is [base::sessionInfo()] re-written from scratch to both exclude
#' data that's rarely useful (e.g., the full collate string or base packages
#' loaded) and include stuff you'd like to know (e.g., where a package was
#' installed from).
#'
#' @inheritParams package_info
#' @export
#' @examples
#' session_info()
#' session_info("sessioninfo")

session_info <- function(pkgs = NULL, include_base = FALSE) {
  structure(
    list(
      platform = platform_info(),
      packages = package_info(pkgs, include_base = include_base)
    ),
    class = "session_info"
  )
}

#' @export

print.session_info <- function(x, ...) {
  rule("Session info")
  print(x$platform)
  cat("\n")
  rule("Packages")
  print(x$packages)
}
