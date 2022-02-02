
#' Compare session information from two sources
#'
#' @param old,new A `session_info` object (the return value of
#' [session_info()]), or a pointer to [session_info()] output. See details
#' below.
#' @param ... Passed to any new [session_info()] calls.
#'
#' @details
#' Various way to specify `old` and `new`:
#' * A `session_info` object.
#' * `"local"` runs [session_info()] in the current
#'   session, and uses its output.
#' * `"clipboard"` takes the session info from the system clipboard.
#'   If the clipboard contains a URL, it is followed to download the
#'   session info.
#' * The URL where you inspect the results for a GitHub Actions job.
#'   Typically has this form:
#'   ```
#'   https://github.com/OWNER/REPO/runs/JOB_ID?check_suite_focus=true
#'   ```
#' * Any other URL starting with `http://` or `https://`. `session_diff()`
#'   searches the HTML (or text) page for the session info header to find the
#'   session info.
#'
#'
#' @export
#' @examplesIf FALSE
#' session_diff()

session_diff <- function(old = "local", new = "clipboard", ...) {

  oldname <- get_symbol_name(substitute(old))
  newname <- get_symbol_name(substitute(new))

  old <- get_session_info(old, oldname %||% "old", ...)
  new <- get_session_info(new, newname %||% "new", ...)

  ret <- list(
    old = old,
    new = new,
    diff = session_diff_text(old$text, new$text)
  )

  class(ret) <- c("session_diff", "list")
  ret
}

#' @export

format.session_diff <- function(x, ...) {
  c(
    cli::style_bold(paste0("--- ", substr(x$old$name, 1, 78))),
    cli::style_bold(paste0("+++ ", substr(x$new$name, 1, 78))),
    format(x$diff, context = Inf)
  )
}

#' @export

print.session_diff <- function(x, ...) {
  writeLines(format(x, ...))
}

get_session_info <- function(src, name = NULL, ...) {
  si <- if (is_string(src) == 1 && src == "local") {
    get_session_info_local(...)
  } else if (is_string(src) == 1 && src == "clipboard") {
    get_session_info_clipboard()
  } else if (is_string(src) && is_gha_url(src)) {
    get_session_info_gha(src)
  } else if (is_string(src) && grepl("https?://", src)) {
    get_session_info_url(src)
  } else {
    get_session_info_literal(src)
  }
  if (is.null(si$name)) si$name <- name
  si
}

get_session_info_local <- function(...) {
  si <- session_info(...)
  old <- options(cli.num_colors = 1)
  on.exit(options(old), add = TRUE)
  list(arg = "local", si = si, text = format(si))
}

get_session_info_clipboard <- function() {
  cnt <- clipboard_read()
  if (is_string(cnt) && cnt == "clipboard") {
    si <- list(arg = "clipboard", si = cnt, text = cnt)
  } else {
    si <- get_session_info(cnt)
  }
  si$arg <- "<clipboard>"
  si
}

get_session_info_url <- function(url) {
  tmp <- tempfile("session-diff-")
  on.exit(unlink(tmp), add = TRUE)
  suppressWarnings(utils::download.file(url, tmp, quiet = TRUE, mode = "wb"))
  html <- readLines(url, warn = FALSE, encoding = "UTF-8")
  find_session_info_in_html(url, html)
}

find_session_info_in_html <- function(url, lines) {
  purl <- parse_url(url)
  re_start <- "[-=\u2500\u2550][ ]Session info[ ]"
  cand <- grep(re_start, lines)
  if (length(cand) == 0) stop("Cannot find session info at '", url, "'.")

  # check if the URL has an anchor and that the anchor exists in HTML
  # if yes, then we "skip" there
  if (purl$anchor != "") {
    anch <- which(
      grepl(paste0(" id=\"", purl$anchor, "\""), lines, fixed = TRUE) |
      grepl(paste0(" id='", purl$anchor, "'"), lines, fixed = TRUE) |
      grepl(paste0(" id = \"", purl$anchor, "\""), lines, fixed = TRUE) |
      grepl(paste0(" id = '", purl$anchor, "'"), lines, fixed = TRUE)
    )[1]
    if (!is.na(anch) && any(anch < cand)) {
      lines <- lines[anch:length(lines)]
      cand <- grep(re_start, lines)
    } else {
      url <- sub(paste0("#", purl$anchor), "", url)
    }
  }

  lines <- lines[cand[1]:length(lines)]
  lines[1] <- sub(paste0("^.*(", re_start, ")"), "\\1", lines[1])

  grepl_end <- function(lines) {
    grepl("^(#&gt;)?[ ]*\\[[0-9]\\] ", lines) |
      grepl("^(#&gt;)?[ ]*[-\u2500]+$", lines)
  }

  end <- which(grepl_end(lines))[1]

  if (is.na(end)) stop("Cannot parse session info from '", url, "'.")
  while (end < length(lines) && grepl_end(lines[end + 1])) {
    end <- end + 1
  }

  si <- get_session_info_literal(lines[1:end])
  si$arg <- url
  si$name <- url
  si
}

