
#' @importFrom utils packageVersion

loaded_packages <- function() {

  ## 'base' is special, because getNamespaceInfo does not work on it.
  ## Luckily, the path for 'base' is just system.file()

  spackageVersion <- function(pkg) {
    as.character(packageVersion(pkg, lib.loc = .libPaths()))
  }

  packages <- setdiff(loadedNamespaces(), "base")
  loadedversion <- vapply(packages, getNamespaceVersion, "")
  ondiskversion <- vapply(packages, spackageVersion, "")
  path <- vapply(
    packages,
    function(p) system.file(package = p, lib.loc = .libPaths()),
    character(1))
  loadedpath <- vapply(packages, getNamespaceInfo, "", which = "path")
  attached <- paste0("package:", packages) %in% search()

  res <- data.frame(
    package = c(packages, "base"),
    ondiskversion = c(ondiskversion, spackageVersion("base")),
    loadedversion = c(loadedversion, getNamespaceVersion("base")),
    path = c(path, system.file()),
    loadedpath = c(loadedpath, NA_character_),
    attached = c(attached, TRUE),
    stringsAsFactors = FALSE,
    row.names = NULL
  )

  res <- res[match(sort_ci(res$package), res$package), ]

  row.names(res) <- NULL
  res
}
