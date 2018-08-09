
# 1.0.0.9000

* `session_info()` and `package_info()` now only lists loaded versions
  for namespaces which are already loaded. This only makes a difference
  if the `pkgs` argument is given.

* Do not consult the `max.print` option, for platform and package info
  (@jennybc, #13).

* Report `LC_CTYPE` in `platform_info()` (@patperry, #11).

# 1.0.0

First public release.
