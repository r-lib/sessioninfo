
dependent_packages <- function(pkgs) {
  pkgs <- find_deps(pkgs, utils::installed.packages(), top_dep = NA)
  desc <- lapply(pkgs, utils::packageDescription)

  loaded_pkgs <- pkgs %in% setdiff(loadedNamespaces(), "base")
  loadedversion <- rep(NA_character_, length(pkgs))
  loadedversion[loaded_pkgs] <- vapply(pkgs[loaded_pkgs], getNamespaceVersion, "")
  loadedpath <- rep(NA_character_, length(pkgs))
  loadedpath[loaded_pkgs] <-
    vapply(pkgs[loaded_pkgs], getNamespaceInfo, "", which = "path")
  res <- data.frame(
    package = pkgs,
    ondiskversion = vapply(desc, function(x) x$Version, character(1)),
    loadedversion = loadedversion,
    path = vapply(desc, pkg_path_disk, character(1)),
    loadedpath = loadedpath,
    attached = paste0("package:", pkgs) %in% search(),
    stringsAsFactors = FALSE,
    row.names = NULL
  )

  res <- res[match(sort_ci(res$package), res$package), ]

  row.names(res) <- NULL
  res
}

pkg_path_disk <- function(desc) {
  system.file(package = desc$Package, lib.loc = .libPaths())
}

find_deps <- function(pkgs, available = utils::available.packages(),
                      top_dep = TRUE, rec_dep = NA, include_pkgs = TRUE) {

  if (length(pkgs) == 0 || identical(top_dep, FALSE)) return(character())

  top_dep <- standardise_dep(top_dep)
  rec_dep <- standardise_dep(rec_dep)

  if (length(top_dep) > 0) {
    top <- tools::package_dependencies(pkgs, db = available, which = top_dep)
    top_flat <- unlist(top, use.names = FALSE)
  } else {
    top_flat <- character()
  }

  if (length(rec_dep) != 0 && length(top_flat) > 0) {
    rec <- tools::package_dependencies(
      top_flat,
      db = available,
      which = rec_dep,
      recursive = TRUE)
    rec_flat <- unlist(rec, use.names = FALSE)

  } else {
    rec_flat <- character()
  }

  unique(c(if (include_pkgs) pkgs, top_flat, rec_flat))
}

standardise_dep <- function(x) {
  if (identical(x, NA)) {
    c("Depends", "Imports", "LinkingTo")
  } else if (isTRUE(x)) {
    c("Depends", "Imports", "LinkingTo", "Suggests")
  } else if (identical(x, FALSE)) {
    character(0)
  } else if (is.character(x)) {
    x
  } else {
    stop("Dependencies must be a boolean or a character vector", call. = FALSE)
  }
}
