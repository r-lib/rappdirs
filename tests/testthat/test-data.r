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


test_that("site_config_dir works as expected", {
    if (all("/etc/xdg" %in% parse_path_string(Sys.getenv("XDG_CONFIG_DIRS", "/etc/xdg")))) {
        expect_equal(all("/etc/xdg/R" %in% site_config_dir("R", os="unix", multipath=TRUE)), TRUE)
    }
    expect_equal(site_config_dir("R", os="mac"), site_data_dir("R", os="mac"))
})


test_that("user_config_dir works as expected", {
    expect_equal(user_config_dir("R", os="mac"), "~/Library/Application Support/R")
    expect_equal(user_config_dir("R", version="%V", os="mac", expand=TRUE),
                 file.path("~/Library/Application Support/R", as.character(getRversion())))
    expect_equal(user_config_dir("R", version="%V", os="mac", expand=FALSE),
                 "~/Library/Application Support/R/%V")
})

test_that("windows env simulation is correct", {
    skip_on_os("windows")
    withr::local_envvar(LOCALAPPDATA = NA, PROGRAMDATA = NA)

    withr::local_envvar(APPDATA = "C:/config")
    expect_equal(
        user_config_dir("R", os="win", roaming=TRUE),
        "C:/config/R/R"
    )

    withr::local_envvar("USERPROFILE" = "C:/config1")
    expect_equal(
        user_config_dir("R", os="win", roaming=FALSE),
        "C:/config1/Local Settings/Application Data/R/R"
    )

    withr::local_envvar("LOCALAPPDATA" = "C:/config2")
    expect_equal(
        user_config_dir("R", os="win", roaming=FALSE),
        "C:/config2/R/R"
    )
})

test_that("on unix, uses XDG_CONFIG_HOME if set", {
    withr::local_envvar(XDG_CONFIG_HOME = "/config")
    expect_equal(user_config_dir("R", os="unix"), "/config/R")
})
