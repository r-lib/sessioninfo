
test_that("unknown os name", {
  local_mocked_bindings(
    sessionInfo = function(...) list(running = NULL), .package = "utils"
  )
  expect_equal(os_name(), NA_character_)
})
