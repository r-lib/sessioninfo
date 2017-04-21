
context("printing")

test_that("rule", {
  expect_output(
    withr::with_options(list(width = 20), rule("test", pad = "-")),
    "- test -----------",
    fixed = TRUE
  )
})
