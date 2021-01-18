test_that("site_data_dir works as expected", {
    expect_equal(site_data_dir("R", os="mac"), "/Library/Application Support/R")
    expect_equal(site_data_dir("R", version="%V", os="mac", expand=TRUE),
                 file.path("/Library/Application Support/R", as.character(getRversion())))
    expect_equal(site_data_dir("R", version="%V", os="mac", expand=FALSE),
                 "/Library/Application Support/R/%V")
})

test_that("can optionally use all XDG_DATA_DIRS", {
    withr::local_envvar("XDG_DATA_DIRS" = "/usr/local/share:/usr/share")
    expect_equal(
        site_data_dir("R", os="unix", multipath = TRUE),
        c("/usr/local/share/R", "/usr/share/R")
    )
    expect_equal(
        site_data_dir("R", os="unix", multipath = FALSE),
        "/usr/local/share/R"
    )
})
