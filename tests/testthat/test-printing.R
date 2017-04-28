
context("printing")

test_that("rule", {
  expect_match(
    withr::with_options(list(width = 20), rule("test", pad = "-")),
    "- test -----------",
    fixed = TRUE
  )
})
