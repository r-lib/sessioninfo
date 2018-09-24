
#' Information about the currently loaded packages, or about a chosen set
#'
#' @param pkgs Either a vector of package names or NULL. If \code{NULL},
#'   displays all loaded packages. If a character vector, also, includes
#'   all dependencies of the package.
#' @param include_base Include base packages in summary? By default this is
#'   false since base packages should always match the R version.
#' @return A data frame with columns:
#'   * `package`: package name.
#'   * `loadedversion`: package version. This is the version of the loaded
#'     namespace if `pkgs` is `NULL`, and it is the version of the package
#'     on disk otherwise. The two of them are almost always the same,
#'     though.
#'   * `ondiskversion`: package version (on the disk, which is sometimes
#'     not the same as the loaded version).
#'   * `path`: path to the package on disk.
#'   * `attached`: logical, whether the package is attached to the search
#'     path.
#'   * `is_base`: logical, whether the package is a base package.
#'   * `date`: the date the package was installed or built.
#'   * `source`: where the package was installed from. E.g.
#'     `CRAN`, `GitHub`, `local` (from the local machine), etc.
#'
#' See [session_info()] for the description of the *printed* columns
#' by `package_info` (as opposed to the *returned* columns).
#'
#' @export
#' @examples
#' package_info()
#' package_info("sessioninfo")

package_info <- function(pkgs = NULL, include_base = FALSE) {

  if (is.null(pkgs)) {
    pkgs <- loaded_packages()
  } else {
    pkgs <- dependent_packages(pkgs)
  }

  desc <- lapply(pkgs$package, utils::packageDescription)

  pkgs$is_base <- vapply(
    desc, function(x) identical(x$Priority, "base"), logical(1)
  )

  pkgs$date <- vapply(desc, pkg_date, character(1))
  pkgs$source <- vapply(desc, pkg_source, character(1))
  pkgs$md5ok <- vapply(desc, pkg_md5ok_dlls, logical(1))

  libpath <- pkg_lib_paths()
  pkgs$library <- factor(vapply(desc, pkg_dir, character(1)), levels = libpath)

  if (!include_base) pkgs <- pkgs[! pkgs$is_base, ]

  class(pkgs) <- c("packages_info", "data.frame")
  pkgs
}

pkg_lib_paths <- function() {
  normalizePath(.libPaths(), winslash = "/")
}

pkg_dir <- function(desc) {
  dfile <- attr(desc, "file")
  dfile <- normalizePath(dfile, winslash = "/")
  ifelse(
    basename(dfile) == "DESCRIPTION",
    dirname(dfile),
    dirname(dirname(dirname(dfile))))
}

pkg_date <- function (desc) {
  if (!is.null(desc$`Date/Publication`)) {
    date <- desc$`Date/Publication`

  } else if (!is.null(desc$Built)) {
    built <- strsplit(desc$Built, "; ")[[1]]
    date <- built[3]

  } else {
    date <- NA_character_
  }

  as.character(as.Date(strptime(date, "%Y-%m-%d")))
}

pkg_source <- function(desc) {

  if (!is.null(desc$GithubSHA1)) {
    str <- paste0("Github (",
                  desc$GithubUsername, "/",
                  desc$GithubRepo, "@",
                  substr(desc$GithubSHA1, 1, 7), ")")
  } else if (!is.null(desc$RemoteType) && desc$RemoteType != "cran") {
    # want to generate these:
    # remoteType (username/repo@commit)
    # remoteType (username/repo)
    # remoteType (@commit)
    # remoteType
    remote_type <- desc$RemoteType

    # RemoteUsername and RemoteRepo should always be present together
    if (!is.null(desc$RemoteUsername) && (!is.null(desc$RemoteRepo))) {
      user_repo <- paste0(desc$RemoteUsername, "/", desc$RemoteRepo)
    } else {
      user_repo <- NULL
    }

    if (!is.null(desc$RemoteSha)) {
      sha <- paste0("@", substr(desc$RemoteSha, 1, 7))
    } else {
      sha <- NULL
    }

    # in order to fulfill the expectation of formatting, we paste the user_repo
    # and sha together
    if (!is.null(user_repo) || !is.null(sha)) {
      user_repo_and_sha <- paste0(" (", user_repo, sha, ")")
    } else {
      user_repo_and_sha <- NULL
    }

    str <- paste0(remote_type, user_repo_and_sha)

  } else if (!is.null(desc$Repository)) {
    repo <- desc$Repository

    if (!is.null(desc$Built)) {
      built <- strsplit(desc$Built, "; ")[[1]]
      ver <- sub("$R ", "", built[1])

      repo <- paste0(repo, " (", ver, ")")
    }

    repo

  } else if (!is.null(desc$biocViews)) {
    "Bioconductor"
  } else {
    "local"
  }
}

