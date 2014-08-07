[![Travis-CI build Status](https://travis-ci.org/hadley/rappdirs.svg)](https://travis-ci.org/hadley/rappdirs) [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/esqelnh58yryf21b/branch/master)](https://ci.appveyor.com/project/hadley/rappdirs/branch/master)

`rappdirs` is a port of [appdirs](https://github.com/ActiveState/appdirs) to R.

The problem
===========

What directory should your app use for storing user data? If running on
Mac OS X, you should use:

    ~/Library/Application Support/<AppName>

If on Windows (at least English Win XP) that should be:

    C:\Documents and Settings\<User>\Application Data\Local Settings\<AppAuthor>\<AppName>

or possibly:

    C:\Documents and Settings\<User>\Application Data\<AppAuthor>\<AppName>

for [roaming profiles][] but that is another story.

On Linux (and other Unices) the dir, according to the [XDG spec][] (and
subject to some interpretation), is either:

    ~/.config/<AppName>     

or possibly:

    ~/.local/share/<AppName>

`rappdirs` to the rescue
=======================

This kind of thing is what the `appdirs` module is for. `appdirs` will
help you choose an appropriate:

-   user data dir (`user_data_dir`)
-   user config dir (`user_config_dir`)
-   user cache dir (`user_cache_dir`)
-   site data dir (`site_data_dir`)
-   user log dir (`user_log_dir`)

and also:

-   is slightly opinionated on the directory names used. Look for
    'Opinion' in documentation and code for when an opinion is being
    applied.

some example output
===================

On Mac OS X:

    library(appdirs)
    appname <- "SuperApp"
    appauthor <- "Acme"
    user_config_dir(appname, appauthor)
    # "/Users/trentm/Library/Application Support/SuperApp"
    user_data_dir(appname, appauthor)
    # "/Users/trentm/Library/Application Support/SuperApp"
    site_data_dir(appname, appauthor)
    # "/Library/Application Support/SuperApp"
    user_cache_dir(appname, appauthor)
    "/Users/trentm/Library/Caches/SuperApp"
    user_log_dir(appname, appauthor)
    "/Users/trentm/Library/Logs/SuperApp"

On Windows 7:

    library(appdirs)
    appname <- "SuperApp"
    appauthor <- "Acme"
    user_config_dir(appname, appauthor)
    # "C:\\Users\\trentm\\AppData\\Local\\Acme\\SuperApp"
    user_data_dir(appname, appauthor)
    # "C:\\Users\\trentm\\AppData\\Local\\Acme\\SuperApp"
    user_data_dir(appname, appauthor, roaming=True)
    # "C:\\Users\\trentm\\AppData\\Roaming\\Acme\\SuperApp"
    user_cache_dir(appname, appauthor)
    # "C:\\Users\\trentm\\AppData\\Local\\Acme\\SuperApp\\Cache"
    user_log_dir(appname, appauthor)
    # "C:\\Users\\trentm\\AppData\\Local\\Acme\\SuperApp\\Logs"

On Linux:

    library(appdirs)
    appname <- "SuperApp"
    appauthor <- "Acme"
    user_config_dir(appname, appauthor)
    # "/home/trentm/.config/SuperApp
    user_data_dir(appname, appauthor)
    # "/home/trentm/.local/share/SuperApp
    site_config_dir(appname, appauthor)
    # "/etc/xdg/SuperApp"
    user_cache_dir(appname, appauthor)
    # "/home/trentm/.cache/SuperApp"
    user_log_dir(appname, appauthor)
    # "/home/trentm/.cache/SuperApp/log"

`app_dir` for convenience
=========================

    library(appdirs)
    dirs <- app_dir("SuperApp", "Acme")
    dirs$config()
    # "/Users/trentm/Library/Application Support/SuperApp"
    dirs$data()
    # "/Users/trentm/Library/Application Support/SuperApp"
    dirs$site_data()
    # "/Library/Application Support/SuperApp"
    dirs$cache()
    # "/Users/trentm/Library/Caches/SuperApp"
    dirs$log()
    # "/Users/trentm/Library/Logs/SuperApp"

Per-version isolation
=====================

If you have multiple versions of your app in use that you want to be
able to run side-by-side, then you may want version-isolation for these
dirs:

    library(appdirs)
    dirs <- app_dir("SuperApp", "Acme", version = "1.0")
    dirs$data()
    # "/Users/trentm/Library/Application Support/SuperApp/1.0"
    dirs$site_data()
    # "/Library/Application Support/SuperApp/1.0"
    dirs$cache()
    # "/Users/trentm/Library/Caches/SuperApp/1.0"
    dirs$log()
    # "/Users/trentm/Library/Logs/SuperApp/1.0"

If you set the argument expand = TRUE (the default) you can have directories that correspond to R versions:

    user_config_dir("R", version="%p-platform/%v")
    # "/home/trevorld/.config/R/x86_64-pc-linux-gnu-platform/3.0"

  [roaming profiles]: http://bit.ly/9yl3b6
  [XDG spec]: http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
