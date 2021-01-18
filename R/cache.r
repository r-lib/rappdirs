#' Return full path to the user-specific cache dir for this application.
#'
#' Typical user cache directories are:
#'
#' \itemize{
#'  \item Mac OS X: \file{~/Library/Caches/<AppName>}
#'  \item Unix: \file{~/.cache/<AppName>}, \env{$XDG_CACHE_HOME} if defined
#'  \item Win XP: \file{C:\\Documents and Settings\\<username>\\Local Settings\\Application Data\\<AppAuthor>\\<AppName>\\Cache}
#'  \item Vista:      \file{C:\\Users\\<username>\\AppData\\Local\\<AppAuthor>\\<AppName>\\Cache}
#' }
#'
#' On Windows the only suggestion in the MSDN docs is that local settings go
#' in the `CSIDL_LOCAL_APPDATA` directory. This is identical to the
#' non-roaming app data dir (the default returned by `user_data_dir` above).
#' Apps typically put cache data somewhere *under* the given dir here. Some
#' examples: \file{...\\Mozilla\\Firefox\\Profiles\\<ProfileName>\\Cache},
#' \file{...\\Acme\\SuperApp\\Cache\\1.0}
#'
#' @section Opinion:
#' This function appends \file{Cache} to the `CSIDL_LOCAL_APPDATA` value.
#' This can be disabled with `opinion = FALSE` option.
#'
#' @inheritParams user_data_dir
#' @param opinion (logical) can be `FALSE` to disable the appending of
#'   \file{Cache} to the base app data dir for Windows. See discussion below.
#' @seealso [tempdir()] for a non-persistent temporary directory.
#' @examples
#' user_cache_dir("rappdirs")
#' \dontrun{
#' # Throw this in your R profile to store a R history file in standard cache location
#' if(capabilities("cledit")) {
#'   cache_dir <- rappdirs::user_cache_dir("R")
#'   history_file <- file.path(cache_dir, "Rhistory")
#'   .First <- function() utils::loadhistory(history_file)
#'   .Last <- function() {
#'     if (!file.exists(cache_dir)) dir.create(cache_dir, recursive = TRUE)
#'     try(savehistory(history_file))
#'   }
#' }
#' }
#' @export
user_cache_dir <- function(appname = NULL, appauthor = appname, version = NULL,
                           opinion = TRUE, expand = TRUE, os = NULL) {
  if (expand) version <- expand_r_libs_specifiers(version)

  version <- check_version(version, appname)
  switch(check_os(os),
    win = file_path(win_path("local"), appauthor, appname, version,
      if (opinion) "Cache"),
    mac = file_path("~/Library/Caches", appname, version),
    unix = file_path(Sys.getenv("XDG_CACHE_HOME", "~/.cache"), appname, version)
  )
}
