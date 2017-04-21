
context("platform_info")

test_that("platform_info", {
  pi <- platform_info()
  expect_equal(
    names(pi),
    c("version", "os", "system", "ui", "language", "collate", "tz", "date")
  )

  expect_match(pi$version, "R version [0-9][.][0-9]")
  expect_true(is_string(pi$os))
  expect_true(is_string(pi$system) && grepl(",", pi$system))
  expect_true(is_string(pi$ui))
  expect_true(is_string(pi$language))
  expect_true(is_string(pi$tz))
  expect_true(is_string(pi$date))
  expect_equal(pi$date, as.character(as.Date(pi$date)))
})

test_that("print.platform_info", {
  expect_output(print(platform_info()), "setting  value", fixed = TRUE)
})
