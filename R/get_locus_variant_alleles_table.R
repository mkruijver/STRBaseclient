#' Retrieves the Variant Alleles table for a locus
#'
#' The `get_locus_variant_alleles_table` function queries the STRbase API and retrieves the Variant Alleles table for a locus.
#'
#' @param locus The specific locus. For example `"FGA"`.
#' @return A DataFrame.
#' @examples
#' \dontrun{
#'   # Basic query
#'   result <- get_locus_variant_alleles_table("FGA")
#'
#'   # Print the result
#'   print(result)
#' }
#' @export
get_locus_variant_alleles_table <- function(locus) {

  locus_information <- get_locus_information(locus)
  loci_id <- locus_information$lociId

  endpoint <- paste0("VariantAllele/", loci_id)

  # retrieve raw data
  df <- get_endpoint(endpoint)

  # ensure allele call is character
  df$alleleCall <- as.character(df$alleleCall)

  tabulated <- table(df$alleleCall)

  alleleCalls <- names(tabulated)
  alleleCalls_count <- as.vector(tabulated)

  # determine order to provide ordered return value
  alleleCalls_order <- order(as.numeric(alleleCalls))

  # replace 0 like the web UI
  alleleCalls[alleleCalls == "0"] <- "Greater or Less Than"

  return(data.frame(alleleCall = alleleCalls[alleleCalls_order],
             numberOfVariantAlleleRecords = alleleCalls_count[alleleCalls_order]))
}
