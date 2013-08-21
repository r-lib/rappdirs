context("Unit tests")

context("user_config_dir")
test_that("user_config_dir works as expected", {
    if(Sys.getenv("XDG_CONFIG_HOME", path.expand("~/.config")) == path.expand("~/.config")) {
        expect_equal(user_config_dir("R", os="unix"), path.expand("~/.config/R"))   
    }
    expect_equal(user_config_dir("R", os="mac"), path.expand("~/Library/Application Support/R"))
    expect_equal(user_config_dir("R", version="%V", os="mac", expand=TRUE), 
                 file.path(path.expand("~/Library/Application Support/R"), as.character(getRversion())))
    expect_equal(user_config_dir("R", version="%V", os="mac", expand=FALSE), 
                 path.expand("~/Library/Application Support/R/%V"))
    if(!is.na(Sys.getenv("APPDATA", unset=NA))) {
        expect_equal(user_config_dir("R", os="win", roaming=TRUE),
                     file.path(Sys.getenv("APPDATA"), "R", "R"))
    } 
    if(is.na(Sys.getenv("LOCALAPPDATA", unset=NA))) {
        if(!is.na(Sys.getenv("USERPROFILE", unset=NA))) {
            expect_equal(user_config_dir("R", os="win", roaming=FALSE),
                     file.path(Sys.getenv("USERPROFILE"), "Local Settings", "Application Data", "R", "R"))
        }
    } else {
        expect_equal(user_config_dir("R", os="win", roaming=FALSE),
                     file.path(Sys.getenv("LOCALAPPDATA"), "R", "R"))
    } 
})
context("user_cache_dir")
test_that("user_cache_dir works as expected", {
   if(Sys.getenv("XDG_CACHE_HOME", path.expand("~/.cache")) == path.expand("~/.cache")) {
        expect_equal(user_cache_dir("R", os="unix"), path.expand("~/.cache/R"))   
    }
    expect_equal(user_cache_dir("R", os="mac"), path.expand("~/Library/Caches/R"))
})
context("user_log_dir")
test_that("user_cache_dir works as expected", {
   if(Sys.getenv("XDG_CACHE_HOME", path.expand("~/.cache")) == path.expand("~/.cache")) {
        expect_equal(user_log_dir("R", os="unix"), path.expand("~/.cache/R/log"))   
        expect_equal(user_log_dir("R", os="unix", opinion=FALSE), path.expand("~/.cache/R"))   
    }
    expect_equal(user_cache_dir("R", os="mac"), path.expand("~/Library/Caches/R"))
})
context("site_data_dir")
test_that("site_data_dir works as expected", {
    if(all(c("/usr/local/share", "/usr/share") %in% get_dirs(Sys.getenv("XDG_DATA_DIRS", "/usr/local/share:/usr/share")))) {
        expect_equal(all(c("/usr/local/share/R", "/usr/share/R") %in% site_data_dir("R", os="unix", multipath=TRUE)),
                     TRUE)
        expect_equal(all(c("/usr/local/share/R", "/usr/share/R") %in% site_data_dir("R", os="unix")),
                     FALSE)
    }
    expect_equal(site_data_dir("R", os="mac"), "/Library/Application Support/R")
    expect_equal(site_data_dir("R", version="%V", os="mac", expand=TRUE), 
                 file.path(path.expand("/Library/Application Support/R"), as.character(getRversion())))
    expect_equal(site_data_dir("R", version="%V", os="mac", expand=FALSE), 
                 path.expand("/Library/Application Support/R/%V"))
})
context("site_config_dir")
test_that("site_config_dir works as expected", {
    if(all("/etc/xdg" %in% get_dirs(Sys.getenv("XDG_CONFIG_DIRS", "/etc/xdg")))) {
        expect_equal(all("/etc/xdg/R" %in% site_config_dir("R", os="unix", multipath=TRUE)), TRUE)
    }
    expect_equal(site_config_dir("R", os="mac"), site_data_dir("R", os="mac"))
})
context("expand_r_libs_specifiers")
test_that("expand_r_libs_specifiers works as expected", {
    expect_equal(expand_r_libs_specifiers("%V"), as.character(getRversion()))
    expect_equal(expand_r_libs_specifiers("%%V"), "%V")
    expect_output(expand_r_libs_specifiers("%p-platform/%v"), "/")
})
context("get_dirs")
test_that("get_dirs works as expected", {
    expect_equal(get_dirs("/home/foo/bin:/bin:/usr/share/bin:/bin"),
                 c("/home/foo/bin", "/bin", "/usr/share/bin"))
})

