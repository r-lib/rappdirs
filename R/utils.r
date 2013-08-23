get_os <- function() {
  if(.Platform$OS.type == "windows") { 
    "win"
  } else if (Sys.info()["sysname"] == "Darwin") {
    "mac" 
  } else if(.Platform$OS.type == "unix") { 
    "unix"
  } else {
    stop("Unknown OS")
  }
}

gsub_special <- function(pattern, replacement, x) {
    gsub(paste0("([^%]|^)", pattern), paste0("\\1", replacement), x)
}

expand_r_libs_specifiers <- function(version_path) {
  if (is.null(version_path)) return (NULL)
  rversion <- getRversion()
  version_path <- gsub_special("%V", rversion, version_path)
  version_path <- gsub_special("%v", paste(rversion$major, rversion$minor, sep="."), version_path)
  version_path <- gsub_special("%p", R.version$platform, version_path)
  version_path <- gsub_special("%o", R.version$os, version_path)
  version_path <- gsub_special("%a", R.version$arch, version_path)
  version_path <- gsub("%%", "%", version_path)
  version_path
}

parse_path_string <- function(path, sep=":") {
  normalizePath(unique(strsplit(path, sep)[[1]]), mustWork=FALSE)
}

file_path <- function(...) {
  normalizePath(do.call("file.path", as.list(c(...))), mustWork = FALSE)
}

# For site_*_dir with multipath = TRUE
file_path_vec <- function(paths, ...) {
  vapply(paths, file_path, "string", ..., USE.NAMES = FALSE)
}

"%||%" <- function(a, b) if (is.null(a)) b else a

# type_appdata in "roaming", "local", "common"
win_path <- function(type_appdata = "common", os = get_os()) {
  if(os == "win") {
    switch(type_appdata,
      roaming = win_path_csidl(CSIDL_APPDATA) %||% win_path_env("roaming"),
      local = win_path_csidl(CSIDL_LOCAL_APPDATA) %||% win_path_env("local"),
      common = win_path_csidl(CSIDL_COMMON_APPDATA) %||% win_path_env("common")
    )
  } else {
    switch(type_appdata,
      roaming = "C:/Users/<username>/AppData",
      local = "C:/Users/<username>/Local",
      common = "C:/ProgramData"
    )
  }
}

CSIDL_APPDATA <- 26L
CSIDL_COMMON_APPDATA <- 35L
CSIDL_LOCAL_APPDATA <- 28L
#' @useDynLib rappdirs
win_path_csidl <- function(csidl = CSIDL_COMMON_APPDATA) {
  stopifnot(is.integer(csidl), length(csidl) == 1)
  path <- .Call("win_path", csidl, PACKAGE = "rappdirs")
  path
}

Sys.getenv_force <- function(env) {
  val <- Sys.getenv(env, unset = NA)
  if(!is.na(val)) return(val)
  stop("Could not find Windows environmental variables") 
}
# How to get reasonable window paths via environmental variables
win_path_env <- function(type_appdata) {
  switch(type_appdata, 
    roaming =  Sys.getenv_force("APPDATA"),
  local = {
    path <- Sys.getenv("LOCALAPPDATA", unset=NA)
    if(is.na(path)) { # environmental variable not defined in XP
      path <- file.path(Sys.getenv_force("USERPROFILE"),
                        "Local Settings", "Application Data")
     }
    path
  },
  common = {
    path <- Sys.getenv("PROGRAMDATA", unset=NA)
    if(is.na(path)) { 
      path <- file.path(Sys.getenv_force("ALLUSERPROFILE"),
                              "Application Data")
    }
    path
  }
  )
}
