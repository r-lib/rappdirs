test_that("expand_r_libs_specifiers works as expected", {
  expect_equal(expand_r_libs_specifiers("%V"), as.character(getRversion()))
  expect_equal(expand_r_libs_specifiers("%%V"), "%V")
  expect_true(is.null(expand_r_libs_specifiers(NULL)))
})
test_that("parse_path_string works as expected", {
  expect_equal(
    parse_path_string("/home/foo/bin:/bin:/usr/share/bin:/bin"),
    c("/home/foo/bin", "/bin", "/usr/share/bin")
  )
  expect_equal(parse_path_string("/home/foo/bin"), "/home/foo/bin")
})

test_that("file_path drops NULLs", {
  expect_equal(file_path("a", NULL, "b"), "a/b")
})

test_that("windows fallbacks work", {
  skip_on_os("windows")
  withr::local_envvar(LOCALAPPDATA = NA, PROGRAMDATA = NA)

  expect_equal(win_path_env("roaming"), "<APPDATA>")

  expect_equal(win_path_env("local"), "<USERPROFILE>/Local Settings/Application Data")
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
