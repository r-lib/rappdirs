\name{user_data_dir}
\alias{user_data_dir}
\title{Return full path to the user-specific data dir for this application.}
\usage{
  user_data_dir(appname, appauthor, version = NULL,
    roaming = FALSE)
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
}
\description{
  Typical user data directories are:
}
\details{
  \itemize{ \item Mac OS X: \file{~/Library/Application
  Support/<AppName>} \item Unix:
  \file{~/.config/<appname>}, in \env{$XDG_CONFIG_HOME} if
  defined \item Win XP (not roaming): \file{C:\\Documents
  and Settings\\<username>\\Data\\<AppAuthor>\\<AppName>}
  \item Win XP (roaming): \file{C:\\Documents and
  Settings\\<username>\\Local
  Settings\\Data\\<AppAuthor>\\<AppName>} \item Win 7 (not
  roaming):
  \file{C:\\Users\\<username>\\AppData\\Local\\<AppAuthor>\\<AppName>}
  \item Win 7 (roaming):
  \file{C:\\Users\\<username>\\AppData\\Roaming\\<AppAuthor>\\<AppName>}
  }

  For Unix, we follow the XDG spec and support
  \env{$XDG_CONFIG_HOME}. We don't use \env{$XDG_DATA_HOME}
  as that data dir is mostly used at the time of
  installation, instead of the application adding data
  during runtime. Also, in practice, Linux apps tend to
  store their data in \file{~/.config/<appname>} instead of
  \file{~/.local/share/<appname>}.
}

