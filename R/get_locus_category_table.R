#' Retrieves the Locus Category table
#'
#' The `get_locus_category_table` function queries the STRbase API and retrieves the Locus Category table.
#'
#' @param return_raw_data When `FALSE` (default), a selection of variables will be returned consistent with the web interface. When `TRUE`, all raw data available through the API will be returned.
#' @return A DataFrame.
#' @examples
#' \dontrun{
#'   # Basic query
#'   result <- get_locus_category_table()
#'
#'   # Print the result
#'   print(result)
#' }
#' @export
get_locus_category_table <- function(return_raw_data = FALSE) {

  # retrieve raw data
  lac <- get_endpoint("LociAliasCategory")

  if (return_raw_data){
    return(lac)
  }
  else{

    lac_dt <- data.table(lac)

    # filter only the relevant loci shown in the web UI
    lac_dt_active <- lac_dt[loci.recordStatus == 1]

    # extract relevant columns
    lac_dt_active_relevant_cols <- lac_dt_active[locialias.isPrimary==TRUE,
                                                 .(locusCategory = category.categoryLabel, locus = locialias.aliasText),
                                                 .(lociId = loci.lociId)]

    # sort as in web UI
    return(as.data.frame(lac_dt_active_relevant_cols[order(locusCategory, locus)]))
  }


}
