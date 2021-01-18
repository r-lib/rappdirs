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

    withr::local_envvar(APPDATA = "C:\\config")
    expect_equal(
        user_config_dir("R", os="win", roaming=TRUE),
        "C:/config/R/R"
    )

    withr::local_envvar("USERPROFILE" = "C:\\config1")
    expect_equal(
        user_config_dir("R", os="win", roaming=FALSE),
        "C:/config1/Local Settings/Application Data/R/R"
    )

    withr::local_envvar("LOCALAPPDATA" = "C:\\config2")
    expect_equal(
        user_config_dir("R", os="win", roaming=FALSE),
        "C:/config2/R/R"
    )
})

test_that("on unix, uses XDG_CONFIG_HOME if set", {
    withr::local_envvar(XDG_CONFIG_HOME = "/config")
    expect_equal(user_config_dir("R", os="unix"), "/config/R")
})