pkg_md5ok_dlls <- function(desc) {
  if (.Platform$OS.type != "windows") return(NA)
  pkgdir <- dirname(dirname(attr(desc, "file")))
  if (!file.exists(file.path(pkgdir, "libs"))) return(TRUE)
  stored <- pkg_md5_stored(pkgdir)
  if (is.null(stored)) return(NA)
  disk <- pkg_md5_disk(pkgdir)
  identical(stored, disk)
}

pkg_md5_stored <- function(pkgdir) {
  md5file <- file.path(pkgdir, "MD5")
  md5 <- tryCatch(
    suppressWarnings(readLines(md5file)),
    error = function(e) NULL)
  if (is.null(md5)) return(NULL)
  hash <- sub(" .*$", "", md5)
  filename <- sub("^[^ ]* \\*", "", md5)
  dll <- grep("[dD][lL][lL]$", filename)
  order_by_name(structure(hash[dll], names = tolower(filename[dll])))
}

pkg_md5_disk <- function(pkgdir) {
  withr::with_dir(pkgdir, {
    dll_files <- file.path(
      "libs",
      dir("libs", pattern = "[dD][lL][lL]$", recursive = TRUE))
    md5_files <- tools::md5sum(dll_files)
    order_by_name(structure(unname(md5_files), names = tolower(dll_files)))
  })
}

#' @export

print.packages_info <- function(x, ...) {

  unloaded <- is.na(x$loadedversion)
  badloaded <- package_version(x$loadedversion, strict = FALSE) !=
               package_version(x$ondiskversion)
  badloaded <- !is.na(badloaded) & badloaded

  badmd5 <- !is.na(x$md5ok) & !x$md5ok

  flib <- function(x) ifelse(is.na(x), "?", as.integer(x))

  px <- data.frame(
    package = x$package,
    "*"     = ifelse(x$attached, "*", ""),
    version = ifelse(unloaded, x$ondiskversion, x$loadedversion),
    date    = x$date,
    lib     = paste0("[", flib(x$library), "]"),
    source  = x$source,
    stringsAsFactors = FALSE,
    check.names = FALSE
  )

  if (any(badloaded) || any(badmd5)) {
    prob <- paste0(
      ifelse(badloaded, "V", ""),
      ifelse(badmd5, "D", ""))
    px <- cbind("!" = prob, px)
  }

  withr::local_options(list(max.print = 99999))
  pr <- print.data.frame(px, right = FALSE, row.names = FALSE)

  cat("\n")
  lapply(
    seq_along(levels(x$library)),
    function(i) cat_ln(paste0("[", i, "] ", levels(x$library)[i])))

  if ("!" %in% names(px)) cat("\n")
  if (any(badloaded)) {
    cat_ln(" V ", dash(2), ", Loaded and on-disk version mismatch.")
  }
  if (any(badmd5)) {
    cat_ln(" D ", dash(2), " DLL MD5 mismatch, broken installation.")
  }

  invisible(x)
}

#' @export
#' @importFrom utils capture.output

as.character.packages_info <- function(x, ...) {
  capture.output(print(x))
}
