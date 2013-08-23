\name{app_dir}
\alias{app_dir}
\title{Convenience wrapper for getting app dirs.}
\usage{
  app_dir(appname = NULL, appauthor = appname,
    version = NULL, expand = TRUE, os = get_os())
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
  Has methods:
}
\details{
  \itemize{ \item \code{cache} \item \code{log} \item
  \code{data} \item \code{config} \item \code{site_data}
  \item \code{site_config} }
}
\examples{
ggplot2_app <- app_dir("ggplot2", "hadley")
ggplot2_app$cache()
ggplot2_app$log()
ggplot2_app$data()
ggplot2_app$config()
ggplot2_app$site_config()
ggplot2_app$site_data()
}

