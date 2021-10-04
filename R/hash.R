
# TODO: this can use cli, once a new version with cli::hash_emoji() is
# release to CRAN

add_hash <- function(si, size = 3) {
  stopifnot(size >= 1, size <= 4)

  orig <- si
  # drop the date for hashing
  if ("platform" %in% names(si) && "date" %in% names(si$platform)) {
    si$platform$date <- NULL
  }

  old <- options(
    cli.unicode = FALSE,
    cli.num_colors = 1,
    sessioninfo.emoji = FALSE
  )
  on.exit(options(old), add = TRUE)
  tmp <- tempfile()
  writeLines(format(si), tmp)
  on.exit(unlink(tmp), add = TRUE)

  md5 <- tools::md5sum(tmp)[[1]]
  md513 <- substr(md5, 1, 13)
  mdint <- as.integer(as.hexmode(strsplit(md513, "")[[1]]))
  hash <- sum(mdint * 16^(0:12))

  base <- nrow(emojis)
  ehash <- hash %% (base ** size)
  digits <- integer()
  while (ehash > 0) {
    digits <-  c(digits, ehash %% base)
    ehash <- ehash %/% base
  }
  digits <- c(digits, rep(0, 10))[1:size]

  nms <- emojis$name[digits + 1]
  emo <- emojis$emoji[digits + 1]

  orig$hash <- list(emoji = emo, emo_text = nms)
  orig
}
