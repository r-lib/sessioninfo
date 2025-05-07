test_that("sort_ci", {
  expect_equal(
    sort_ci(c("ant", "\u00a0nt", "bottom")),
    c("ant", "bottom", "\u00a0nt")
  )
})

test_that("order_by_name", {
  expect_equal(order_by_name(list()), list())

  expect_snapshot(error = TRUE, order_by_name(c("foo", "bar")))
})
