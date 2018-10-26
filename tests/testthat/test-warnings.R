
context("warnings")

test_that("broken dll", {
  if (.Platform$OS.type != "windows") { expect_true(TRUE); return() }
  skip_on_cran()

  ## To check this, we need a package with a dll.
  ## We need to install it into some temporary library, and then mess
  ## up the MD5 sum. We can use testhat itself to do this, as long as it
  ## has compiled code. We also run package_info() in another process,
  ## to avoid changing the current one.

  dir.create(lib <- tempfile())
  on.exit(unlink(lib, recursive = TRUE), add = TRUE)
  file.copy(system.file(package = "testthat"), lib, recursive = TRUE)

  md5file <- file.path(lib, "testthat", "MD5")
  if (!file.exists(md5file)) skip("Cannot test broken DLLs")
  l <- readLines(md5file)
  dllline <- grep("testthat.dll", l)[1]
  substr(l[dllline], 2, 5) <- "xxxx"
  writeLines(l, md5file)

  pi <- callr::r(
    function(lib) {
      library(testthat, lib.loc = lib)
      sessioninfo::package_info()
    },
    args = list(lib = lib),
    libpath = c(lib, .libPaths()),
    timeout = 10)

  expect_false(pi$md5ok[pi$package == "testthat"])
  expect_output(print(pi), "DLL MD5 mismatch, broken installation")
})

test_that("loaded & on-disk path mismatch", {
  skip_on_cran()

  ## Copy testthat to another library, load it from there, and then
  ## remove that lib from the library path.

  dir.create(lib <- tempfile())
  on.exit(unlink(lib, recursive = TRUE), add = TRUE)
  file.copy(system.file(package = "testthat"), lib, recursive = TRUE)

  pi <- callr::r(
    function(lib) {
      library(testthat, lib.loc = lib)
      .libPaths(.libPaths()[-1])
      sessioninfo::package_info()
    },
    args = list(lib = lib),
    libpath = c(lib, .libPaths()),
    timeout = 10
  )

  wh <- which(pi$package == "testthat")
  expect_false(pi$path[wh] == pi$loadedpath[wh])
  expect_output(print(pi), "Loaded and on-disk path mismatch")
})

test_that("loaded & on-disk version mismatch", {
  skip_on_cran()

  ## Copy testthat to another library and change the version, after
  ## loading it.

  dir.create(lib <- tempfile())
  on.exit(unlink(lib, recursive = TRUE), add = TRUE)
  file.copy(system.file(package = "testthat"), lib, recursive = TRUE)

  pi <- callr::r(
    function(lib) {
      library(testthat, lib.loc = lib)
      desc_file <- file.path(lib, "testthat", "DESCRIPTION")
      desc <- readLines(desc_file)
      desc <- sub("^Version:.*$", "Version: 0.0.1", desc)
      writeLines(desc, desc_file)

      binary_desc <- file.path(lib, "testthat", "Meta", "package.rds")
      if (file.exists(binary_desc)) {
        pkg_desc <- readRDS(binary_desc)
        desc <- as.list(pkg_desc$DESCRIPTION)
        desc$Version <- "0.0.1"
        pkg_desc$DESCRIPTION <- stats::setNames(as.character(desc), names(desc))
        saveRDS(pkg_desc, binary_desc)
      }
      sessioninfo::package_info()
    },
    args = list(lib = lib),
    libpath = c(lib, .libPaths()),
    timeout = 10
  )

  wh <- which(pi$package == "testthat")
  expect_false(pi$ondiskversion[wh] == pi$loadedversion[wh])
  expect_output(print(pi), "Loaded and on-disk version mismatch")
})

test_that("deleted package", {
  skip_on_cran()

  foo <- "fsdfgwetdhsdfhq4yqh"

  dir.create(lib <- tempfile())
  on.exit(unlink(lib, recursive = TRUE), add = TRUE)
  pkgfile <- normalizePath(paste0("fixtures/", foo, "_0.0.0.9000.tar.gz"))
  install.packages(pkgfile, lib = lib, repos = NULL, type = "source",
                   quiet = TRUE)

  pis <- callr::r(
    function(lib, foo) {
      library(foo, character.only = TRUE, lib.loc = lib)
      unlink(file.path(lib, foo), recursive = TRUE)
      list(
        sessioninfo::session_info(),
        sessioninfo::session_info(pkgs = foo)
      )
    },
    args = list(lib = lib, foo = foo),
    libpath = c(lib, .libPaths()),
    timeout = 10,
    error = "stack"
  )

  expect_true(is.list(pis))
  expect_equal(length(pis), 2)

  for (i in seq_along(pis)) {
    pi <- pis[[i]]$packages
    wh <- which(pi$package == foo)
    expect_equal(pi$ondiskversion[wh], NA_character_)
    expect_equal(pi$path[wh], NA_character_)
    expect_equal(pi$date[wh], NA_character_)
    expect_equal(pi$source[wh], NA_character_)
  }
})
