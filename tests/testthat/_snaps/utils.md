# check_version works as expected

    Code
      expect_equal(check_version("1", NULL), NULL)
    Condition
      Warning:
      version is ignored when appname is null
    Code
      expect_equal(check_version("1", "R"), "1")

