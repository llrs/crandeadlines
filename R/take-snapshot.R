
recursive_revdeps <- function(pkgs) {
  tools::package_dependencies(pkgs, reverse = TRUE, recursive = TRUE)
}

#' Take Snapshot of CRAN deadlines
#'
#' @return A data.frame, one line per package with a deadline.
#' @import dplyr
#' @author Code modified from Hadley Wickham
#' @export
#' @examples
#' take_snapshot()
take_snapshot <- function(){

  cran_db <- tools::CRAN_package_db()
  # avoid notes
  Package <- NULL
  Deadline <- NULL
  Maintainer <- NULL
  Dependencies <- NULL

  has_deadline <- cran_db |>
    filter(!is.na(Deadline)) |>
    select(Package, Deadline, Maintainer) |>
    arrange(Deadline) |>
    mutate(
      Deadline = as.Date(Deadline),
      Maintainer = gsub(" <.*?>", "", Maintainer))


  has_deadline$Packages <- recursive_revdeps(has_deadline$Package)
  has_deadline$Dependencies <- lengths(has_deadline$Packages)
  has_deadline$Snapshot <- Sys.time()

  arrange(has_deadline, Deadline, -Dependencies)

}

