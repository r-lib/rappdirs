#' Return path to user data directories.
#' 
#' \code{user_data_dir} returns full path to the user-specific data dir for this application.
#' \code{user_config_dir} returns full path to the user-specific configuration directory for this application 
#' which returns the same path as user data directory in Windows and Mac but a different one for Unix.
#' 
#' Typical user data directories are:
#'
#' \itemize{
#'   \item Mac OS X:  \file{~/Library/Application Support/<AppName>}
#'   \item Unix: \file{~/.local/share/<AppName>}, in \env{$XDG_DATA_HOME} if defined
#'   \item Win XP (not roaming):  \file{C:\\Documents and Settings\\<username>\\Data\\<AppAuthor>\\<AppName>}
#'   \item Win XP (roaming): \file{C:\\Documents and Settings\\<username>\\Local Settings\\Data\\<AppAuthor>\\<AppName>}
#'   \item Win 7  (not roaming): 
#'     \file{C:\\Users\\<username>\\AppData\\Local\\<AppAuthor>\\<AppName>}
#'   \item Win 7 (roaming):      
#'     \file{C:\\Users\\<username>\\AppData\\Roaming\\<AppAuthor>\\<AppName>}
#' }
#' Unix also specifies a separate location for user configuration data in
#' \itemize{ 
#'   \item Unix: \file{~/.config/<AppName>}, in \env{$XDG_CONFIG_HOME} if defined
#'  }
#' See for example \url{http://ploum.net/184-cleaning-user-preferences-keeping-user-data/} 
#' or \url{http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html} for more information.
#' Arguably plugins such as R packages should go into the user configuration directory and deleting
#' this directory should return the application to a default settings.
#'
#' @param appname is the name of application. If NULL, just the system
#'     directory is returned.
#' @param appauthor (only required and used on Windows) is the name of the
#'     appauthor or distributing body for this application. Typically
#'     it is the owning company name. This falls back to appname.
#' @param version is an optional version path element to append to the
#'     path. You might want to use this if you want multiple versions
#'     of your app to be able to run independently. If used, this
#'     would typically be "<major>.<minor>". Only applied when appname
#'     is not NULL.
#' @param roaming (logical, default \code{FALSE}) can be set \code{TRUE} to
#'     use the Windows roaming appdata directory. That means that for users on
#'     a Windows network setup for roaming profiles, this user data will be
#'     sync'd on login. See
#'     \url{http://technet.microsoft.com/en-us/library/cc766489(WS.10).aspx}
#'     for a discussion of issues.
#' @param os Operating system which we should create directory for, 
#'     if NULL (the default) will compute the operating system using R's built in variables/functions.  
#'     Values are "win", "mac", "unix".
#' @param expand If TRUE (the default) will expand the \code{R_LIBS} specifiers with their equivalents.  
#'      See \code{\link{R_LIBS}} for list of all possibly specifiers.
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
  if (is.null(appname) && !is.null(version)) {
    version <- NULL
    warning("version is ignored when appname is null")
  }
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
  if (is.null(appname) && !is.null(version)) {
    version <- NULL
    warning("version is ignored when appname is null")
  }
  switch(os, 
    win = file_path(win_path(ifelse(roaming, "roaming", "local")), appauthor, appname, version),
    mac = file_path("~/Library/Application Support", appname, version),
    unix = file_path(Sys.getenv("XDG_CONFIG_HOME", "~/.config"), 
      appname, version)
  )
}


#' Return full path to the user-shared data dir for this application.
#' 
#' \code{site_data_dir} returns full path to the user-shared data dir for this application.
#' \code{site_config_dir} returns full path to the user-specific configuration directory for this application 
#' which returns the same path as site data directory in Windows and Mac but a different one for Unix.
#' Typical user-shared data directories are:
#' 
#' \itemize{
#' \item Mac OS X:   \file{/Library/Application Support/<AppName>}
#' \item Unix:       \file{/usr/local/share:/usr/share/}
#' \item Win XP:     \file{C:\\Documents and Settings\\All Users\\Application Data\\<AppAuthor>\\<AppName>}
#' \item Vista:      (Fail! \file{C:\\ProgramData} is a hidden \emph{system}
#'    directory on Vista.)
#' \item Win 7:      \file{C:\\ProgramData\\<AppAuthor>\\<AppName>}.  
#'    Hidden, but writeable on Win 7.
#' }
#' Unix also specifies a separate location for user-shared configuration data in \env{$XDG_CONFIG_DIRS}.
#' \itemize{ 
#'   \item Unix: \file{/etc/xdg/<AppName>}, in \env{$XDG_CONFIG_HOME} if defined
#'  }
#' 
#' For Unix, this returns the first default.  Set the \code{multipath=TRUE} to guarantee returning all directories.
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
  if (is.null(appname) && !is.null(version)) {
    version <- NULL
    warning("version is ignored when appname is null")
  }
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
  if (is.null(appname) && !is.null(version)) {
    version <- NULL
    warning("version is ignored when appname is null")
  }
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
