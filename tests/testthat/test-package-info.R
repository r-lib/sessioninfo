
context("package_info")

test_that("package_info, loaded", {

  descs <- readRDS("fixtures/devtools-deps.rda")
  alldsc <- readRDS("fixtures/descs.rda")
  exp <- readRDS(paste0("fixtures/devtools-info-", .Platform$OS.type, ".rda"))

  mockery::stub(package_info, "loaded_packages", descs)
  mockery::stub(
    package_info,
    "pkg_desc",
    function(x, ...) alldsc[[x]]
    )
  mockery::stub(package_info, "pkg_lib_paths", levels(exp$library))

  pi <- package_info()
  expect_identical(pi, exp)
})

test_that("package_info, dependent", {

  descs <- readRDS("fixtures/devtools-deps.rda")
  alldsc <- readRDS("fixtures/descs.rda")
  exp <- readRDS(paste0("fixtures/devtools-info-", .Platform$OS.type, ".rda"))

  mockery::stub(package_info, "dependent_packages", descs)
  mockery::stub(
    package_info,
    "pkg_desc",
    function(x, ...) alldsc[[x]]
  )
  mockery::stub(package_info, "pkg_lib_paths", levels(exp$library))

  pi <- package_info("devtools")
  expect_identical(pi, exp)
})

test_that("pkg_date", {
  crayon <- readRDS("fixtures/descs.rda")$crayon
  expect_equal(pkg_date(crayon), "2016-06-28")

  crayon$`Date/Publication` <- NULL
  expect_equal(pkg_date(crayon), "2016-06-29")

  crayon$`Built` <- NULL
  expect_identical(pkg_date(crayon), NA_character_)
})

test_that("pkg_source", {
  descs <- readRDS("fixtures/descs.rda")

  expect_identical(
    pkg_source(descs$debugme),
    "Github (gaborcsardi/debugme@df8295a)"
  )

  expect_identical(pkg_source(descs$curl), "CRAN (R 3.3.3)")

  biobase <- readRDS("fixtures/biobase.rda")
  expect_identical(pkg_source(biobase), "Bioconductor")

  memoise <- readRDS("fixtures/memoise.rda")
  expect_identical(pkg_source(memoise), "CRAN (R 3.3.3)")
})

test_that("pkg_source edge case, remote repo, but no RemoteSha", {
  desc <- readRDS("fixtures/no-sha.rda")
  expect_identical(pkg_source(desc), "github (r-pkgs/desc)")
})

test_that("pkg_source edge case, remote repo, no RemoteRepo", {
  desc <- readRDS("fixtures/no-remote-repo.rda")
  expect_identical(pkg_source(desc), "github")
})

test_that("pkg_md5_stored", {
  md5 <- pkg_md5_stored("fixtures")
  exp <- c(`libs/i386/fansi.dll` = "7b96ab4bf019b0cfed86425634d640e8",
           `libs/x64/fansi.dll` = "6503170d698e5a7916bf2457edc5de8d")
  expect_identical(md5, exp)
})

test_that("pkg_md5_disk", {
  dir.create(tmp <- tempfile())
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)
  dir.create(file.path(tmp, "libs"))
  dir.create(file.path(tmp, "libs", "i386"))
  dir.create(file.path(tmp, "libs", "x64"))
  writeBin(charToRaw("foo\n"), con = file.path(tmp, "libs", "i386", "foo.dll"))
  writeBin(charToRaw("bar\n"), con = file.path(tmp, "libs", "x64", "foo.dll"))
  md5 <- pkg_md5_disk(tmp)

  exp <- c(`libs/i386/foo.dll` = "d3b07384d113edec49eaa6238ad5ff00",
           `libs/x64/foo.dll` = "c157a79031e1c40f85931829bc5fc552")
  expect_identical(md5,exp)
})

test_that("print.packages_info", {
  info <- readRDS(paste0("fixtures/devtools-info-", .Platform$OS.type, ".rda"))
  expect_output(
    print(info), "package    * version     date       lib source",
    fixed = TRUE
  )
})

test_that("print.packages_info ignores max.print", {
  info <- readRDS(paste0("fixtures/devtools-info-", .Platform$OS.type, ".rda"))
  withr::local_options(list(max.print = 1))
  out <- capture_output(print(info))
  out <- tail(strsplit(out, split = "\r?\n")[[1]], -1)
  expect_length(out, nrow(info) + 3)
})
