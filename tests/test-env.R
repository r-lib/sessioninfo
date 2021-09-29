
env <- Sys.getenv()
chk <- grep("^_R_CHECK_", names(env))
write.csv(
  data.frame(
    var = names(env[chk]),
    val = unclass(env)[chk],
    stringsAsFactors = FALSE
  ),
  "",
  row.names = FALSE
)
