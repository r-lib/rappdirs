% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.r
\name{user_data_dir}
\alias{user_data_dir}
\alias{user_config_dir}
\title{Path to user config/data directories}
\usage{
user_data_dir(
  appname = NULL,
  appauthor = appname,
  version = NULL,
  roaming = FALSE,
  expand = TRUE,
  os = NULL
)

user_config_dir(
  appname = NULL,
  appauthor = appname,
  version = NULL,
  roaming = TRUE,
  expand = TRUE,
  os = NULL
)
}
\arguments{
\item{appname}{is the name of application. If NULL, just the system
directory is returned.}

\item{appauthor}{(only required and used on Windows) is the name of the
appauthor or distributing body for this application. Typically
it is the owning company name. This falls back to appname.}

\item{version}{is an optional version path element to append to the
path. You might want to use this if you want multiple versions
of your app to be able to run independently. If used, this
would typically be \code{"<major>.<minor>"}. Only applied when appname
is not NULL.}

\item{roaming}{(logical, default \code{FALSE}) can be set \code{TRUE} to
use the Windows roaming appdata directory. That means that for users on
a Windows network setup for roaming profiles, this user data will be
sync'd on login. See
<https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-vista/cc766489(v=ws.10).
for a discussion of issues.}

\item{expand}{If TRUE (the default) will expand the \code{R_LIBS} specifiers with their equivalents.
See \code{\link[=R_LIBS]{R_LIBS()}} for list of all possibly specifiers.}

\item{os}{Operating system whose conventions are used to construct the
requested directory. Possible values are "win", "mac", "unix". If \code{NULL}
(the default) then the current OS will be used.}
}
\description{
\code{user_data_dir()} returns path to the user-specific data directory and
\code{user_config_dir()} returns full path to the user-specific configuration
directory. These are the same on Windows and Mac but different on Linux.

These functions first use \code{R_USER_DATA_DIR} and \code{R_USER_CONFIG_DIR} if set.
Otherwise, they follow platform conventions. Typical user config and data
directories are:
\itemize{
\item Mac OS X: \verb{~/Library/Application Support/<AppName>}
\item Win XP (not roaming): \verb{C:\\\\Documents and Settings\\\\<username>\\\\Data\\\\<AppAuthor>\\\\<AppName>}
\item Win XP (roaming): \verb{C:\\\\Documents and Settings\\\\<username>\\\\Local Settings\\\\Data\\\\<AppAuthor>\\\\<AppName>}
\item Win 7 (not roaming): \verb{C:\\\\Users\\\\<username>\\\\AppData\\\\Local\\\\<AppAuthor>\\\\<AppName>}
\item Win 7 (roaming): \verb{C:\\\\Users\\\\<username>\\\\AppData\\\\Roaming\\\\<AppAuthor>\\\\<AppName>}
}

Only Linux makes the distinction between config and data:
\itemize{
\item Data: \verb{~/.local/share/<AppName>}
\item Config: \verb{~/.config/<AppName>}
}
}
\examples{
user_data_dir("rappdirs")

user_config_dir("rappdirs", roaming = TRUE, os = "win")
user_config_dir("rappdirs", roaming = FALSE, os = "win")
user_config_dir("rappdirs", os = "unix")
user_config_dir("rappdirs", os = "mac")
user_config_dir("rappdirs", version = "\%p-platform/\%v")
}
