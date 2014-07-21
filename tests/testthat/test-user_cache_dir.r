context("user_cache_dir")
test_that("user_cache_dir works as expected", {
  if (Sys.getenv("XDG_CACHE_HOME", path.expand("~/.cache")) == path.expand("~/.cache")) {
    expect_equal(user_cache_dir("R", os="unix"), file_path("~/.cache/R"))
  }
  expect_equal(user_cache_dir("R", os="mac"), file_path("~/Library/Caches/R"))
  expect_warning(user_cache_dir(version = "1.1"), regexp = "appname")
})
