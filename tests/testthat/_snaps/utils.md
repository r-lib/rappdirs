# windows fallbacks work

    Code
      win_path_env("foo")
    Condition
      Error in `win_path_env()`:
      ! invalid `type` argument

# check_version works as expected

    Code
      expect_equal(check_version("1", NULL), NULL)
    Condition
      Warning:
      version is ignored when appname is null
    Code
      expect_equal(check_version("1", "R"), "1")

