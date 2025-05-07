test_that("platform_info", {
  withr::local_options(sessioninfo.include_hostname = FALSE)
  pi <- platform_info()
  nms <- c(
    "version",
    "os",
    "system",
    "hostname",
    "ui",
    "language",
    "collate",
    "ctype",
    "tz",
    "date",
    "pandoc",
    "quarto"
  )
  expect_equal(names(pi), setdiff(nms, "hostname"))

  withr::local_options(sessioninfo.include_hostname = TRUE)
  pi <- platform_info()
  expect_equal(names(pi), nms)

  ## This can be a variety of strings, e.g. "R Under development"
  expect_match(pi$version, "R ")
  expect_true(is_string(pi$os))
  expect_true(is_string(pi$system) && grepl(",", pi$system))
  expect_true(is_string(pi$ui))
  expect_true(is_string(pi$language))
  expect_true(is_string(pi$tz) || identical(pi$tz, NA_character_))
  expect_true(is_string(pi$date))
  expect_equal(pi$date, as.character(as.Date(pi$date)))
})

test_that("print.platform_info", {
  expect_output(print(platform_info()), "setting[ ]+value")
})

test_that("print.platform_info ignores max.print", {
  pi <- platform_info()
  withr::local_options(list(max.print = 1))
  out <- capture_output(print(pi))
  out <- tail(strsplit(out, split = "\r?\n")[[1]], -1)
  expect_length(out, length(pi))
})

test_that("get_quarto_version", {
  local_mocked_bindings(Sys.which = function(...) "")
  expect_snapshot(get_quarto_version())

  local_mocked_bindings(Sys.which = function(...) "/path/to/quarto")
  local_mocked_bindings(system2 = function(...) "1.3.450")
  expect_snapshot(get_quarto_version())
})
