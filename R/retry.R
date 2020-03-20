#' Retry code block until it succeeds
#'
#' @param block    Code block to retry
#' @param attempts Maximum number of times to retry
#'
#' @return The result of the code block if it succeeds after the number of
#'     attempts, the last error it raised if it does not.
#'
#' @examples
#' y <- retry({
#'   random_num <- runif(1)
#'   print(random_num)
#'   stopifnot(random_num < .2)
#'   random_num
#' })
#' print(y)
#'
#' z <- retry({
#'   random_num <- runif(1)
#'   print(random_num)
#'   stopifnot(random_num < .02)
#'   random_num
#'   }, 10
#' )
#' print(z)
#'
#' @export
retry <- function(block, attempts=10) {
  assertthat::assert_that(
    is.numeric(attempts), attempts > 0, attempts %% 1 == 0,
    msg="attempts must be a positive integer")
  for (. in 1:attempts) {
    result <- try(block)
    if (class(result) == "try-error") next
  }
  result
}
