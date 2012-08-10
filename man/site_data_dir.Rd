\name{site_data_dir}
\alias{site_data_dir}
\title{Return full path to the user-shared data dir for this application.}
\usage{
  site_data_dir(appname, appauthor, version = NULL)
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
}
\description{
  Typical user data directories are:
}
\details{
  \itemize{ \item Mac OS X: \file{/Library/Application
  Support/<AppName>} \item Unix: \file{/etc/xdg/<appname>}
  \item Win XP: \file{C:\Documents and Settings\All
  Users\Application Data\<AppAuthor>\<AppName>} \item
  Vista: (Fail! file{C:\ProgramData} is a hidden
  \emph{system} directory on Vista.) \item Win 7:
  \file{C:\ProgramData\<AppAuthor>\<AppName>}.  Hidden, but
  writeable on Win 7. }

  For Unix, this is using the \env{$XDG_CONFIG_DIRS[0]}
  default.
}
\section{Warning}{
  Do not use this on Windows. See the note above for why.
}

