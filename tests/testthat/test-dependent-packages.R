
context("dependent_packages")

test_that("dependent_packages", {
  ins <- readRDS("fixtures/installed.rda")
  dep <- readRDS("fixtures/devtools-deps.rda")
  alldsc <- readRDS("fixtures/descs.rda")

  mockery::stub(dependent_packages, 'utils::installed.packages', ins)
  mockery::stub(
    dependent_packages,
    'pkg_desc',
    function(x) alldsc[[x]]
  )
  mockery::stub(
    dependent_packages,
    'loadedNamespaces',
    function() ins
  )

  mockery::stub(
    dependent_packages,
    'getNamespaceVersion',
    function(x) alldsc[[x]]$Version
  )
  mockery::stub(
    dependent_packages,
    'search',
    function() paste0("package:", dep$package[dep$attached])
  )
  mockery::stub(
    dependent_packages,
    'getNamespaceInfo',
    function(x, ...) alldsc[[x]]$Version
  )

  exp <- dep[, setdiff(colnames(dep), c("path", "loadedpath"))]
  tec <- dependent_packages("devtools", NA)
  tec <- tec[, setdiff(colnames(tec), c("path", "loadedpath"))]
  expect_equal(exp, tec)
})

test_that("pkg_path_disk", {
  p1 <- pkg_path_disk(utils::packageDescription("stats"))
  expect_equal(
    read.dcf(file.path(p1, "DESCRIPTION"))[, "Package"],
    c(Package = "stats")
  )
})

test_that("find_deps", {
  ins <- readRDS("fixtures/installed.rda")
  expect_equal(
    sort_ci(find_deps("devtools", ins)),
    sort_ci(
      c("devtools", "callr", "httr", "utils", "tools", "methods", "memoise",
        "whisker", "digest", "rstudioapi", "jsonlite", "stats", "git2r",
        "withr", "pkgbuild", "pkgload", "curl", "crayon", "testthat",
        "BiocInstaller", "Rcpp", "MASS", "rmarkdown", "knitr", "hunspell",
        "lintr", "bitops", "roxygen2", "evaluate", "rversions", "covr",
        "gmailr", "processx", "R6", "assertthat", "debugme", "grDevices",
        "graphics", "mime", "openssl", "desc", "rprojroot", "backports",
        "praise", "magrittr", "xml2", "BH", "yaml", "htmltools", "caTools",
        "base64enc", "stringr", "highr", "markdown", "stringi", "rex",
        "codetools", "stringdist", "xmlparsedata", "lazyeval", "parallel",
        "brew", "commonmark")
    )
  )

  ## An edge case
  expect_equal(
    find_deps("foobar", top_dep = character(), rec_dep = character()),
    "foobar"
  )
})
