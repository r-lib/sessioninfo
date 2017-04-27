
context("dependent_packages")

test_that("dependent_packages", {
  ins <- readRDS("fixtures/installed.rda")
  dep <- readRDS("fixtures/devtools-deps.rda")
  alldsc <- readRDS("fixtures/descs.rda")

  mockery::stub(dependent_packages, 'utils::installed.packages', ins)
  mockery::stub(
    dependent_packages,
    'utils::packageDescription',
    function(x) alldsc[[x]]
  )

  exp <- dep[, setdiff(colnames(dep), "path")]
  tec <- dependent_packages("devtools")
  tec <- tec[, setdiff(colnames(tec), "path")]
  expect_equal(exp, tec)
})

test_that("pkg_path", {
  p1 <- pkg_path(utils::packageDescription("stats"))
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
})

test_that("standardise_dep", {

  cases <- list(
    NA,
    TRUE,
    FALSE,
    "Imports"
  )

  for (c in cases) {
    expect_true(
      all(standardise_dep(c) %in%
          c("Depends", "Imports", "Suggests", "LinkingTo"))
    )
  }

  expect_error(
    standardise_dep(list(1,2,3)),
    "Dependencies must be a boolean or a character"
  )
})
