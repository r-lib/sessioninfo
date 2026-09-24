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
  expect_output(
    print(si),
    "package[ ]+\\* version[ ]+date[ ][(]UTC[)][ ]+lib[ ]+source"
  )
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

test_that("toLatex.session_info", {
  si <- session_info()
  latex_output <- toLatex(si)

  # make sure this has the Latex class
  expect_s3_class(latex_output, "Latex")
  expect_type(latex_output, "character")

  # make sure this has a "Session info" section with a LaTeX list
  expect_true(any(grepl("\\\\textbf\\{Session info\\}", latex_output)))
  expect_true(any(grepl("\\\\begin\\{itemize\\}\\\\raggedright", latex_output)))
  expect_true(any(grepl("\\\\end\\{itemize\\}", latex_output)))
})

test_that("`toLatex()` uses correct package versions", {
  # This is important for session_info(pkgs = "installed"); if a package isn't
  # loaded, its loadedVersion is NA

  # Make a session_info() object with an unloaded package
  mock_packages <- data.frame(
    package = c("base", "loaded_pkg", "unloaded_pkg"),
    loadedversion = c("4.5.1", "1.2.3", NA),
    ondiskversion = c("4.5.1", "1.2.3", "2.0.0"),
    is_base = c(TRUE, FALSE, FALSE)
  )

  mock_si <- list(
    platform = list(version = "R version 4.5.1"),
    packages = mock_packages
  )
  class(mock_si) <- "session_info"

  local_mocked_bindings(session_info = function(...) mock_si)

  si <- session_info()
  latex_output <- toLatex(si)
  latex_string <- paste(latex_output, collapse = " ")

  # Should use loadedversion when available
  expect_true(grepl("loaded_pkg \\(1\\.2\\.3\\)", latex_string))

  # Should use ondiskversion when loadedversion is NA
  expect_true(grepl("unloaded_pkg \\(2\\.0\\.0\\)", latex_string))
})
