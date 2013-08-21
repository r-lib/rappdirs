\name{user_data_dir}
\alias{user_config_dir}
\alias{user_data_dir}
\title{Return path to user data directories.}
\usage{
  user_data_dir(appname = NULL, appauthor = NULL,
    version = NULL, roaming = FALSE, expand = TRUE,
    os = NULL)

  user_config_dir(appname = NULL, appauthor = NULL,
    version = NULL, roaming = TRUE, expand = TRUE,
    os = NULL)
}
\arguments{
  \item{appname}{is the name of application.}

  \item{appauthor}{(only required and used on Windows) is
  the name of the appauthor or distributing body for this
  application. Typically it is the owning company name.}

  \item{version}{is an optional version path element to
  append to the path. You might want to use this if you
  want multiple versions of your app to be able to run
  independently. If used, this would typically be
  "<major>.<minor>".}

  \item{roaming}{(logical, default \code{FALSE}) can be set
  \code{TRUE} to use the Windows roaming appdata directory.
  That means that for users on a Windows network setup for
  roaming profiles, this user data will be sync'd on login.
  See
  \url{http://technet.microsoft.com/en-us/library/cc766489(WS.10).aspx}
  for a discussion of issues.}

  \item{os}{Operating system which we should create
  directory for, if NULL (the default) will compute the
  operating system using R's built in variables/functions.
  Values are "win", "mac", "unix".}

  \item{expand}{If TRUE (the default) will expand the
  \code{R_LIBS} specifiers with their equivalents.  See
  \code{\link{R_LIBS}} for list of all possibly
  specifiers.}
}
\description{
  \code{user_data_dir} returns full path to the
  user-specific data dir for this application.
  \code{user_config_dir} returns full path to the
  user-specific configuration directory for this
  application which returns the same path as user data
  directory in Windows and Mac but a different one for
  Unix.
}
\details{
  Typical user data directories are:

  \itemize{ \item Mac OS X: \file{~/Library/Application
  Support/<AppName>} \item Unix:
  \file{~/.local/share/<appname>}, in \env{$XDG_DATA_HOME}
  if defined \item Win XP (not roaming):
  \file{C:\\Documents and
  Settings\\<username>\\Data\\<AppAuthor>\\<AppName>} \item
  Win XP (roaming): \file{C:\\Documents and
  Settings\\<username>\\Local
  Settings\\Data\\<AppAuthor>\\<AppName>} \item Win 7 (not
  roaming):
  \file{C:\\Users\\<username>\\AppData\\Local\\<AppAuthor>\\<AppName>}
  \item Win 7 (roaming):
  \file{C:\\Users\\<username>\\AppData\\Roaming\\<AppAuthor>\\<AppName>}
  } Unix also specifies a separate location for user
  configuration data in \itemize{ \item Unix:
  \file{~/.config/<appname>}, in \env{$XDG_CONFIG_HOME} if
  defined } See for example
  \url{http://ploum.net/184-cleaning-user-preferences-keeping-user-data/}
  or
  \url{http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html}
  for more information. Arguably plugins such as R packages
  should go into the user configuration directory and
  deleting this directory should return the application to
  a default settings.
}

