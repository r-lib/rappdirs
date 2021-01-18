test_that("works on mac and linux", {
  withr::local_envvar(XDG_CACHE_HOME = NA)
  expect_equal(user_cache_dir("R", os = "unix"), "~/.cache/R")
  expect_equal(user_cache_dir("R", os = "mac"), "~/Library/Caches/R")
})

test_that("works on windows simulation", {
  skip_on_os("windows")
  withr::local_envvar(USERPROFILE = NA)

  expect_equal(user_cache_dir("R", os = "win"), "<LOCALAPPDATA>/R/R/Cache")
})
