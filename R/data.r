#' Return path to user data directories.
#'
#' `user_data_dir` returns full path to the user-specific data dir for this application.
#' `user_config_dir` returns full path to the user-specific configuration directory for this application
#' which returns the same path as user data directory in Windows and Mac but a different one for Unix.
#'
#' Typical user data directories are:
#'
#' * Mac OS X:  `~/Library/Application Support/<AppName>`
#' * Unix: `~/.local/share/<AppName>`, in \env{$XDG_DATA_HOME} if defined
#' * Win XP (not roaming):  `C:\\Documents and Settings\\<username>\\Data\\<AppAuthor>\\<AppName>`
#' * Win XP (roaming): `C:\\Documents and Settings\\<username>\\Local Settings\\Data\\<AppAuthor>\\<AppName>`
#' * Win 7 (not roaming): `C:\\Users\\<username>\\AppData\\Local\\<AppAuthor>\\<AppName>`
#' * Win 7 (roaming): `C:\\Users\\<username>\\AppData\\Roaming\\<AppAuthor>\\<AppName>`
#'
#' Unix also specifies a separate location for user configuration data in
#'
#' * Unix: `~/.config/<AppName>`, in \env{$XDG_CONFIG_HOME} if defined
#'
#' See for example <http://ploum.net/184-cleaning-user-preferences-keeping-user-data/>
#' or <https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html> for more information.
#' Arguably plugins such as R packages should go into the user configuration directory and deleting
#' this directory should return the application to a default settings.
#'
#' The `os` parameter allows the calculation of directories based on a
#' convention other than the current operating system. This feature is designed
#' with package testing in mind and is *not* recommended for end users. One
#' possible exception is that some users on "mac" might wish to use the "unix"
#' XDG convention.
#'
#' @param appname is the name of application. If NULL, just the system
#'     directory is returned.
#' @param appauthor (only required and used on Windows) is the name of the
#'     appauthor or distributing body for this application. Typically
#'     it is the owning company name. This falls back to appname.
#' @param version is an optional version path element to append to the
#'     path. You might want to use this if you want multiple versions
#'     of your app to be able to run independently. If used, this
#'     would typically be `"<major>.<minor>"`. Only applied when appname
#'     is not NULL.
#' @param roaming (logical, default `FALSE`) can be set `TRUE` to
#'     use the Windows roaming appdata directory. That means that for users on
#'     a Windows network setup for roaming profiles, this user data will be
#'     sync'd on login. See
#'     <https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-vista/cc766489(v=ws.10)>
#'     for a discussion of issues.
#' @param os Operating system whose conventions are used to construct the
#'     requested directory. Possible values are "win", "mac", "unix". If NULL
#'     (the default) then the convention of the current operating system
#'     (as determined by rappdirs:::get_os) will be used. This argument is
#'     unlikely to find much use outside package testing (see details section of
#'     [user_data_dir()]).
#' @param expand If TRUE (the default) will expand the `R_LIBS` specifiers with their equivalents.
#'      See [R_LIBS()] for list of all possibly specifiers.
#'
#' @examples
#' user_data_dir("rappdirs")
#' user_config_dir("rappdirs", version="%p-platform/%v")
#' user_config_dir("rappdirs", roaming=TRUE, os="win")
#' user_config_dir("rappdirs", roaming=FALSE, os="win")
#' user_config_dir("rappdirs", os="unix")
#' user_config_dir("rappdirs", os="mac")
#' \dontrun{
#' # you could try to use functions to store R libraries in a standard user directory
#' # by using the following in your .Rprofile file
#' # but unfortunately if rappsdir package was stored in standard user directory then
#' # it won't be on R's search path any longer, so would need to be installed system-wide...
#' require("utils")
#' .libPaths(new=rappdirs::user_config_dir("R", version="%p-platform/%v"))
#' }

