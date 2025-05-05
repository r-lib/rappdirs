# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

library(testthat)
library(rappdirs)

# ensure CRAN settings don't affect tests
Sys.unsetenv("R_USER_DATA_DIR")
Sys.unsetenv("R_USER_CONFIG_DIR")
Sys.unsetenv("R_USER_CACHE_DIR")

test_check("rappdirs")
