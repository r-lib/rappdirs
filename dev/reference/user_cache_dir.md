# Path to user cache directory

This functions uses `R_USER_CACHE_DIR` if set. Otherwise, they follow
platform conventions. Typical user cache directories are:

- Mac OS X: `~/Library/Caches/<AppName>`

- Linux: `~/.cache/<AppName>`

- Win XP:
  `C:\\Documents and Settings\\<username>\\Local Settings\\Application Data\\<AppAuthor>\\<AppName>\\Cache`

- Vista:
  `C:\\Users\\<username>\\AppData\\Local\\<AppAuthor>\\<AppName>\\Cache`

## Usage

``` r
user_cache_dir(
  appname = NULL,
  appauthor = appname,
  version = NULL,
  opinion = TRUE,
  expand = TRUE,
  os = NULL
)
```

## Arguments

- appname:

  is the name of application. If NULL, just the system directory is
  returned.

- appauthor:

  (only required and used on Windows) is the name of the appauthor or
  distributing body for this application. Typically it is the owning
  company name. This falls back to appname.

- version:

  is an optional version path element to append to the path. You might
  want to use this if you want multiple versions of your app to be able
  to run independently. If used, this would typically be
  `"<major>.<minor>"`. Only applied when appname is not NULL.

- opinion:

  (logical) Use `FALSE` to disable the appending of `Cache` on Windows.
  See discussion below.

- expand:

  If TRUE (the default) will expand the `R_LIBS` specifiers with their
  equivalents. See [`R_LIBS()`](https://rdrr.io/r/base/libPaths.html)
  for list of all possibly specifiers.

- os:

  Operating system whose conventions are used to construct the requested
  directory. Possible values are "win", "mac", "unix". If `NULL` (the
  default) then the current OS will be used.

## Opinion

On Windows the only suggestion in the MSDN docs is that local settings
go in the `CSIDL_LOCAL_APPDATA` directory. This is identical to the
non-roaming app data dir (i.e.
[`user_data_dir()`](https://rappdirs.r-lib.org/dev/reference/user_data_dir.md)).
But apps typically put cache data somewhere *under* this directory so
`user_cache_dir()` appends `Cache` to the `CSIDL_LOCAL_APPDATA` value,
unless `opinion = FALSE`.

## See also

[`tempdir()`](https://rdrr.io/r/base/tempfile.html) for a non-persistent
temporary directory.

## Examples

``` r
user_cache_dir("rappdirs")
#> [1] "~/.cache/rappdirs"
```
