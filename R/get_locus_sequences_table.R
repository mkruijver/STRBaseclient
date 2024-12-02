#' Retrieves the Sequences table for a locus
#'
#' The `get_locus_sequences_table` function queries the STRBase API and retrieves the Variant Alleles table for a locus.
#'
#' @param locus The specific locus. For example `"vWA"`.
#' @param return_raw_data When `FALSE` (default), a selection of variables will be returned consistent with the web interface. When `TRUE`, all raw data available through the API will be returned.
#' @return A DataFrame.
#' @examples
#' \dontrun{
#'   # Basic query
#'   result <- get_locus_sequences_table("vWA")
#'
#'   # Print the result
#'   print(result)
#' }
#' @export
get_locus_sequences_table <- function(locus, return_raw_data = FALSE) {

  locus_information <- get_locus_information(locus)
  loci_id <- locus_information$lociId

  endpoint <- paste0("TabSequence/Sequence/Active/", loci_id)

  # retrieve raw data
  df <- get_endpoint(endpoint)

  if (return_raw_data){
    return(df)
  }
  else{

    web_df <- data.frame(accession = df$sequences.genBankAccession,
                         allele = as.character(df$sequences.lengthBasedAllele),
                         kitCodes = df$sequences.kitCodes,
                         STRnaming = df$sequences.bracketSequenceFull,
                         sequence = df$sequences.sequenceString,
                         SIDcode = df$sequences.isfgMinRangeCode,
                         coordinates = df$sequences.chromosomeLocation)

    return(web_df)
  }
}
