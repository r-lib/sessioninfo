# taken from usethis
# definitely designed for GitHub URLs but not overtly GitHub-specific
# https://stackoverflow.com/questions/2514859/regular-expression-for-git-repository
# https://git-scm.com/docs/git-clone#_git_urls
# https://stackoverflow.com/questions/27745/getting-parts-of-a-url-regex
github_url_regex <- paste0(
  "^",
  "(?<protocol>\\w+://)?",
  "(?<user>.+@)?",
  "(?<host>[^/:]+)",
  "[/:]",
  "(?<repo_owner>[^/]+)",
  "/",
  "(?<repo_name>[^/#]+)",
  "(?<fragment>.*)",
  "$"
)

parse_as_gha_url <- function(url) {
  res <- re_match(url, github_url_regex)$groups
  res$job_id <- re_match(res$fragment, "^/runs/(?<job_id>[0-9]+).*")$groups$job_id

  ok <- res$host %in% "github.com" &
    !is.na(res$repo_owner) & !is.na(res$repo_name) &!is.na(res$job_id)

  data.frame(
    owner  = ifelse(ok, res$repo_owner, NA_character_),
    repo   = ifelse(ok, res$repo_name, NA_character_),
    job_id = ifelse(ok, res$job_id, NA_character_),
    stringsAsFactors = FALSE,
    row.names = NULL
  )
}

is_gha_url <- function(url) {
  res <- parse_as_gha_url(url)
  !is.na(res$job_id)
}

get_session_info_gha <- function(url) {
  if (!requireNamespace("gh", quietly = TRUE)) {
    stop(
      "The gh package is not available.\n",
      "This appears to be the URL for a GitHub Actions (GHA) log:\n",
      url, "\n",
      "You must install the gh package to get session info for GHA job logs."
    )
  }

  dat <- parse_as_gha_url(url)
  meta <- gh::gh(
    "/repos/{owner}/{repo}/actions/jobs/{job_id}",
    owner = dat$owner, repo = dat$repo, job_id = dat$job_id
  )
  raw_log <- gh::gh(
    "/repos/{owner}/{repo}/actions/jobs/{job_id}/logs",
    owner = dat$owner, repo = dat$repo, job_id = dat$job_id
  )
  timestamped_lines <- unlist(strsplit(raw_log$message, split = "\r\n"))
  lines <- sub("^[^\\s]+\\s+", "", timestamped_lines, perl = TRUE)

  re_start <- "[-=\u2500\u2550][ ]Session info[ ]"
  cand <- grep(re_start, lines)
  if (length(cand) == 0) stop("Cannot find session info at '", url, "'.")
  lines <- lines[cand[1]:length(lines)]
  lines[1] <- sub(paste0("^.*(", re_start, ")"), "\\1", lines[1])

  grepl_end <- function(lines) {
    grepl("^[ ]*\\[[0-9]\\] ", lines) |
      grepl("^[ ]*[-\u2500]+$", lines)
  }
  end <- which(grepl_end(lines))[1]
  if (is.na(end)) stop("Cannot parse session info from '", url, "'.")
  while (end < length(lines) && grepl_end(lines[end + 1])) {
    end <- end + 1
  }

  si <- get_session_info_literal(lines[1:end])

  si$arg <- "github-actions"
  si$name <- paste(
    meta$name,
    meta$conclusion,
    paste("job", meta$id),
    paste("run", meta$run_id),
    sep = " | "
  )
  si
}
