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

expand_r_libs_specifiers <- function(version_path) {
    rversion <- getRversion()
    version_path <- gsub("([^%]|^)%V", paste("\\1", rversion, sep=""), version_path)
    version_path <- gsub("([^%]|^)%v", paste("\\1", paste(rversion$major, rversion$minor, sep="."), sep=""), version_path)
    version_path <- gsub("([^%]|^)%p", paste("\\1", R.version$platform, sep=""), version_path)
    version_path <- gsub("([^%]|^)%o", paste("\\1", R.version$os, sep=""), version_path)
    version_path <- gsub("([^%]|^)%a", paste("\\1", R.version$arch, sep=""), version_path)
    version_path <- gsub("%%", "%", version_path)
    version_path
}

get_dirs <- function(path, sep=":") {
    normalizePath(unique(strsplit(path, sep)[[1]]), mustWork=FALSE)
}

file_path <- function(...) {
  normalizePath(do.call("file.path", as.list(c(...))), mustWork = FALSE)
}

# For site_*_dir with multipath = TRUE
file_path_vec <- function(paths, ...) {
  vapply(paths, file_path, "string", ...)
}

CSIDL_APPDATA <- 26L
CSIDL_COMMON_APPDATA <- 35L
CSIDL_LOCAL_APPDATA <- 28L

# type_appdata in "roaming", "local", "common"
win_path <- function(type_appdata = "common", os = get_os()) {
    if(os == "win") {
        switch(type_appdata,
               roaming = tryCatch(win_path_csidl(CSIDL_APPDATA),
                            error = function(e) win_path_env("roaming")),
               local = tryCatch(win_path_csidl(CSIDL_LOCAL_APPDATA),
                            error = function(e) win_path_env("local")),
               common = tryCatch(win_path_csidl(),
                            error = function(e) win_path_env("common"))
               )
    } else {
        switch(type_appdata,
               roaming = "C:/Users/<username>/AppData",
               local = "C:/Users/<username>/Local",
               common = "C:/ProgramData"
               )
    }
}

#' @useDynLib rappdirs
win_path_csidl <- function(csidl = CSIDL_COMMON_APPDATA) {
  stopifnot(is.integer(csidl), length(csidl) == 1)
  path <- .Call("win_path", csidl, PACKAGE = "rappdirs")
  if(is.null(path)) { 
      stop("win_path not found")
  } 
  path
}

# How to get reasonable window paths via environmental variables
win_path_env <- function(type_appdata) {
    switch(type_appdata, 
    roaming =  {
        path <- Sys.getenv("APPDATA", unset=NA)
        if(is.na(path)) { stop("APPDATA environmental variable does not exist") }
        path
    },
    local = {
        path <- Sys.getenv("LOCALAPPDATA", unset=NA)
        if(is.na(path)) { # environmental variable not defined in XP
            user_profile <- Sys.getenv("USERPROFILE", unset=NA)
            if(is.na(user_profile)) { stop("USERPROFILE environmental variable does not exist") }
            path <- file.path(user_profile, "Local Settings", "Application Data")
        }
        path
    },
    common = {
        path <- Sys.getenv("PROGRAMDATA", unset=NA)
        if(is.na(path)) { 
            path <- Sys.getenv("ALLUSERPROFILE", unset=NA)    
            if(is.na(path)) {
                stop("PROGRAMDATA nor ALLUSERPROFILE environmental variable does not exist") 
            }
            path <- file.path(path, "Application Data")
        }
        path
    }
    )
}
