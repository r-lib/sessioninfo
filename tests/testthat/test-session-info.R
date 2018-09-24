
context("session_info")

test_that("session_info", {
  info <- readRDS(paste0("fixtures/devtools-info-", .Platform$OS.type, ".rda"))
  mockery::stub(session_info, "package_info", pi)

  si <- session_info()
  expect_equal(si$platform, platform_info())
  expect_equal(si$packages, pi)
})

test_that("print.session_info", {
  si <- session_info()
  expect_output(print(si), "setting  value", fixed = TRUE)
  expect_output(print(si), "package[ ]+\\* version[ ]+date[ ]+lib[ ]+source")
})
