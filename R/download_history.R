
#' Downloads history
#'
#' Downloads history of packages on the submission queue as recorded on github branch.
#'
#' For some periods github actions recording the data didn't run,
#' so there are some periods with missing data.
#' @return A `data.frame` with columns:
#' - `Package`: the package name
#' - `Deadline`: the package deadline.
#' - `Maintainer`: The name of the maintainer.
#' - `Packages`: The name of all the packages that depend on it.
#' - `Dependencies`: The number of packages that depend on it.
#' - `Snapshot`: time when the data was analys
#'
#' @export
#' @importFrom utils download.file read.csv unzip
download_history <- function() {
  tmp_f <- tempfile(pattern = "crandeadlines-history", fileext = ".zip")
  tmp_dir <- tempdir()
  download.file("https://github.com/llrs/crandeadlines/archive/history.zip",
                destfile = tmp_f)
  # We unzip the files
  dat <- unzip(tmp_f, exdir = tmp_dir, setTimes = TRUE)
  outgoing_v1 <- dat[endsWith(dat, ".csv") & startsWith(basename(dat), "cran-outgoing-v1")]
  out_v1 <- do.call(rbind, lapply(outgoing_v1, read.table, sep = "\t", header = 1))
  out_v1$Snapshot <- NA

  # Added Snapshot column with the hour it was processed (Sys.Time)
  outgoing_v2 <- dat[endsWith(dat, ".csv") & startsWith(basename(dat), "cran-outgoing-v2")]
  out_v2 <- do.call(rbind, lapply(outgoing_v2, read.table, sep = "\t", header = 1))
  out_v2$Snapshot <- as.POSIXct(out_v2$Snapshot, tz = "UTC")

  out <- rbind(out_v2, out_v1)
  out$Deadline <- as.Date(out)
  out$Packages <- strsplit(out$Packages, ", ", fixed = TRUE)
  return(out)
}