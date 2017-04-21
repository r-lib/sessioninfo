
context("utils")

test_that("sort_ci", {
  expect_equal(
    sort_ci(c("ant", "\u00a0nt", "bottom")),
    c("ant", "bottom", "\u00a0nt")
  )
})
