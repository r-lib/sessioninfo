
test_that("session_diff", {
  lines1 <- readLines(test_path("fixtures", "lines1.txt"))
  lines2 <- readLines(test_path("fixtures", "lines2.txt"))
  sd <- session_diff(lines1, lines2)
  expect_equal(sd$old$si, lines1)
  expect_equal(sd$old$arg, lines1)
  expect_equal(sd$old$text, lines1)
  expect_equal(sd$new$si, lines2)
  expect_equal(sd$new$arg, lines2)
  expect_equal(sd$new$text, lines2)

  sd$old$si <- sd$old$arg <- sd$old$text <- NULL
  sd$new$si <- sd$new$arg <- sd$new$text <- NULL
  expect_snapshot(class(sd))
  expect_snapshot(unclass(sd))
})

test_that("format.session_diff", {
  # tested via print
  expect_true(TRUE)
})

test_that("print.session_diff", {
  lines1 <- readLines(test_path("fixtures", "lines1.txt"))
  lines2 <- readLines(test_path("fixtures", "lines2.txt"))
  expect_snapshot(print(session_diff(lines1, lines2)))
})

test_that("get_session_info 1", {
  arg <- NULL
  abort <- function(...) stop("test failure")
  local_mocked_bindings(get_session_info_local = function() abort)
  local_mocked_bindings(get_session_info_clipboard = function() abort)
  local_mocked_bindings(get_session_info_url = function() abort)
  local_mocked_bindings(get_session_info_literal = function() abort)

  local_mocked_bindings(
    get_session_info_local = function(...) arg <<- list(...)
  )
  get_session_info("local", pkgs = "foo")
  expect_equal(arg, list(pkgs = "foo"))

  arg <- NULL
  local_mocked_bindings(get_session_info_local = function() abort)
  local_mocked_bindings(
    get_session_info_clipboard = function(...) arg <<- list(...)
  )
  get_session_info("clipboard", pkgs = "foo")
  expect_equal(arg, list())

  arg <- NULL
  local_mocked_bindings(get_session_info_clipboard = function() abort)
  local_mocked_bindings(get_session_info_url = function(...) arg <<- list(...))
  get_session_info("https://acme.com", pkgs = "foo")
  expect_equal(arg, list("https://acme.com"))

  arg <- NULL
  local_mocked_bindings(get_session_info_url = function() abort)
  local_mocked_bindings(
    get_session_info_literal = function(...) arg <<- list(...)
  )
  get_session_info(c("foo", "bar"), pkgs = "foo")
  expect_equal(arg, list(c("foo", "bar")))
})

test_that("get_session_info_local", {
  expect_equal(
    get_session_info_local()$text,
    format(session_info())
  )
})

test_that("get_session_info_clipboard", {
  lines <- readLines(test_path("fixtures", "lines1.txt"))
  local_mocked_bindings(clipboard_read = function() lines)
  clp <- get_session_info_clipboard()
  expect_equal(clp$arg, "<clipboard>")
  expect_equal(
    clp$text,
    get_session_info_literal(lines)$text
  )

  local_mocked_bindings(clipboard_read = function() "clipboard")
  expect_equal(get_session_info_clipboard()$text, "clipboard")
})

test_that("get_session_info_url", {
  html <- readLines(
    gz <- gzfile(test_path("fixtures", "gh.html.gz")),
    encoding = "UTF-8"
  )
  close(gz)

  local_mocked_bindings(
    download.file = function(url, destfile, ...) writeLines(html, destfile),
    .package = "utils"
  )

  url <- "https://github.com/r-lib/sessioninfo/issues/6"
  expect_equal(
    get_session_info_url(url),
    find_session_info_in_html(url, html)
  )
})

test_that("find_session_info_in_html", {
  # We skip this on old R, because it does not calculate the width
  # of the emojis properly, and that messes up the output of the
  # character vector of lines. We also cannot compare the UTF-8 text
  # on Windows.
  if (getRversion() < "4.0") skip("Needs R 4.0 at least")
  skip_on_os("windows")

  html <- readLines(
    gz <- gzfile(test_path("fixtures", "gh.html.gz")),
    encoding = "UTF-8"
  )
  close(gz)

  url <- "https://github.com/r-lib/sessioninfo/issues/6"
  expect_snapshot(
    find_session_info_in_html(url, html)$text
  )

  url2 <- paste0(url, "#issuecomment-937782988")
  expect_snapshot(
    find_session_info_in_html(url2, html)$text
  )

  url3 <- paste0(url, "#dfgdfgdfgdfgdfgdfg")
  expect_equal(
    find_session_info_in_html(url, html)$text,
    find_session_info_in_html(url3, html)$text
  )

  html <- html[
    !grepl("^(#&gt;)?[ ]*\\[[0-9]\\] ", html) &
    !grepl("^(#&gt;)?[ ]*[-\u2500]+$", html)
  ]
  expect_error(
    find_session_info_in_html(url, html),
    "Cannot parse session info"
  )

  re_start <- "[-=\u2500\u2550][ ]Session info[ ]"
  html <- html[!grepl(re_start, html)]
  expect_error(
    find_session_info_in_html(url, html),
    "Cannot find session info"
  )
})

