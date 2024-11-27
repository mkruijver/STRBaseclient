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

  # order alleles from small to large by numeric order
  df_o <- order(as.numeric(ifelse(df$alleleCall == "0", "-1", df$alleleCall)))

  # replace 0 like the web UI
  df$alleleCall[df$alleleCall == "0"] <- "Greater or Less Than"

  # convert to data.table and query
  dt <- data.table::as.data.table(df[df_o,])

  dt_queried <- as.data.frame(dt[,
                                 .(numberOfVariantAlleleRecords = .N),
                                 alleleCall])

  dt_queried
}
