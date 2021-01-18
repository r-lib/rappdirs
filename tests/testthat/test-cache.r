test_that("works on mac and linux", {
  withr::local_envvar(XDG_CACHE_HOME = NA)
  expect_equal(user_cache_dir("R", os = "unix"), "~/.cache/R")
  expect_equal(user_cache_dir("R", os = "mac"), "~/Library/Caches/R")
})

test_that("can override with R_USER_CACHE_DIR", {
  withr::local_envvar(R_USER_CACHE_DIR = "/test")
  expect_equal(user_cache_dir("R", os = "mac"), "/test/R")
})
test_that("works on windows simulation", {
  skip_on_os("windows")
  expect_equal(
    user_cache_dir("R", os = "win"),
    "<USERPROFILE>/Local Settings/Application Data/R/R/Cache"
  )
})
