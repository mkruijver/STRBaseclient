#' Retrieves Basic Information for a locus
#'
#' The `get_locus_information` function queries the STRbase API and retrieves basic information for a locus. This includes the `lociId` which can be used when querying other endpoints.
#'
#' @param locus The specific locus. For example `"FGA"`.
#' @return A List.
#' @examples
#' \dontrun{
#'   # Basic query
#'   result <- get_locus_information("FGA")
#'
#'   # Print the result
#'   print(result)
#' }
#' @export
get_locus_information <- function(locus) {

  endpoint <- paste0("LociByName/Loci/", locus)

  response <- get_endpoint(endpoint)

  response
}
