#' Retrieves the Locus Category table
#'
#' The `get_locus_category_table` function queries the STRBase API and retrieves the Locus Category table.
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

    # filter only the relevant loci shown in the web UI
    idx <- lac$loci.recordStatus == 1 & lac$locialias.isPrimary

    lac_df <- data.frame(lociId = lac$loci.lociId[idx],
               locusCategory = lac$category.categoryLabel[idx],
               locus = lac$locialias.aliasText[idx])

    # sort as in web UI
    lac_df_ordered <- lac_df[order(lac_df$locusCategory, lac_df$locus),]
    rownames(lac_df_ordered) <- NULL

    return(lac_df_ordered)
  }

}