parse_url <- function (url) {
  re_url <- paste0(
    "^(?<protocol>[a-zA-Z0-9]+)://",
    "(?:(?<username>[^@/:]+)(?::(?<password>[^@/]+))?@)?",
    "(?<host>[^/]+)",
    "(?<path>[^#]*)",
    "#?(?<anchor>.*)$"
  )
  re_match(url, re_url)$groups
}

get_session_info_literal <- function(si) {
  if (inherits(si, "session_info")) {
    old <- options(cli.num_colors = 1)
    on.exit(options(old), add = TRUE)
    list(arg = si, si = si, text = format(si))

  } else if (is.character(si)) {
    # in case it has ANSI sequences
    text <- cli::ansi_strip(si)

    # Might be a single string
    text <- unlist(strsplitx(text, "\n", fixed = TRUE))

    # reprex has the knitr output prefix, remove it
    # order is important here
    text <- sub("^#&gt;[ ]?", "", text)
    text <- sub("^#[>#]?[ ]?", "", text)

    check_session_info(text)
    list(arg = si, si = si, text = text)

  } else {
    stop("Could not interpret a `", class(si), "` as a session info.")
  }
}

# strsplit("", "\n") -> character(), but it should be the empty string,
# so we fix this.

strsplitx <- function(...) {
  lapply(strsplit(...), paste0, "")
}

check_session_info <- function(x) {
  if (!any(grepl("[-=\u2500\u2550] Session info", x))) {
    warning("This does not look like a session info: '", beginning(x), "'.")
  }
}

beginning <- function(x) {
  x123 <- utils::head(unlist(strsplit(x, "\n", fixed = TRUE)), 3)
  trimws(substr(paste0(x123, sep = "\n"), 1, 100))
}

session_diff_text <- function(old, new) {
  old <- enc2utf8(old)
  new <- enc2utf8(new)

  old <- diff_drop_empty(old)
  new <- diff_drop_empty(new)

  old <- diff_no_date(old)
  new <- diff_no_date(new)

  min <- diff_min_line(c(old, new))
  old <- diff_fix_lines(old, min)
  new <- diff_fix_lines(new, min)

  # expand thinner package info to match the wider one
  # do not error, in case we cannot parse sessioninfo output
  suppressWarnings(tryCatch({
    exp <- expand_diff_text(old, new)
    old <- exp$old
    new <- exp$new
  }, error = function(e) NULL))

  old2 <- gsub("\\s+", " ", old)
  new2 <- gsub("\\s+", " ", new)

  diff <- cli::diff_chr(old2, new2)
  diff$old <- old
  diff$new <- new
  diff
}

# drop leading and trailing empty lines

diff_drop_empty <- function(x) {
  len <- length(x)
  if (len == 0) return(x)

  empty <- rle(grepl("^\\s*$", x))
  pre <- if (empty$values[1]) {
    1:empty$lengths[1]
  }
  post <- if (utils::tail(empty$values, 1)) {
    (len - utils::tail(empty$lengths, 1) + 1):len
  }
  del <- as.integer(c(pre, post))
  if (length(del)) x <- x[-del]

  x
}

# Drop the first `date` line

diff_no_date <- function(x) {
  date <- grep("^[ ]*date[ ]+[0-9][0-9][0-9][0-9]-", x)
  if (length(date) > 0) {
    x <- x[-date[1]]
  }
  x
}

# Calculate the minimum width of the header lines

diff_min_line <- function(x) {
  lines <- c(
    grep("[-\u2500][-\u2500][-\u2500]$", x),
    grep("[=\u2550][=\u2550][=\u2550]$", x)
  )
  min(c(80, cli::utf8_nchar(x[lines], "width")))
}

