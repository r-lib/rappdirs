context("appdir")
test_that("appdir works as expected", {
  ggplot2_app <- app_dir("ggplot2", "hadley")
  if (get_os() != "unix") {
    expect_equal(ggplot2_app$config(), ggplot2_app$data())
  } else if (Sys.getenv("XDG_DATA_HOME", ".local/share") != Sys.getenv("XDG_CONFIG_HOME", "config")) {
    expect_false(identical(ggplot2_app$config(), ggplot2_app$data()))
  }
})
