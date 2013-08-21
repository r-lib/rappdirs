\name{user_cache_dir}
\alias{user_cache_dir}
\title{Return full path to the user-specific cache dir for this application.}
\usage{
  user_cache_dir(appname = NULL, appauthor = NULL,
    version = NULL, opinion = TRUE, expand = TRUE,
    os = NULL)
}
\arguments{
  \item{opinion}{(logical) can be \code{FALSE} to disable
  the appending of \file{Cache} to the base app data dir
  for Windows. See discussion below.}

  \item{appname}{is the name of application.}

  \item{appauthor}{(only required and used on Windows) is
  the name of the appauthor or distributing body for this
  application. Typically it is the owning company name.}

  \item{version}{is an optional version path element to
  append to the path. You might want to use this if you
  want multiple versions of your app to be able to run
  independently. If used, this would typically be
  "<major>.<minor>".}

  \item{expand}{If TRUE (the default) will expand the
  \code{R_LIBS} specifiers with their equivalents.  See
  \code{\link{R_LIBS}} for list of all possibly
  specifiers.}

  \item{os}{Operating system which we should create
  directory for, if NULL (the default) will compute the
  operating system using R's built in variables/functions.
  Values are "win", "mac", "unix".}
}
\description{
  Typical user cache directories are:
}
\details{
  \itemize{ \item Mac OS X:
  \file{~/Library/Caches/<AppName>} \item Unix:
  \file{~/.cache/<appname>}, \env{$XDG_CACHE_HOME} if
  defined \item Win XP: \file{C:\\Documents and
  Settings\\<username>\\Local Settings\\Application
  Data\\<AppAuthor>\\<AppName>\\Cache} \item Vista:
  \file{C:\\Users\\<username>\\AppData\\Local\\<AppAuthor>\\<AppName>\\Cache}
  }

  On Windows the only suggestion in the MSDN docs is that
  local settings go in the `CSIDL_LOCAL_APPDATA` directory.
  This is identical to the non-roaming app data dir (the
  default returned by `user_data_dir` above). Apps
  typically put cache data somewhere *under* the given dir
  here. Some examples:
  \file{...\\Mozilla\\Firefox\\Profiles\\<ProfileName>\\Cache},
  \file{...\\Acme\\SuperApp\\Cache\\1.0}
}
\section{Opinion}{
  This function appends \file{Cache} to the
  `CSIDL_LOCAL_APPDATA` value. This can be disabled with
  \code{opinion = FALSE} option.
}
\examples{
user_cache_dir("rappdirs")
\dontrun{
# Throw this in your R profile to store a R history file in standard cache location
history_file <- file.path(rappdirs::user_cache_dir("R"), "Rhistory")
.First <- function() {
   if(!any(commandArgs()=='--no-readline') && interactive()) {
     require("utils")
     loadhistory(history_file)
     }
 }
.Last <- function() {
   if(!any(commandArgs()=='--no-readline') && interactive()) {
     require("utils")
     try(savehistory(history_file))
   }
 }
}
}
\seealso{
  \code{\link{tempdir}} for a non-persistent temporary
  directory.
}
