## Test environments

* GitHub Actions (ubuntu-16.04): devel, release, oldrel, 3.5, 3.4, 3.3
* GitHub Actions (windows): release, oldrel
* GitHub Actions (macOS): release
* win-builder: devel

## R CMD check results

0 errors | 0 warnings | 1 notes

* MIT license

* Link to "http://cran.r-project.org/web/packages/policies.html" triggers
  false positive for canonical url check

* I also updated my email address to <hadley@rstudio.com>.

## Reverse dependencies

I did not run R CMD check on the reverse dependencies because this release only fixes minor R CMD check notes, and a test failure illuminated by the dev version of testthat.