test_that("parse_url", {
  expect_snapshot(parse_url(
    "https://github.com/r-lib/sessioninfo/issues/6"
  ))
  expect_snapshot(parse_url(
    "https://github.com/r-lib/sessioninfo/issues/6#issuecomment-937772467"
  ))
})

test_that("get_session_info_literal", {
  si <- session_info()
  expect_equal(
    get_session_info_literal(si),
    list(arg = si, si = si, text = format(si))
  )

  lines <- format(si)
  expect_equal(
    get_session_info_literal(lines),
    list(arg = lines, si = lines, text = lines)
  )

  col <- paste0("\033[31m", lines, "\033[39m")
  expect_equal(
    get_session_info_literal(col),
    list(arg = col, si = col, text = lines)
  )

  str <- paste0(lines, collapse = "\n")
  expect_equal(
    get_session_info_literal(str),
    list(arg = str, si = str, text = lines)
  )

  ktr <- paste0("#> ", lines)
  expect_equal(
    get_session_info_literal(ktr),
    list(arg = ktr, si = ktr, text = lines)
  )

  ktr2 <- paste0("#&gt; ", lines)
  expect_equal(
    get_session_info_literal(ktr2),
    list(arg = ktr2, si = ktr2, text = lines)
  )

  expect_error(
    get_session_info_literal(structure(1, class = "foo")),
    "Could not interpret"
  )
})

test_that("strsplitx", {
  expect_equal(strsplitx("", "\n"), list(""))
})

test_that("check_session_info", {
  expect_warning(
    check_session_info("foo"),
    "This does not look like"
  )
  expect_silent(check_session_info("- Session info"))
  expect_silent(check_session_info("= Session info"))
  expect_silent(check_session_info("\u2500 Session info"))
  expect_silent(check_session_info("\u2550 Session info"))
})

test_that("beginning", {
  expect_snapshot(beginning("foo\nbar\nfoobar\nnotthis"))
  expect_snapshot(beginning(c("foo", "bar", "foobar", "notthis")))
  expect_snapshot(beginning(strrep("123456789 ", 20)))
})

test_that("session_diff_text", {
  x <- c("", "  ", " date 2020-01-01", "foo", "bar", "   ", "")
  y <- c(" date 2010-01-01", "foo", "baz", "")
  expect_snapshot(print(session_diff_text(x, y)))

  # if matching packages fails, we still have meaningful output
  local_mocked_bindings(expand_diff_text = function(...) stop())
  expect_snapshot(print(session_diff_text(x, y)))
})

test_that("diff_drop_empty", {
  cases <- list(
    list(character(), character()),
    list("foo", "foo"),
    list(c("", "foo"), "foo"),
    list(c("  ", "", "foo"), "foo"),
    list(c("", "foo", ""), "foo"),
    list(c("  ", "", "foo", "", "  "), "foo"),
    list(c("foo", "", "   "), "foo")
  )

  for (c in cases) {
    expect_equal(diff_drop_empty(c[[1]]), c[[2]], info = c[[1]])
  }
})

test_that("diff_no_date", {
  x <- c("foo", "date 2000-01-01", "date 2000-01-01")
  expect_equal(diff_no_date(x), x[-2])
  x2 <- c("foo", "   date 2000-01-01", "date 2000-01-01")
  expect_equal(diff_no_date(x2), x2[-2])
  x3 <- c("foo", "bar")
  expect_equal(diff_no_date(x3), x3)
})

test_that("diff_min_line", {
  x <- c("= 3456 ============", "- 345678 -----------", strrep("x", 1000))
  x2 <- gsub("=", "\u2550", gsub("-", "\u2500", x))
  expect_equal(diff_min_line(x), 19)
  expect_equal(diff_min_line(x2), 19)
  expect_equal(diff_min_line(strrep("-", 100)), 80)
})

