
loaded_packages <- function() {

  ## 'base' is special, because getNamespaceInfo does not work on it.
  ## Luckily, the path for 'base' is just system.file()

  packages <- setdiff(loadedNamespaces(), "base")
  version <- vapply(packages, getNamespaceVersion, "")
  path <- vapply(packages, getNamespaceInfo, "", "path")
  attached <- paste0("package:", packages) %in% search()

  res <- data.frame(
    package = c(packages, "base"),
    version = c(version, getNamespaceVersion("base")),
    path = c(path, system.file()),
    attached = c(attached, TRUE),
    stringsAsFactors = FALSE,
    row.names = NULL
  )

  res <- res[match(sort_ci(res$package), res$package), ]

  row.names(res) <- NULL
  res
}
