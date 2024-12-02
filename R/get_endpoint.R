#' Queries an Endpoint and returns a DataFrame
#'
#' The `get_endpoint` function queries a STRBase API endpoint and retrieves data.
#'
#' @param endpoint The specific endpoint to query. For example `"Loci"`.
#' @param params A named list of query parameters to include in the request.
#' @return A character vector of length 1.
#' @examples
#' \dontrun{
#'   # Basic query
#'   result <- get_endpoint(
#'     endpoint = "Loci")
#'   )
#'
#'   # Print the result
#'   print(result)
#' }
#' @seealso [get_endpoint_JSON] for a version that returns the raw JSON response.
#' @export
get_endpoint <- function(endpoint, params = list()) {

  json_content <- get_endpoint_JSON(endpoint, params)

  # Convert the JSON response to a data frame
  df <- jsonlite::fromJSON(json_content, flatten = TRUE)

  return(df)
}
