# Changelog

## rappdirs (development version)

- Upkeep

## rappdirs 0.3.3

CRAN release: 2021-01-31

- rappdirs functions are no longer vectorised; this was an accidental
  change in 0.3.2 ([\#32](https://github.com/r-lib/rappdirs/issues/32)).

## rappdirs 0.3.2

CRAN release: 2021-01-27

- [`user_data_dir()`](https://rappdirs.r-lib.org/dev/reference/user_data_dir.md),
  `use_cache_dir()` and `use_config_dir()` now respect
  `R_USER_DATA_DIR`, `R_USER_CACHE_DIR` and `R_USER_CONFIG_DIR` env vars
  ([\#27](https://github.com/r-lib/rappdirs/issues/27)).

- No longer uses methods package.

## rappdirs 0.3.1

CRAN release: 2016-03-28

Minor R CMD check and test fixes.

## rappdirs 0.3.0

- first CRAN release
- `xxx_dir()` functions only use version when appname is not null
- docs: basic package docs (?rappdirs)
- docs: clarify primary purpose of os argument in `xxx_dir()`
  i.e. testing
- fix typo in function name in README.md (app_dirs -\> app_dir)
- dev: add travis continuous integration
- dev: add rstudio project
- dev: update to roxygen2 v4.0.1
