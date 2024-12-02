#' Retrieves the Locus Tri-alleles table
#'
#' The `get_locus_tri_alleles_table` function queries the STRbase API and retrieves the Locus Tri-alleles table.
#'
#' @param locus The specific locus. For example `"FGA"`.
#' @param return_raw_data When `FALSE` (default), a selection of variables will be returned consistent with the web interface. When `TRUE`, all raw data available through the API will be returned.
#' @return A DataFrame.
#' @examples
#' \dontrun{
#'   # Basic query
#'   result <- get_locus_tri_alleles_table()
#'
#'   # Print the result
#'   print(result)
#' }
#' @export
get_locus_tri_alleles_table <- function(locus, return_raw_data = FALSE) {

  # retrieve raw data
  locus_information <- get_locus_information(locus)
  loci_id <- locus_information$lociId

  ta <- get_endpoint(paste0("TriAlleleHuman/TriAllele/Active/", loci_id))


  # extract the allele calls from several columns
  allele_calls <- character(nrow(ta))

  allele_calls_col_first <- substitute_vals_with_bounds(ta,
                              col_val = "trialleles.acfirstVal",
                              col_lbound = "trialleles.acFirstLowbnd",
                              col_ubound = "trialleles.acFirstUpbnd")

  allele_calls_col_mid1 <- ta$trialleles.acMid1Val
  allele_calls_col_mid2 <- ta$trialleles.acMid2Val
  allele_calls_col_mid3 <- ta$trialleles.acMid3Val

  allele_calls_col_last <- substitute_vals_with_bounds(ta,
                                                   col_val = "trialleles.acLastVal",
                                                   col_lbound = "trialleles.acLastLowbnd",
                                                   col_ubound = "trialleles.acLastUpbnd")

  allele_calls_matrix <- cbind(allele_calls_col_first,
                      allele_calls_col_mid1,
                      allele_calls_col_mid2,
                      allele_calls_col_mid3,
                      allele_calls_col_last)

  # remove NAs and combine into single value
  allele_calls <-  apply(allele_calls_matrix, 1,
        function(x) paste(x[!is.na(x)], collapse = ", "))

  if (return_raw_data){
    return(ta)
  }
  else{
    # show only the relevant data as shown in the web UI
    return(data.frame(locus = locus,
                      allele_calls = allele_calls,
                      amplificationKit = ta$trialleles.kit.kitLabel,
                      instrument = ta$trialleles.instruments.label,
                      submittedDate = ta$trialleles.submitDate,
                      imageURL = get_STRbase_url(ta$trialleles.imageFileName)))
  }
}
NULL

substitute_vals_with_bounds <- function(ta, col_val, col_lbound, col_ubound){
  vals <- ta[[col_val]]

  lbound <- ta[[col_lbound]]
  ubound <- ta[[col_ubound]]

  lbound_idx_not_na <- !is.na(lbound)
  ubound_idx_not_na <- !is.na(ubound)

  if (length(lbound_idx_not_na) > 0){
    vals[lbound_idx_not_na] <- paste0(">", lbound[lbound_idx_not_na])
  }
  if (length(ubound_idx_not_na) > 0){
    vals[ubound_idx_not_na] <- paste0("<", ubound[ubound_idx_not_na])
  }

  vals
}
