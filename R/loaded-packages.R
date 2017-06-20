
#' @importFrom utils packageVersion

loaded_packages <- function() {

  ## 'base' is special, because getNamespaceInfo does not work on it.
  ## Luckily, the path for 'base' is just system.file()

  spackageVersion <- function(pkg) as.character(packageVersion(pkg))

  packages <- setdiff(loadedNamespaces(), "base")
  loadedversion <- vapply(packages, getNamespaceVersion, "")
  ondiskversion <- vapply(packages, spackageVersion, "")
  path <- vapply(packages, getNamespaceInfo, "", "path")
  attached <- paste0("package:", packages) %in% search()

  res <- data.frame(
    package = c(packages, "base"),
    ondiskversion = c(ondiskversion, spackageVersion("base")),
    loadedversion = c(loadedversion, getNamespaceVersion("base")),
    path = c(path, system.file()),
    attached = c(attached, TRUE),
    stringsAsFactors = FALSE,
    row.names = NULL
  )

  res <- res[match(sort_ci(res$package), res$package), ]

  row.names(res) <- NULL
  res
}
