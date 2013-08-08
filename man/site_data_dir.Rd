\name{site_data_dir}
\alias{site_config_dir}
\alias{site_data_dir}
\title{Return full path to the user-shared data dir for this application.}
\usage{
  site_data_dir(appname = NULL, appauthor = NULL,
    version = NULL, multipath = FALSE, expand = TRUE,
    os = NULL)

  site_config_dir(appname = NULL, appauthor = NULL,
    version = NULL, multipath = FALSE, expand = TRUE,
    os = NULL)
}
\arguments{
  \item{multipath}{is an optional parameter only applicable
  to *nix which indicates that the entire list of data dirs
  should be returned By default, the first directory is
  returned}

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
  Typical user data directories are:
}
\details{
  \itemize{ \item Mac OS X: \file{/Library/Application
  Support/<AppName>} \item Unix: \file{/etc/xdg/<appname>}
  \item Win XP: \file{C:\\Documents and Settings\\All
  Users\\Application Data\\<AppAuthor>\\<AppName>} \item
  Vista: (Fail! \file{C:\\ProgramData} is a hidden
  \emph{system} directory on Vista.) \item Win 7:
  \file{C:\\ProgramData\\<AppAuthor>\\<AppName>}.  Hidden,
  but writeable on Win 7. }

  For Unix, this is using the \env{$XDG_CONFIG_DIRS[0]}
  default.
}
\section{Warning}{
  Do not use this on Windows. See the note above for why.
}

