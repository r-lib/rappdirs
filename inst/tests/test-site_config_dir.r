context("site_config_dir")
test_that("site_config_dir works as expected", {
    if (all("/etc/xdg" %in% parse_path_string(Sys.getenv("XDG_CONFIG_DIRS", "/etc/xdg")))) {
        expect_equal(all("/etc/xdg/R" %in% site_config_dir("R", os="unix", multipath=TRUE)), TRUE)
    }
    expect_equal(site_config_dir("R", os="mac"), site_data_dir("R", os="mac"))
})

