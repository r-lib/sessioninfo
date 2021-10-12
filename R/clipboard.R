
get_os <- function() {
  if (.Platform$OS.type == "windows") {
    "win"
  } else if (Sys.info()["sysname"] == "Darwin") {
    "mac"
  } else {
    "unix"
  }
}

clipboard_read <- function() {
  os <- get_os()

  switch(
    os,
    win = utils::readClipboard(),
    mac = clipboard_read_mac(),
    clipboard_read_x11()
  )
}

clipboard_read_mac <- function() {
  on.exit(try(close(con), silent = TRUE), add = TRUE)
  con <- pipe("pbpaste")
  scan(con, what = "", sep = "\n", blank.lines.skip = FALSE, quiet = TRUE)
}

clipboard_read_x11 <- function() {
  on.exit(try(close(con), silent = TRUE), add = TRUE)
  con <- file("clipboard")
  scan(con, what = "", sep = "\n", blank.lines.skip = FALSE, quiet = TRUE)
}