#' @export
user_data_dir <- function(appname = NULL, appauthor = appname, version = NULL,
                          roaming = FALSE, expand = TRUE, os = get_os()) {
  if (expand) version <- expand_r_libs_specifiers(version)
  version <- check_version(version, appname)

  switch(os,
    win = file_path(win_path(ifelse(roaming, "roaming", "local")), appauthor, appname, version),
    mac = file_path("~/Library/Application Support", appname, version),
    unix = file_path(Sys.getenv("XDG_DATA_HOME", "~/.local/share"),
      appname, version)
  )
}

#' @rdname user_data_dir
#' @export
user_config_dir <- function(appname = NULL, appauthor = appname, version = NULL,
                            roaming = TRUE, expand = TRUE, os = get_os()) {
  if (expand) version <- expand_r_libs_specifiers(version)
  version <- check_version(version, appname)

  switch(os,
    win = file_path(win_path(ifelse(roaming, "roaming", "local")), appauthor, appname, version),
    mac = file_path("~/Library/Application Support", appname, version),
    unix = file_path(Sys.getenv("XDG_CONFIG_HOME", "~/.config"),
      appname, version)
  )
}


#' Return full path to the user-shared data dir for this application.
#'
#' `site_data_dir` returns full path to the user-shared data dir for this application.
#' `site_config_dir` returns full path to the user-specific configuration directory for this application
#' which returns the same path as site data directory in Windows and Mac but a different one for Unix.
#' Typical user-shared data directories are:
#'
#' * Mac OS X:  `/Library/Application Support/<AppName>`
#' * Unix:      `/usr/local/share:/usr/share/`
#' * Win XP:    `C:\\Documents and Settings\\All Users\\Application Data\\<AppAuthor>\\<AppName>`
#' * Vista:     (Fail! `C:\\ProgramData` is a hidden *system* directory on Vista.)
#' * Win 7:     `C:\\ProgramData\\<AppAuthor>\\<AppName>`. Hidden, but writeable on Win 7.
#'
#' Unix also specifies a separate location for user-shared configuration data in \env{$XDG_CONFIG_DIRS}.
#'
#' * Unix: `/etc/xdg/<AppName>`, in \env{$XDG_CONFIG_HOME} if defined
#'
#' For Unix, this returns the first default.  Set the `multipath=TRUE` to guarantee returning all directories.
#'
#' @inheritParams user_data_dir
#' @param multipath is an optional parameter only applicable to *nix
#'       which indicates that the entire list of data dirs should be returned
#'       By default, the first directory is returned
#' @section Warning:
#' Do not use this on Windows. See the note above for why.
#' @export
site_data_dir <- function(appname = NULL, appauthor = appname, version = NULL,
                          multipath = FALSE, expand = TRUE, os = get_os()) {
  if (expand) version <- expand_r_libs_specifiers(version)
  version <- check_version(version, appname)

  switch(os,
    win = file_path(win_path("common"), appauthor, appname, version),
    mac = file_path("/Library/Application Support", appname, version),
    unix = file_path_site_unix(Sys.getenv("XDG_DATA_DIRS", "/usr/local/share:/usr/share"),
                               appname, version, multipath)
    )
}

#' @rdname site_data_dir
#' @export
site_config_dir <- function(appname = NULL, appauthor = appname, version = NULL,
                            multipath = FALSE, expand = TRUE, os = get_os()) {
  if (expand) version <- expand_r_libs_specifiers(version)
  version <- check_version(version, appname)

  switch(os,
    win = file_path(win_path("common"), appauthor, appname, version),
    mac = file_path("/Library/Application Support", appname, version),
    unix = file_path_site_unix(Sys.getenv("XDG_CONFIG_DIRS", "/etc/xdg"),
                               appname, version, multipath)
  )
}

# wrapper with `multipath` and use `parse_path_string` for cleaner switch statement
file_path_site_unix <- function(sys_getenv, appname, version, multipath = FALSE) {
  paths <- parse_path_string(sys_getenv)
  if (multipath) {
    file_path_vec(paths, appname, version)
  } else {
    file_path(paths[1], appname, version)
  }
}
