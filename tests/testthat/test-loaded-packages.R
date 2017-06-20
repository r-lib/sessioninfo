
context("loaded_packages")

test_that("loaded_packages", {
  lp <- loaded_packages()
  expect_equal(sort_ci(lp$package), sort_ci(loadedNamespaces()))
  expect_identical(
    gsub("-", ".", lp$loadedversion),
    unlist(lapply(lp$package, function(x) as.character(packageVersion(x))))
  )
  expect_true(all(file.exists(lp$path)))
  expect_equal(
    paste0("package:", lp$package) %in% search(),
    lp$attached
  )
})
