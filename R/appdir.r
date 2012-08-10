#' Convenience wrapper for getting app dirs.
#' 
#' Has methods:
#' 
#' \itemize{
#'   \item \code{cache}
#'   \item \code{log}
#'   \item \code{data}
#'   \item \code{site_data}
#' }
#'
#' @inheritParams user_data_dir
#' @export
#' @examples
#' ggplot2_app <- app_dir("ggplot2", "hadley")
#' ggplot2_app$cache()
#' ggplot2_app$log()
#' ggplot2_app$data()
#' ggplot2_app$site_data()
app_dir <- function(appname, appauthor, version = NULL) {
  appdirs$new(appname = appname, appauthor = appauthor, version = version)
}

appdirs <- setRefClass("AppDirs", 
  fields = c("appname", "appauthor", "version"), 
  methods = list(
    cache = function() user_cache_dir(appname, appauthor, version), 
    log = function() user_log_dir(appname, appauthor, version), 
    data = function(roaming = FALSE) {
      user_data_dir(appname, appauthor, version, roaming = roaming)
    },
    site_data = function() site_data_dir(appname, appauthor, version)
  )
)  
