#' Convenience wrapper for getting app dirs.
#'
#' @description
#' Has methods:
#' * `cache`
#' * `log`
#' * `data`
#' * `config`
#' * `site_data`
#' * `site_config`
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
app_dir <- function(appname = NULL, appauthor = appname, version = NULL, expand = TRUE, os = NULL) {
  os <- check_os(os)
  appdirs$new(appname = appname, appauthor = appauthor, version = version, expand = expand, os = os)
}

appdirs <- setRefClass("AppDirs",
  fields = c("appname", "appauthor", "version", "expand", "os"),
  methods = list(
    cache = function(opinion = TRUE) user_cache_dir(appname, appauthor, version, opinion, expand, os),
    log = function(opinion = TRUE) user_log_dir(appname, appauthor, version, opinion, expand, os),
    data = function(roaming = FALSE) {
      user_data_dir(appname, appauthor, version, roaming, expand, os)
    },
    config = function(roaming = FALSE) {
      user_config_dir(appname, appauthor, version, roaming, expand, os)
    },
    site_data = function(multipath = FALSE) site_data_dir(appname, appauthor, version, multipath, expand, os),
    site_config = function(multipath = FALSE) site_config_dir(appname, appauthor, version, multipath, expand, os)
  )
)
