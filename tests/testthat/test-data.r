test_that("default paths work on mac", {
  expect_equal(user_data_dir("R", os = "mac"), "~/Library/Application Support/R")
  expect_equal(user_config_dir("R", os = "mac"), "~/Library/Application Support/R")
  expect_equal(site_data_dir("R", os = "mac"), "/Library/Application Support/R")
  expect_equal(site_config_dir("R", os = "mac"), "/Library/Application Support/R")
})

test_that("default paths work on linux", {
  withr::local_envvar(
    XDG_DATA_HOME = NA,
    XDG_CONFIG_HOME = NA,
    XDG_DATA_DIRS = NA,
    XDG_CONFIG_DIRS = NA,
  )

  expect_equal(user_data_dir("R", os = "unix"), "~/.local/share/R")
  expect_equal(user_config_dir("R", os = "unix"), "~/.config/R")
  expect_equal(site_data_dir("R", os = "unix"), "/usr/local/share/R")
  expect_equal(site_config_dir("R", os = "unix"), "/etc/xdg/R")
})

test_that("can override linux paths with envvars", {
  withr::local_envvar(
    XDG_DATA_HOME = "A",
    XDG_CONFIG_HOME = "B",
    XDG_DATA_DIRS = "C",
    XDG_CONFIG_DIRS = "D",
  )

  expect_equal(user_data_dir("R", os = "unix"), "A/R")
  expect_equal(user_config_dir("R", os = "unix"), "B/R")
  expect_equal(site_data_dir("R", os = "unix"), "C/R")
  expect_equal(site_config_dir("R", os = "unix"), "D/R")
})

test_that("can override with R_USER_DATA_DIR", {
  withr::local_envvar(R_USER_DATA_DIR = "/test")
  expect_equal(user_data_dir("R", os = "mac"), "/test/R")

  withr::local_envvar(R_USER_CONFIG_DIR = "/test")
  expect_equal(user_config_dir("R", os = "mac"), "/test/R")
})

test_that("can optionally use all XDG_DATA_DIRS", {
  withr::local_envvar(XDG_DATA_DIRS = "/usr/local/share:/usr/share")
  expect_equal(
    site_data_dir("R", os = "unix", multipath = TRUE),
    c("/usr/local/share/R", "/usr/share/R")
  )
  expect_equal(
    site_data_dir("R", os = "unix", multipath = FALSE),
    "/usr/local/share/R"
  )
})


test_that("default paths work in windows simulation", {
  skip_on_os("windows")
  expect_equal(user_data_dir("R", os = "win"), "<USERPROFILE>/Local Settings/Application Data/R/R")
  expect_equal(user_config_dir("R", os = "win"), "<APPDATA>/R/R")
  expect_equal(site_data_dir("R", os = "win"), "<ALLUSERPROFILE>/Application Data/R/R")
  expect_equal(site_config_dir("R", os = "win"), "<ALLUSERPROFILE>/Application Data/R/R")
})

test_that("can override windows paths with env vars", {
  skip_on_os("windows")
  withr::local_envvar(LOCALAPPDATA = NA, PROGRAMDATA = NA)

  withr::local_envvar(APPDATA = "C:/config")
  expect_equal(
    user_config_dir("R", os = "win", roaming = TRUE),
    "C:/config/R/R"
  )

  withr::local_envvar("USERPROFILE" = "C:/config1")
  expect_equal(
    user_config_dir("R", os = "win", roaming = FALSE),
    "C:/config1/Local Settings/Application Data/R/R"
  )

  withr::local_envvar("LOCALAPPDATA" = "C:/config2")
  expect_equal(
    user_config_dir("R", os = "win", roaming = FALSE),
    "C:/config2/R/R"
  )
})


test_that("can expand versioned paths", {
  expect_equal(
    site_data_dir("R", version = "%V", os = "mac", expand = TRUE),
    file.path("/Library/Application Support/R", as.character(getRversion()))
  )
  expect_equal(
    site_data_dir("R", version = "%V", os = "mac", expand = FALSE),
    "/Library/Application Support/R/%V"
  )
})

# linux -------------------------------------------------------------------
