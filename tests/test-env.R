
env <- Sys.getenv()
chk <- grep("^_R_CHECK_", names(env))
print(env[chk])
