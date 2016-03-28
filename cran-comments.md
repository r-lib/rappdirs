## Test environments
* local OS X install, R 3.2.4
* ubuntu 12.04 (on travis-ci), R 3.2.4
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 notes

* MIT license

* Link to "http://cran.r-project.org/web/packages/policies.html" triggers
  false positive for canonical url check

* I also updated my email address to <hadley@rstudio.com>.

## Reverse dependencies

I did not run R CMD check on the reverse dependencies because this release only fixes minor R CMD check notes, and a test failure illuminated by the dev version of testthat.
