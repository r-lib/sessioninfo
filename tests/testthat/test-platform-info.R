
context("platform_info")

test_that("platform_info", {
  pi <- platform_info()
  expect_equal(
    names(pi),
    c("version", "os", "system", "ui", "language", "collate", "ctype", "tz", "date")
  )

  ## This can be a variety of strings, e.g. "R Under development"
  expect_match(pi$version, "R ")
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
