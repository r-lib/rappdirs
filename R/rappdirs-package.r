#' Application directories: determine where to save data, caches and logs.
#' 
#' @description rappdirs solves the problem of where to save persistent data 
#'   outside of the R library or the R per-session \code{\link{tempdir}}.
#'   
#'   Note that the
#'   \href{http://cran.r-project.org/web/packages/policies.html}{CRAN Policies} 
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
#' @section main functions: \itemize{
#'   
#'   \item user data dir (\code{user_data_dir})
#'   
#'   \item user config dir (\code{user_config_dir})
#'   
#'   \item user cache dir (\code{user_cache_dir})
#'   
#'   \item site data dir (\code{site_data_dir})
#'   
#'   \item user log dir (\code{user_log_dir})
#'   
#'   }
#'   
#' @section single entry function:
#'   
#'   The \code{app_dir} provides a convenient single entry point.
#'   
#' @examples
#' dirs <- app_dir("SuperApp", "Acme")
#' dirs$config()
#' 
#' @seealso \code{\link{app_dir}, \link{user_data_dir}, \link{user_config_dir}, 
#'   \link{user_cache_dir}, \link{site_data_dir}, \link{user_log_dir}}
#' @docType package
#' @name rappdirs-package
#' @aliases rappdirs
#' @import methods
NULL
