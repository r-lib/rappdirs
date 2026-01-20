# Path to user log directory

Typical user cache directories are:

## Usage

``` r
user_log_dir(
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

  (logical) can be `FALSE` to disable the appending of `Logs` to the
  base app data dir for Windows, and `log` to the base cache dir for
  Unix. See discussion below.

- expand:

  If TRUE (the default) will expand the `R_LIBS` specifiers with their
  equivalents. See [`R_LIBS()`](https://rdrr.io/r/base/libPaths.html)
  for list of all possibly specifiers.

- os:

  Operating system whose conventions are used to construct the requested
  directory. Possible values are "win", "mac", "unix". If `NULL` (the
  default) then the current OS will be used.

## Details

- Mac OS X: `~/Library/Logs/<AppName>`

- Unix: `~/.cache/<AppName>/log`, or under `$XDG_CACHE_HOME` if defined

- Win XP:
  `C:\Documents and Settings\<username>\Local Settings\Application Data\<AppAuthor>\<AppName>\Logs`

- Vista: `C:\Users\<username>\AppData\Local\<AppAuthor>\<AppName>\Logs`

On Windows the only suggestion in the MSDN docs is that local settings
go in the `CSIDL_LOCAL_APPDATA` directory.

## Opinion

This function appends `Logs` to the `CSIDL_LOCAL_APPDATA` value for
Windows and appends `log` to the user cache dir for Unix. This can be
disabled with the `opinion = FALSE` option.

## Examples

``` r
user_log_dir()
#> [1] "~/.cache/log"
```