diff_fix_lines <- function(x, w) {
  slines <- grepl("[-\u2500]+$", x)
  dlines <- grepl("[=\u2550]+$", x)
  x[slines] <- gsub("[-\u2500]", cli::symbol$line, x[slines])
  x[dlines] <- gsub("[=\u2550]", cli::symbol$double_line, x[dlines])
  x[slines] <- substr(x[slines], 1, w)
  x[dlines] <- substr(x[dlines], 1, w)
  x
}

expand_diff_text <- function(old, new) {
  opkgs <- parse_pkgs(old)
  npkgs <- parse_pkgs(new)

  if (is.null(opkgs) || is.null(opkgs)) return(list(old = old, new = new))

  # Add the "!" column if needed
  if ("!" %in% names(opkgs$pkgs) || "!" %in% names(npkgs$pkgs)) {
    if (! "!" %in% names(opkgs$pkgs)) {
      opkgs$pkgs <- cbind("!" = "", opkgs$pkgs, stringsAsFactors = FALSE)
    }
    if (! "!" %in% names(npkgs$pkgs)) {
      npkgs$pkgs <- cbind("!" = "", npkgs$pkgs, stringsAsFactors = FALSE)
    }
  }

  # If the column names differ, we keep it as is
  onms <- names(opkgs$pkgs)
  nnms <- names(npkgs$pkgs)
  if (length(onms) != length(nnms) || any(onms != nnms)) {
    return(list(old = old, new = new))
  }

  cmn <- rbind(opkgs$pkgs, npkgs$pkgs)
  oldopts <- options(cli.num_colors = 1)
  on.exit(options(oldopts), add = TRUE)
  fmt <- format_df(cmn)

  oend <- opkgs$end - opkgs$begin + 1L
  nend <- oend + npkgs$end - npkgs$begin
  fmt_old <- c(fmt[1], fmt[2:oend])
  fmt_new <- c(fmt[1], fmt[(oend+1):(nend)])

  old <- insert_instead(old, opkgs$begin, opkgs$end, fmt_old)
  new <- insert_instead(new, npkgs$begin, npkgs$end, fmt_new)

  list(old = old, new = new)
}

insert_instead <- function(orig, from, to, new) {
  pre <- if (from > 1) orig[1:(from-1)]
  pst <- if (to < length(orig)) orig[(to+1):length(orig)]
  c(pre, new, pst)
}

parse_pkgs <- function(lines) {
  begin <- grep("^[-\u2500] Packages ", lines) + 1

  # back out if no Packages header
  if (length(begin) != 1 || length(begin) > length(lines)) return(NULL)

  # now find the end
  end <- begin + grep(
    "^\\s*[!a-zA-Z]",
    lines[begin:length(lines)],
    invert = TRUE,
    perl = TRUE
  )[1] - 2
  if (is.na(end)) end <- length(lines)

  pkgs <- parse_pkgs_section(lines[begin:end])

  list(begin = begin, end = end, pkgs = pkgs)
}

parse_pkgs_section <- function(lines) {
  lines[1] <- sub(" date  ", " date (UTC) ", fixed = TRUE, lines[1])
  hdr <- sub("date (UTC)", "date-(UTC)", fixed = TRUE, lines[1])
  wth <- find_word_lengths(hdr)
  wth[length(wth)] <- max(nchar(lines))
  df <- utils::read.fwf(textConnection(lines), widths = wth)
  df[] <- lapply(df, trimws)
  names(df) <- as.character(df[1,])
  df <- df[-1, , drop = FALSE]
  rownames(df) <- NULL
  df
}

find_word_lengths <- function(x) {
  # add a dummy word to the end for simplicity
  tmp <- paste0(gsub("[^\\s]", "X", x, perl = TRUE), " X")

  # word & ws lengths, but first absorb leading space into the first word
  ltr <- strsplit(tmp, "")[[1]]
  rl <- rle(ltr)
  if (ltr[1] == " ") {
    rl$lengths[2] <- rl$lengths[2] + rl$lengths[1]
    rl$lengths <- rl$lengths[-1]
    rl$values <- rl$values[-1]
  }

  # positions of "X" and " " parts
  pos <- cumsum(c(1, rl$lengths))

  # lengths of words, this drops the dummy word
  wpos <- which(rl$values == "X")
  pos[wpos[-1]] - pos[wpos[-length(wpos)]]
}

get_symbol_name <- function(x) {
  if (is.symbol(x)) {
    as.character(x)
  } else if (is_string(x)) {
    x
  }
}
