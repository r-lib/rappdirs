context("site_data_dir")
test_that("site_data_dir works as expected", {
    if (all(c("/usr/local/share", "/usr/share") %in% parse_path_string(Sys.getenv("XDG_DATA_DIRS", "/usr/local/share:/usr/share")))) {
        expect_equal(all(c("/usr/local/share/R", "/usr/share/R") %in% site_data_dir("R", os="unix", multipath=TRUE)),
                     TRUE)
        expect_equal(all(c("/usr/local/share/R", "/usr/share/R") %in% site_data_dir("R", os="unix")),
                     FALSE)
    }
    expect_equal(site_data_dir("R", os="mac"), file_path("/Library/Application Support/R"))
    expect_equal(site_data_dir("R", version="%V", os="mac", expand=TRUE),
                 file_path("/Library/Application Support/R", as.character(getRversion())))
    expect_equal(site_data_dir("R", version="%V", os="mac", expand=FALSE),
                 file_path("/Library/Application Support/R/%V"))
})
