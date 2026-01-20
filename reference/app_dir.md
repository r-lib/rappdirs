# Record app information in a convenient object

Has methods:

- `$cache()`

- `$log()`

- `$data()`

- `$config()`

- `$site_data()`

- `$site_config()`

## Usage

``` r
app_dir(
  appname = NULL,
  appauthor = appname,
  version = NULL,
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
ggplot2_app <- app_dir("ggplot2", "hadley")
ggplot2_app$cache()
#> [1] "~/.cache/ggplot2"
ggplot2_app$log()
#> [1] "~/.cache/ggplot2/log"
ggplot2_app$data()
#> [1] "~/.local/share/ggplot2"
ggplot2_app$config()
#> [1] "/home/runner/.config/ggplot2"
ggplot2_app$site_config()
#> [1] "/etc/xdg/ggplot2"
ggplot2_app$site_data()
#> [1] "/usr/local/share/ggplot2"
```
