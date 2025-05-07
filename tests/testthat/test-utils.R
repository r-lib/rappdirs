test_that("expand_r_libs_specifiers works as expected", {
  expect_equal(expand_r_libs_specifiers("%V"), as.character(getRversion()))
  expect_equal(expand_r_libs_specifiers("%%V"), "%V")
  expect_equal(expand_r_libs_specifiers(NULL), NULL)
})

test_that("file_path drops NULLs", {
  expect_equal(file_path("a", NULL, "b"), "a/b")
})

test_that("file_path is not vectorised", {
  expect_equal(file_path(c("a", "b"), c("c", "d")), "a/b/c/d")
})

test_that("windows fallbacks work", {
  skip_on_os("windows")
  withr::local_envvar(LOCALAPPDATA = NA, PROGRAMDATA = NA)

  expect_equal(win_path_env("roaming"), "<APPDATA>")

  expect_equal(
    win_path_env("local"),
    "<USERPROFILE>/Local Settings/Application Data"
  )
  withr::local_envvar(LOCALAPPDATA = "<LOCALAPPDATA>")
  expect_equal(win_path_env("local"), "<LOCALAPPDATA>")

  expect_equal(win_path_env("common"), "<ALLUSERPROFILE>/Application Data")
  withr::local_envvar(PROGRAMDATA = "<PROGRAMDATA>")
  expect_equal(win_path_env("common"), "<PROGRAMDATA>")

  expect_error(win_path_env("foo"), "invalid")
})

test_that("check_version works as expected", {
  expect_snapshot({
    expect_equal(check_version("1", NULL), NULL)
    expect_equal(check_version("1", "R"), "1")
  })
})
