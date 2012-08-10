os <- function() {
  os <- R.Version()$os

  if (grepl("linux", os)) {
    "lin"
  } else if (grepl("darwin", os)) {
    "mac"
  } else  if (grepl("w32", os)) {
    "win"
  } else {
    stop("Unknown OS")
  }
}

file_path <- function(...) {
  normalizePath(do.call("file.path", as.list(c(...))), mustWork = FALSE)
}

CSIDL_APPDATA <- 26L
CSIDL_COMMON_APPDATA <- 35L
CSIDL_LOCAL_APPDATA <- 28L

#' @useDynLib rappdirs
win_path <- function(csidl = CSIDL_COMMON_APPDATA) {
  stopifnot(is.integer(csidl), length(csidl) == 1)
  .Call("win_path", csidl, PACKAGE = "rappdirs")
}
