test_that("unknown os name", {
  mockery::stub(os_name, "utils::sessionInfo", list(running = NULL))
  expect_equal(os_name(), NA_character_)
})
