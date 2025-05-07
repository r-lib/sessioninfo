#' @importFrom utils packageVersion

loaded_packages <- function() {
  get_package_info(loadedNamespaces())
}

attached_packages <- function() {
  packages <- intersect(
    loadedNamespaces(),
    sub("^package:", "", search())
  )
  get_package_info(packages)
}

installed_packages <- function() {
  pkgs <- rownames(utils::installed.packages(noCache = TRUE))
  dependent_packages(pkgs, dependencies = FALSE)
}

get_package_info <- function(packages) {
  ## 'base' is special, because getNamespaceInfo does not work on it.
  ## Luckily, the path for 'base' is just system.file()

  spackageVersion <- function(pkg) {
    ## Error may happen if the package was loaded, and then removed from
    ## the disk. In this case we'll have NA
    tryCatch(
      as.character(packageVersion(pkg, lib.loc = .libPaths())),
      error = function(e) NA_character_
    )
  }

  packages <- setdiff(packages, "base")

  loadedversion <- vapply(packages, getNamespaceVersion, "")
  ondiskversion <- vapply(packages, spackageVersion, "")

  path <- vapply(
    packages,
    function(p) system.file(package = p, lib.loc = .libPaths()),
    character(1)
  )
  ## If we can't fine the package on disk, have NA instead of ""
  path[path == ""] <- NA_character_
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
