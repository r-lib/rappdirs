context("utils")
test_that("expand_r_libs_specifiers works as expected", {
    expect_equal(expand_r_libs_specifiers("%V"), as.character(getRversion()))
    expect_equal(expand_r_libs_specifiers("%%V"), "%V")
    expect_output(expand_r_libs_specifiers("%p-platform/%v"), "/")
})
test_that("parse_path_string works as expected", {
    expect_equal(parse_path_string("/home/foo/bin:/bin:/usr/share/bin:/bin"),
                 c("/home/foo/bin", "/bin", "/usr/share/bin"))
})
