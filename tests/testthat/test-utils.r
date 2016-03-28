context("utils")
test_that("expand_r_libs_specifiers works as expected", {
  expect_equal(expand_r_libs_specifiers("%V"), as.character(getRversion()))
  expect_equal(expand_r_libs_specifiers("%%V"), "%V")
  expect_true(is.null(expand_r_libs_specifiers(NULL)))
})
test_that("parse_path_string works as expected", {
  expect_equal(parse_path_string("/home/foo/bin:/bin:/usr/share/bin:/bin"),
               file_path_vec(c("/home/foo/bin", "/bin", "/usr/share/bin")))
  expect_equal(parse_path_string("/home/foo/bin"), file_path("/home/foo/bin"))
})

test_that("file_path_vec works as expected", {
  expect_equal(file_path_vec("rappdirs", "appname", "version"),
               file_path("rappdirs", "appname", "version"))
})
