#' Return full path to the user-specific log dir for this application.
#' 
#' Typical user cache directories are:
#'
#' \itemize{
#'   \item Mac OS X: \file{~/Library/Logs/<AppName>}
#'   \item Unix: \file{~/.cache/<appname>/log}, or under 
#'     \\env{$XDG_CACHE_HOME} if defined
#'   \item Win XP:  \file{C:\\Documents and Settings\\<username>\\Local Settings\\Application Data\\<AppAuthor>\\<AppName>\\Logs}
#'   \item Vista: 
#'     \file{C:\\Users\\<username>\\AppData\\Local\\<AppAuthor>\\<AppName>\\Logs}
#' }
#' 
#' On Windows the only suggestion in the MSDN docs is that local settings
#' go in the \code{CSIDL_LOCAL_APPDATA} directory. (Note: I'm interested in
#' examples of what some windows apps use for a logs dir.)
#' 
#' @section Opinion:
#' This function appends \file{Logs} to the `CSIDL_LOCAL_APPDATA`
#' value for Windows and appends \file{log} to the user cache dir for Unix.
#' This can be disabled with the \code{opinion = FALSE} option.
#' 
#' @inheritParams user_data_dir
#' @param opinion (logical) can be \code{FALSE} to disable the appending of
#'   \file{Logs} to the base app data dir for Windows, and \file{log} to the
#'   base cache dir for Unix. See discussion below.
#' @export
user_log_dir <- function(appname = NULL, appauthor = NULL, version = NULL, opinion = TRUE, expand = TRUE, os = NULL) {
  if(is.null(os)) { os <- get_os() }
  if(!is.null(version) && expand) { version <- expand_r_libs_specifiers(version) }
  if(is.null(appauthor)) { appauthor <- appname }
  switch(os, 
    win = file_path(win_path("local"), appauthor, appname, version, 
      if (opinion) "Logs"),
    mac = file_path("~/Library/Logs", appname, version),
    unix = file_path(Sys.getenv("XDG_CACHE_HOME", "~/.cache"),
      appname, version, if (opinion) "log")
  )
}