test_that("diff_fix_lines", {
  x <- c("= 3456 ============", "foo", "- 345678 ----------", "bar")
  x2 <- gsub("=", "\u2550", gsub("-", "\u2500", x))
  exp <- c("= 3456 ===", "foo", "- 345678 -", "bar")
  exp2 <- gsub("=", "\u2550", gsub("-", "\u2500", exp))
  expect_equal(diff_fix_lines(x, 10), exp)
  expect_equal(diff_fix_lines(x2, 10), exp)

  withr::local_options(cli.unicode = TRUE)
  expect_equal(diff_fix_lines(x, 10), exp2)
  expect_equal(diff_fix_lines(x2, 10), exp2)
})

test_that("expand_diff_text", {
  lines1 <- readLines(test_path("fixtures", "lines1.txt"))
  lines2 <- readLines(test_path("fixtures", "lines2.txt"))
  xp1 <- expand_diff_text(lines1, lines2)
  expect_snapshot(xp1)

  xp2 <- expand_diff_text(lines2, lines1)
  expect_equal(xp1$old, xp2$new)
  expect_equal(xp1$new, xp2$old)

  expect_equal(
    expand_diff_text(lines1, "foobar"),
    list(old = lines1, new = "foobar")
  )
})

test_that("insert_instead", {
  cases <- list(
    list(1:10, 1,  1,  11:15, c(11:15, 2:10)),
    list(1:10, 1,  3,  11:15, c(11:15, 4:10)),
    list(1:10, 2,  2,  11:15, c(1, 11:15, 3:10)),
    list(1:10, 2,  5,  11:15, c(1, 11:15, 6:10)),
    list(1:10, 5,  10, 11:15, c(1:4, 11:15)),
    list(1:10, 10, 10, 11:15, c(1:9, 11:15)),
    list(1:10, 1,  10, 11:15, c(11:15)),
    list(1,    1,  1,  11:15, c(11:15)),
    list(1:10, 0,  0,  11:15, c(11:15, 1:10)),
    list(1:10, 11, 11, 11:15, c(1:10, 11:15)),
    list(1:10, 2,  1,  11:15, c(1, 11:15, 2:10))
  )

  for (i in seq_along(cases)) {
    c <- cases[[i]]
    expect_equal(
      insert_instead(c[[1]], c[[2]], c[[3]], c[[4]]),
      c[[5]],
      info = i
    )
  }
})

test_that("parse_pkgs", {
  lines <- readLines(test_path("fixtures", "lines4.txt"))
  pkgs <- parse_pkgs(lines)
  expect_equal(pkgs$begin, 17)
  expect_equal(pkgs$end, 40)
  expect_snapshot(names(pkgs$pkgs))
  expect_snapshot(pkgs$pkgs[["!"]])
  expect_snapshot(pkgs$pkgs$package)
  expect_snapshot(pkgs$pkgs)

  pkgs2 <- parse_pkgs(lines[1:40])
  expect_equal(pkgs, pkgs2)

  expect_null(parse_pkgs("foobar"))
})

test_that("parse_pkgs_section", {
  lines <- readLines(test_path("fixtures", "lines3.txt"))
  pkgs <- parse_pkgs_section(lines)
  expect_snapshot(names(pkgs))
  expect_snapshot(pkgs[["!"]])
  expect_snapshot(pkgs$package)
  expect_snapshot(pkgs)

  lines2 <- c(
    " package     * version    date (UTC) lib source",
    " cli           3.0.1.9000 2021-10-11 [1] local",
    " crayon        1.4.1      2021-02-08 [1] CRAN (R 4.1.0)",
    " prettycode    1.1.0      2019-12-16 [1] CRAN (R 4.1.0)",
    " prompt        1.0.0      2021-03-02 [1] local",
    " ps            1.6.0      2021-02-28 [1] CRAN (R 4.1.0)",
    " sessioninfo   1.1.1.9000 2021-10-12 [1] local",
    " withr         2.4.2      2021-04-18 [1] CRAN (R 4.1.0)"
  )
  pkgs2 <- parse_pkgs_section(lines2)
  expect_snapshot(names(pkgs2))
  expect_snapshot(pkgs2[["!"]])
  expect_snapshot(pkgs2$package)
  expect_snapshot(pkgs2)
})

test_that("find_word_lengths", {
  cases <- list(
    list("", numeric()),
    list(" ", numeric()),
    list("   ", numeric()),
    list("x", 2),
    list(" x", 3),
    list(" x ", 4),
    list("foo bar", c(4, 4)),
    list("foo    bar", c(7, 4)),
    list(" foo", 5),
    list("  foo   bar", c(8, 4))
  )
  for (c in cases) {
    expect_equal(find_word_lengths(c[[1]]), c[[2]], info = c[[1]])
  }
})

test_that("get_symbol_name", {
  expect_equal(get_symbol_name(as.symbol("x")), "x")
  expect_equal(get_symbol_name("x"), "x")
  expect_null(get_symbol_name(call("foo", "bar")))
})
