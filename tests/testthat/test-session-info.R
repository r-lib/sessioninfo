
test_that("session_info", {
  info <- readRDS(paste0("fixtures/devtools-info-", .Platform$OS.type, ".rda"))
  local_mocked_bindings(package_info = function(...) pi)

  si <- session_info()
  expect_equal(si$platform, platform_info())
  expect_equal(si$packages, pi)
})

test_that("print.session_info", {
  si <- session_info()
  expect_output(print(si), "setting[ ]+value")
  expect_output(print(si), "package[ ]+\\* version[ ]+date[ ][(]UTC[)][ ]+lib[ ]+source")
})

test_that("`info` can include one or multiple values", {
  choices <- c("platform", "packages", "python", "external")

  # including "all" results in all info being selected
  expect_named(
    session_info(info = "all"),
    choices,
    ignore.order = TRUE
  )
  # even when other items are included
  expect_named(
    session_info(info = c("all", "platform")),
    choices,
    ignore.order = TRUE
  )

  # including "auto" (and not "all") results in auto info being included
  expect_gte(
    length(names(session_info(info = "auto"))),
    2
  )
  # even when other items are included
  expect_gte(
    length(names(session_info(info = c("auto", "platform")))),
    2
  )

  # with neither "all" or "auto", valid items are included
  expect_named(
    session_info(info = c("platform", "python", "external", "nonvalid-info")),
    c("platform", "python", "external"),
    ignore.order = TRUE
  )

})
