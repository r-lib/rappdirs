# appdir works as expected

    Code
      app <- app_dir("ggplot2", "hadley", os = "mac")
    Code
      app$cache()
    Output
      [1] "/Users/hadley/Library/Caches/ggplot2"
    Code
      app$log()
    Output
      [1] "/Users/hadley/Library/Logs/ggplot2"
    Code
      app$data()
    Output
      [1] "/Users/hadley/Library/Application Support/ggplot2"
    Code
      app$config()
    Output
      [1] "/Users/hadley/Library/Application Support/ggplot2"
    Code
      app$site_data()
    Output
      [1] "/Library/Application Support/ggplot2"
    Code
      app$site_config()
    Output
      [1] "/Library/Application Support/ggplot2"

