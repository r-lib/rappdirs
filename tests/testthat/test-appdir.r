test_that("appdir works as expected", {
  expect_snapshot({
    app <- app_dir("ggplot2", "hadley", os = "mac")
    app$cache()
    app$log()
    app$data()
    app$config()
    app$site_data()
    app$site_config()
  })
})
