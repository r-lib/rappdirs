library(testthat)
library(rappdirs)

# ensure CRAN settings don't affect tests
Sys.unsetenv("R_USER_DATA_DIR")
Sys.unsetenv("R_USER_CONFIG_DIR")
Sys.unsetenv("R_USER_CACHE_DIR")

test_check("rappdirs")
