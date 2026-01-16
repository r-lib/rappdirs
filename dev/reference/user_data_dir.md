# Path to user config/data directories

`user_data_dir()` returns path to the user-specific data directory and
`user_config_dir()` returns full path to the user-specific configuration
directory. These are the same on Windows and Mac but different on Linux.

These functions first use `R_USER_DATA_DIR` and `R_USER_CONFIG_DIR` if
set. Otherwise, they follow platform conventions. Typical user config
and data directories are:

- Mac OS X: `~/Library/Application Support/<AppName>`

- Win XP (not roaming):
  `C:\\Documents and Settings\\<username>\\Data\\<AppAuthor>\\<AppName>`

- Win XP (roaming):
  `C:\\Documents and Settings\\<username>\\Local Settings\\Data\\<AppAuthor>\\<AppName>`

- Win 7 (not roaming):
  `C:\\Users\\<username>\\AppData\\Local\\<AppAuthor>\\<AppName>`

- Win 7 (roaming):
  `C:\\Users\\<username>\\AppData\\Roaming\\<AppAuthor>\\<AppName>`

Only Linux makes the distinction between config and data:

- Data: `~/.local/share/<AppName>`

- Config: `~/.config/<AppName>`

## Usage

``` r
user_data_dir(
  appname = NULL,
  appauthor = appname,
  version = NULL,
  roaming = FALSE,
  expand = TRUE,
  os = NULL
)

user_config_dir(
  appname = NULL,
  appauthor = appname,
  version = NULL,
  roaming = TRUE,
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

- roaming:

  (logical, default `FALSE`) can be set `TRUE` to use the Windows
  roaming appdata directory. That means that for users on a Windows
  network setup for roaming profiles, this user data will be sync'd on
  login. See
  \<https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-vista/cc766489(v=ws.10).
  for a discussion of issues.

- expand:

  If TRUE (the default) will expand the `R_LIBS` specifiers with their
  equivalents. See [`R_LIBS()`](https://rdrr.io/r/base/libPaths.html)
  for list of all possibly specifiers.

- os:

  Operating system whose conventions are used to construct the requested
  directory. Possible values are "win", "mac", "unix". If `NULL` (the
  default) then the current OS will be used.

## Examples

``` r
user_data_dir("rappdirs")
#> [1] "~/.local/share/rappdirs"

user_config_dir("rappdirs", roaming = TRUE, os = "win")
#> [1] "<APPDATA>/rappdirs/rappdirs"
user_config_dir("rappdirs", roaming = FALSE, os = "win")
#> [1] "<USERPROFILE>/Local Settings/Application Data/rappdirs/rappdirs"
user_config_dir("rappdirs", os = "unix")
#> [1] "/home/runner/.config/rappdirs"
user_config_dir("rappdirs", os = "mac")
#> [1] "~/Library/Application Support/rappdirs"
user_config_dir("rappdirs", version = "%p-platform/%v")
#> [1] "/home/runner/.config/rappdirs/x86_64-pc-linux-gnu-platform/4.5"
```
