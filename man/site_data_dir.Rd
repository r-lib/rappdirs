\name{site_data_dir}
\alias{site_config_dir}
\alias{site_data_dir}
\title{Return full path to the user-shared data dir for this application.}
\usage{
  site_data_dir(appname = NULL, appauthor = appname,
    version = NULL, multipath = FALSE, expand = TRUE,
    os = get_os())

  site_config_dir(appname = NULL, appauthor = appname,
    version = NULL, multipath = FALSE, expand = TRUE,
    os = get_os())
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
  \code{site_data_dir} returns full path to the user-shared
  data dir for this application. \code{site_config_dir}
  returns full path to the user-specific configuration
  directory for this application which returns the same
  path as site data directory in Windows and Mac but a
  different one for Unix. Typical user-shared data
  directories are:
}
\details{
  \itemize{ \item Mac OS X: \file{/Library/Application
  Support/<AppName>} \item Unix:
  \file{/usr/local/share:/usr/share/} \item Win XP:
  \file{C:\\Documents and Settings\\All Users\\Application
  Data\\<AppAuthor>\\<AppName>} \item Vista: (Fail!
  \file{C:\\ProgramData} is a hidden \emph{system}
  directory on Vista.) \item Win 7:
  \file{C:\\ProgramData\\<AppAuthor>\\<AppName>}.  Hidden,
  but writeable on Win 7. } Unix also specifies a separate
  location for user-shared configuration data in
  \env{$XDG_CONFIG_DIRS}. \itemize{ \item Unix:
  \file{/etc/xdg/<appname>}, in \env{$XDG_CONFIG_HOME} if
  defined }

  For Unix, this returns the first default.  Set the
  \code{multipath=TRUE} to guarantee returning all
  directories.
}
\section{Warning}{
  Do not use this on Windows. See the note above for why.
}

