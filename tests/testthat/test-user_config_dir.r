context("user_config_dir")
test_that("user_config_dir works as expected", {
    if (Sys.getenv("XDG_CONFIG_HOME", path.expand("~/.config")) == path.expand("~/.config")) {
        expect_equal(user_config_dir("R", os="unix"), file_path("~/.config/R"))
    }
    expect_equal(user_config_dir("R", os="mac"), file_path("~/Library/Application Support/R"))
    expect_equal(user_config_dir("R", version="%V", os="mac", expand=TRUE),
                 file_path("~/Library/Application Support/R", as.character(getRversion())))
    expect_equal(user_config_dir("R", version="%V", os="mac", expand=FALSE),
                 file_path("~/Library/Application Support/R/%V"))
    if (!is.na(Sys.getenv("APPDATA", unset=NA))) {
        expect_equal(user_config_dir("R", os="win", roaming=TRUE),
                     file_path(Sys.getenv("APPDATA"), "R", "R"))
    }
    if (is.na(Sys.getenv("LOCALAPPDATA", unset=NA))) {
        if (!is.na(Sys.getenv("USERPROFILE", unset=NA))) {
            expect_equal(user_config_dir("R", os="win", roaming=FALSE),
                     file_path(Sys.getenv("USERPROFILE"), "Local Settings", "Application Data", "R", "R"))
        }
    } else {
        expect_equal(user_config_dir("R", os="win", roaming=FALSE),
                     file_path(Sys.getenv("LOCALAPPDATA"), "R", "R"))
    }
})
