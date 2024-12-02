#' Retrieves the Locus Kits table
#'
#' The `get_locus_kits_table` function queries the STRbase API and retrieves the Locus Kits table.
#'
#' @param locus The specific locus. For example `"FGA"`.
#' @param return_raw_data When `FALSE` (default), a selection of variables will be returned consistent with the web interface. When `TRUE`, all raw data available through the API will be returned.
#' @return A DataFrame.
#' @examples
#' \dontrun{
#'   # Basic query
#'   result <- get_locus_kits_table()
#'
#'   # Print the result
#'   print(result)
#' }
#' @export
get_locus_kits_table <- function(locus, return_raw_data = FALSE) {

  # retrieve raw data
  locus_information <- get_locus_information(locus)
  loci_id <- locus_information$lociId

  lk <- get_endpoint(paste0("Kits/Kit/Active/", loci_id))

  if (return_raw_data){
    return(lk)
  }
  else{
    # show only the relevant data as shown in the web UI
    return(data.frame(locus = locus, lociId = lk$lociId,
               amplificationKit = lk$relLociKit.kit.kitLabel,
               kitStatus = lk$kit.recordStatus,
               companyName = lk$company.companyname,
               basePairStart = lk$relLociKit.basePairStart,
               basePairStop = lk$relLociKit.basePairStop))
  }
}
