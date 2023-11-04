test_that("user_cache_dir works as expected", {
  expect_equal(user_log_dir("R", os = "mac"), "~/Library/Logs/R")

  withr::local_envvar(XDG_CACHE_HOME = "/cache")
  expect_equal(user_log_dir("R", os = "unix"), "/cache/R/log")
  expect_equal(user_log_dir("R", os = "unix", opinion = FALSE), "/cache/R")
})

test_that("user_cache_dir works with windows simulation", {
  skip_on_os("windows")
  expect_equal(
    user_log_dir("R", os = "win"),
    "<USERPROFILE>/Local Settings/Application Data/R/R/Logs"
  )
})
