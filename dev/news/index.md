# Changelog

## sessioninfo (development version)

## sessioninfo 1.2.4

CRAN release: 2026-06-04

- [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  now does not print a spurious message on Windows when looking up the
  Quarto version ([@kevinushey](https://github.com/kevinushey),
  [\#122](https://github.com/r-lib/sessioninfo/issues/122)).

## sessioninfo 1.2.3

CRAN release: 2025-02-05

- [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  no longer produces an error when `info` has length \> 1
  ([@nash-delcamp-slp](https://github.com/nash-delcamp-slp),
  [\#96](https://github.com/r-lib/sessioninfo/issues/96)).

- Update pkgdown url to sessioninfo.r-lib.org.

- [`session_diff()`](https://sessioninfo.r-lib.org/dev/reference/session_diff.md)
  now accepts the URL to a GitHub Actions log as the source for `new`
  and/or `old` ([@jennybc](https://github.com/jennybc),
  [\#68](https://github.com/r-lib/sessioninfo/issues/68)).

- [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  output now includes an explanation for symbol highlighting packages
  attached to the search path
  ([@IndrajeetPatil](https://github.com/IndrajeetPatil)).

- [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  and
  [`platform_info()`](https://sessioninfo.r-lib.org/dev/reference/platform_info.md)
  now print the host name if the `sessioninfo.include_hostname` global
  option is set to `TRUE`
  ([@certara-jcraig](https://github.com/certara-jcraig),
  [\#99](https://github.com/r-lib/sessioninfo/issues/99)).

- sessioninfo now does not leave behind detritus in the temporary
  directory.

## sessioninfo 1.2.2

CRAN release: 2021-12-06

- This version does not add an emoji hash to the output.

- The `source` column of the output data frame of
  [`package_info()`](https://sessioninfo.r-lib.org/dev/reference/package_info.md)
  (also part of
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)),
  now contains the full SHA for packages installed from GitHub, instead
  of only the first seven characters. This makes it easier to use the
  SHA programmatically. Note that this does not affect formatting and
  printing, which still use the abbreviated SHA.
  ([@muschellij2](https://github.com/muschellij2),
  [\#61](https://github.com/r-lib/sessioninfo/issues/61)).

- RStudio Package Manager (RSPM) and other repository sources are now
  shown in the `source` column, if they set the `Repository` field in
  `DESCRIPTION`.

## sessioninfo 1.2.1

CRAN release: 2021-11-02

- [`package_info()`](https://sessioninfo.r-lib.org/dev/reference/package_info.md)
  and
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  now do not fail if the version number of an installed package is
  invalid.

- Better aliases for the list of attached, loaded and installed packages
  in `package_inf()` and
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md).

## sessioninfo 1.2.0

CRAN release: 2021-10-31

- New function
  [`external_info()`](https://sessioninfo.r-lib.org/dev/reference/external_info.md),
  information about external software. It can be also requested with the
  new `info` argument of
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  ([@llrs](https://github.com/llrs)).

- New function
  [`python_info()`](https://sessioninfo.r-lib.org/dev/reference/python_info.md),
  information about Python configuration. It is automatically included
  in
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  if the reticulate package is loaded and Python is available. You can
  also request it manually via the new `info` argument of
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  ([\#33](https://github.com/r-lib/sessioninfo/issues/33)).

- The output of
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  now has an emoji hash, consisting of three emojis. This allows quick
  comparison of two session infos
  ([\#26](https://github.com/r-lib/sessioninfo/issues/26)).

- All `*_info()` functions use ANSI colors on systems that support them.
  In particular, it highlights unusual package versions and sources, and
  possible package problems
  ([\#3](https://github.com/r-lib/sessioninfo/issues/3)).

- New
  [`session_diff()`](https://sessioninfo.r-lib.org/dev/reference/session_diff.md)
  function, to compare two session infos from various sources
  ([\#6](https://github.com/r-lib/sessioninfo/issues/6)).

- [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  has a new argument named `info`, to select which parts of the session
  information should be printed.

- [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  now has a `to_file` argument, to write the output to a file
  ([\#30](https://github.com/r-lib/sessioninfo/issues/30)).

- `session_inf()` has a `dependencies` argument now, and passes it to
  [`package_info()`](https://sessioninfo.r-lib.org/dev/reference/package_info.md).

- [`package_info()`](https://sessioninfo.r-lib.org/dev/reference/package_info.md)
  and
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  can now list the attached or installed packages, see the `pkgs`
  argument in the manual for details
  ([\#42](https://github.com/r-lib/sessioninfo/issues/42)).

- [`platform_info()`](https://sessioninfo.r-lib.org/dev/reference/platform_info.md)
  and
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  now include the Windows build number in the output
  ([\#40](https://github.com/r-lib/sessioninfo/issues/40)).

- sessioninfo now never wraps the output if the screen is too narrow
  ([\#31](https://github.com/r-lib/sessioninfo/issues/31)).

- All `*_info()` functions have a
  [`format()`](https://rdrr.io/r/base/format.html) S3 method now.

- [`platform_info()`](https://sessioninfo.r-lib.org/dev/reference/platform_info.md)
  and
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  now include the RStudio version if the R session is in RStudio
  ([\#29](https://github.com/r-lib/sessioninfo/issues/29)).

- The `source` column of the package list is now more informative.

## sessioninfo 1.1.1

CRAN release: 2018-11-05

- [`package_info()`](https://sessioninfo.r-lib.org/dev/reference/package_info.md)
  and
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  now detect locally installed packages correctly if they have an empty
  `biocViews` field in \`DESCRIPTION ([@llrs](https://github.com/llrs),
  [\#25](https://github.com/r-lib/sessioninfo/issues/25))

- [`package_info()`](https://sessioninfo.r-lib.org/dev/reference/package_info.md)
  and
  [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  now handle the case when a loaded package was removed from the disk.

## sessioninfo 1.1.0

CRAN release: 2018-09-25

- [`package_info()`](https://sessioninfo.r-lib.org/dev/reference/package_info.md)
  now has a `dependencies` argument, to filter the type of dependent
  packages in the output
  ([\#22](https://github.com/r-lib/sessioninfo/issues/22)).

- [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  and
  [`package_info()`](https://sessioninfo.r-lib.org/dev/reference/package_info.md)
  now show the library search path, and also which library each package
  was loaded from. They also warn if the on-disk version of the package
  has a different path than the loaded version
  ([\#9](https://github.com/r-lib/sessioninfo/issues/9),
  [\#20](https://github.com/r-lib/sessioninfo/issues/20)).

- [`package_info()`](https://sessioninfo.r-lib.org/dev/reference/package_info.md)’s
  `ondiskversion` entry is now correct.

- [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  and
  [`package_info()`](https://sessioninfo.r-lib.org/dev/reference/package_info.md)
  now verify the MD5 hashes of DLL files on Windows, and warns for
  micmatches, as these are usually broken packages
  ([\#12](https://github.com/r-lib/sessioninfo/issues/12),
  [\#16](https://github.com/r-lib/sessioninfo/issues/16)).

- We use now the cli package, instead of clisymbols, and this fixes
  printing bugs in LaTeX documents
  ([\#14](https://github.com/r-lib/sessioninfo/issues/14)).

- [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  and
  [`platform_info()`](https://sessioninfo.r-lib.org/dev/reference/platform_info.md)
  now include the `LC_CTYPE` locale category
  ([@patperry](https://github.com/patperry),
  [\#11](https://github.com/r-lib/sessioninfo/issues/11))

- [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  and
  [`package_info()`](https://sessioninfo.r-lib.org/dev/reference/package_info.md)
  now print source of the CRAN packages in uppercase, always, even if
  they were installed by devtools.

- [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  and
  [`platform_info()`](https://sessioninfo.r-lib.org/dev/reference/platform_info.md)
  now handle the case when `utils::sessionInfo()$running` is `NULL`
  ([@HenrikBengtsson](https://github.com/HenrikBengtsson),
  [\#7](https://github.com/r-lib/sessioninfo/issues/7)).

- [`session_info()`](https://sessioninfo.r-lib.org/dev/reference/session_info.md)
  and
  [`package_info()`](https://sessioninfo.r-lib.org/dev/reference/package_info.md)
  now only list loaded versions for namespaces which are already loaded.
  This only makes a difference if the `pkgs` argument is given
  ([\#4](https://github.com/r-lib/sessioninfo/issues/4)).

- Do not consult the `max.print` option, for platform and package info
  ([@jennybc](https://github.com/jennybc),
  [\#13](https://github.com/r-lib/sessioninfo/issues/13)).

## sessioninfo 1.0.0

CRAN release: 2017-06-21

First public release.
