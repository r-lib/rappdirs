#' Convenience wrapper for getting app dirs.
#' 
#' Has methods:
#' 
#' \itemize{
#'   \item \code{cache}
#'   \item \code{log}
#'   \item \code{data}
#'   \item \code{config}
#'   \item \code{site_data}
#'   \item \code{site_config}
#' }
#'
#' @inheritParams user_data_dir
#' @export
#' @examples
#' ggplot2_app <- app_dir("ggplot2", "hadley")
#' ggplot2_app$cache()
#' ggplot2_app$log()
#' ggplot2_app$data()
#' ggplot2_app$config()
#' ggplot2_app$site_config()
#' ggplot2_app$site_data()
app_dir <- function(appname = NULL, appauthor = NULL, version = NULL, expand = FALSE, os = NULL) {
  appdirs$new(appname = appname, appauthor = appauthor, version = version)
}

appdirs <- setRefClass("AppDirs", 
  fields = c("appname", "appauthor", "version"), 
  methods = list(
    cache = function(expand = FALSE, os = NULL) user_cache_dir(appname, appauthor, version, expand, os), 
    log = function(opinion = TRUE, expand = FALSE, os = NULL) user_log_dir(appname, appauthor, version, opinion, expand, os), 
    data = function(roaming = FALSE, expand = FALSE, os = NULL) {
      user_data_dir(appname, appauthor, version, roaming = roaming, expand, os)
    },
    config = function(roaming = FALSE, expand = FALSE, os = NULL) {
      user_data_dir(appname, appauthor, version, roaming = roaming, expand, os)
    },
    site_data = function(multipath = FALSE, expand = FALSE, os = NULL) site_data_dir(appname, appauthor, version, multipath, expand, os),
    site_config = function(multipath = FALSE, expand = FALSE, os = NULL) site_config_dir(appname, appauthor, version, multipath, expand, os)
  )
)  
