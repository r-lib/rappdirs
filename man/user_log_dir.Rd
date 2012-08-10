\name{user_log_dir}
\alias{user_log_dir}
\title{Return full path to the user-specific log dir for this application.}
\usage{
  user_log_dir(appname, appauthor, version = NULL,
    opinion = TRUE)
}
\arguments{
  \item{opinion}{(logical) can be \code{FALSE} to disable
  the appending of \file{Logs} to the base app data dir for
  Windows, and \file{log} to the base cache dir for Unix.
  See discussion below.}

  \item{appname}{is the name of application.}

  \item{appauthor}{(only required and used on Windows) is
  the name of the appauthor or distributing body for this
  application. Typically it is the owning company name.}

  \item{version}{is an optional version path element to
  append to the path. You might want to use this if you
  want multiple versions of your app to be able to run
  independently. If used, this would typically be
  "<major>.<minor>".}
}
\description{
  Typical user cache directories are:
}
\details{
  \itemize{ \item Mac OS X: \file{~/Library/Logs/<AppName>}
  \item Unix: \file{~/.cache/<appname>/log}, or under
  \\env{$XDG_CACHE_HOME} if defined \item Win XP:
  \file{C:\\Documents and Settings\\<username>\\Local
  Settings\\Application Data\\<AppAuthor>\\<AppName>\\Logs}
  \item Vista:
  \file{C:\\Users\\<username>\\AppData\\Local\\<AppAuthor>\\<AppName>\\Logs}
  }

  On Windows the only suggestion in the MSDN docs is that
  local settings go in the \code{CSIDL_LOCAL_APPDATA}
  directory. (Note: I'm interested in examples of what some
  windows apps use for a logs dir.)
}
\section{Opinion}{
  This function appends \file{Logs} to the
  `CSIDL_LOCAL_APPDATA` value for Windows and appends
  \file{log} to the user cache dir for Unix. This can be
  disabled with the \code{opinion = FALSE} option.
}

