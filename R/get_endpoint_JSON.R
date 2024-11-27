#' Queries an Endpoint
#'
#' The `get_endpoint` function queries a STRbase API endpoint and retrieves data.
#'
#' @param endpoint The specific endpoint to query. For example `"Loci"`.
#' @param params A named list of query parameters to include in the request.
#' @return A character vector of length 1.
#' @examples
#' \dontrun{
#'   # Basic query
#'   result <- get_endpoint_JSON(
#'     endpoint = "Loci")
#'   )
#'
#'   # Print the result
#'   print(result)
#' }
#' @seealso [get_endpoint] for a version that returns a DataFrame.
#' @export
get_endpoint_JSON <- function(endpoint, params = list()) {
  if (missing(endpoint)){
    stop("Parameter endpoint is required")
  }

  # Construct the full URL
  url <- paste0(API_BASE_URL, endpoint)

  # Send GET request
  response <- httr::GET(url, query = params)

  # Check for errors
  if (httr::http_error(response)) {
    stop(
      "API request failed with status: ",
      httr::status_code(response),
      "\nMessage: ",
      httr::content(response, as = "text", encoding = "UTF-8")
    )
  }

  # get JSON response as text
  content <- httr::content(response, as = "text", type = "application/json")

  return(content)
}
