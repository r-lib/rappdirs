#' Application directories: determine where to save data, caches and logs.
#'
#' @description rappdirs solves the problem of where to save persistent data
#'   outside of the R library or the R per-session [tempdir()].
#'
#' @section main functions: \itemize{
#'
#'   \item user data dir (`user_data_dir`)
#'
#'   \item user config dir (`user_config_dir`)
#'
#'   \item user cache dir (`user_cache_dir`)
#'
#'   \item site data dir (`site_data_dir`)
#'
#'   \item user log dir (`user_log_dir`)
#'
#'   }
#'
#' @section single entry function:
#'
#'   The `app_dir` provides a convenient single entry point.
#'
#' @section Caveats: Note that if you use rappdir's [user_data_dir()]
#'   and friends to define a storage location for files you must be aware of
#'   [race conditions](https://en.wikipedia.org/wiki/Race_condition) when
#'   more than one R process tries to create/write files in this directory. This
#'   is in contrast to using the [tempdir()], [tempfile()]
#'   base functions which should be unique for each R process. In general the
#'   directories provided by rappdirs are most suitable for storing data that is
#'   rarely written but might need to be shared across R sessions.
#'
#'   Note also that the
#'   [CRAN Policies](https://cran.r-project.org/web/packages/policies.html)
#'   have the following to say about storage of data by packages:
#'
#'   - Packages should not write in the users' home filespace, nor anywhere else
#'   on the file system apart from the R session's temporary directory (or
#'   during installation in the location pointed to by TMPDIR: and such usage
#'   should be cleaned up). Installing into the system's R installation (e.g.,
#'   scripts to its bin directory) is not allowed.
#'
#'   Limited exceptions may be allowed in interactive sessions if the package
#'   obtains confirmation from the user.
#'
#' @examples
#' dirs <- app_dir("SuperApp", "Acme")
#' dirs$config()
#' @seealso `[app_dir], [user_data_dir], [user_config_dir],
#'   [user_cache_dir], [site_data_dir], [user_log_dir]`
#' @docType package
#' @name rappdirs-package
#' @aliases rappdirs
#' @import methods
NULL
