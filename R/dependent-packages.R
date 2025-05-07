dependent_packages <- function(pkgs, dependencies) {
  ideps <- interpret_dependencies(dependencies)

  pkgs <- find_deps(pkgs, utils::installed.packages(), ideps[[1]], ideps[[2]])
  desc <- lapply(pkgs, pkg_desc)

  loaded_pkgs <- pkgs %in% setdiff(loadedNamespaces(), "base")
  ondiskversion <- vapply(
    desc,
    function(x) x$Version %||% NA_character_,
    character(1)
  )
  loadedversion <- rep(NA_character_, length(pkgs))
  loadedversion[loaded_pkgs] <- vapply(
    pkgs[loaded_pkgs],
    getNamespaceVersion,
    ""
  )
  loadedpath <- rep(NA_character_, length(pkgs))
  loadedpath[loaded_pkgs] <-
    vapply(pkgs[loaded_pkgs], getNamespaceInfo, "", which = "path")
  res <- data.frame(
    package = pkgs,
    ondiskversion = ondiskversion,
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
  if (is.null(desc)) {
    NA_character_
  } else {
    system.file(package = desc$Package, lib.loc = .libPaths())
  }
}

find_deps <- function(
  pkgs,
  available = utils::available.packages(),
  top_dep = c(dep_types_hard(), "Suggests"),
  rec_dep = dep_types_hard(),
  include_pkgs = TRUE
) {
  if (length(pkgs) == 0 || identical(top_dep, FALSE)) return(character())

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
      recursive = TRUE
    )
    rec_flat <- unlist(rec, use.names = FALSE)
  } else {
    rec_flat <- character()
  }

  unique(c(if (include_pkgs) pkgs, top_flat, rec_flat))
}

dep_types_hard <- function() c("Depends", "Imports", "LinkingTo")
dep_types_soft <- function() c("Suggests", "Enhances")
dep_types <- function() c(dep_types_hard(), dep_types_soft())

is_na_scalar <- function(x) length(x) == 1 && is.na(x)

interpret_dependencies <- function(dp) {
  hard <- dep_types_hard()

  if (isTRUE(dp)) {
    list(c(hard, "Suggests"), hard)
  } else if (identical(dp, FALSE)) {
    list(character(), character())
  } else if (is_na_scalar(dp)) {
    list(hard, hard)
  } else {
    list(dp, dp)
  }
}
