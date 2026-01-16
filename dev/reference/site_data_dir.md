# Path to shared data/config directories

`site_data_dir` returns full path to the user-shared data dir for this
application. `site_config_dir` returns full path to the user-specific
configuration directory for this application which returns the same path
as site data directory in Windows and Mac but a different one for Unix.
Typical user-shared data directories are:

## Usage

``` r
site_data_dir(
  appname = NULL,
  appauthor = appname,
  version = NULL,
  multipath = FALSE,
  expand = TRUE,
  os = NULL
)

site_config_dir(
  appname = NULL,
  appauthor = appname,
  version = NULL,
  multipath = FALSE,
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

- multipath:

  is an optional parameter only applicable to \*nix which indicates that
  the entire list of data dirs should be returned By default, the first
  directory is returned

- expand:

  If TRUE (the default) will expand the `R_LIBS` specifiers with their
  equivalents. See [`R_LIBS()`](https://rdrr.io/r/base/libPaths.html)
  for list of all possibly specifiers.

- os:

  Operating system whose conventions are used to construct the requested
  directory. Possible values are "win", "mac", "unix". If `NULL` (the
  default) then the current OS will be used.

## Details

- Mac OS X: `/Library/Application Support/<AppName>`

- Unix: `/usr/local/share:/usr/share/`

- Win XP:
  `C:\\Documents and Settings\\All Users\\Application Data\\<AppAuthor>\\<AppName>`

- Vista: (Fail! `C:\\ProgramData` is a hidden *system* directory on
  Vista.)

- Win 7: `C:\\ProgramData\\<AppAuthor>\\<AppName>`. Hidden, but
  writeable on Win 7.

Unix also specifies a separate location for user-shared configuration
data in `$XDG_CONFIG_DIRS`.

- Unix: `/etc/xdg/<AppName>`, in `$XDG_CONFIG_HOME` if defined

For Unix, this returns the first default. Set the `multipath=TRUE` to
guarantee returning all directories.

## Warning

Do not use this on Windows. See the note above for why.
