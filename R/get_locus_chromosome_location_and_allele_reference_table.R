#' Retrieves the Chromosome Location and Allele Reference table for a locus
#'
#' The `get_locus_chromosome_location_and_allele_reference_table` function queries the STRbase API and retrieves the Chromsome Location and Allele Reference table for a locus.
#'
#' @param locus The specific locus. For example `"vWA"`.
#' @param return_raw_data When `FALSE` (default), a selection of variables will be returned consistent with the web interface. When `TRUE`, all raw data available through the API will be returned.
#' @return A DataFrame.
#' @examples
#' \dontrun{
#'   # Basic query
#'   result <- get_locus_chromosome_location_and_allele_reference_table("vWA")
#'
#'   # Print the result
#'   print(result)
#' }
#' @export
get_locus_chromosome_location_and_allele_reference_table <- function(locus, return_raw_data = FALSE) {

  locus_information <- get_locus_information(locus)
  loci_id <- locus_information$lociId

  endpoint <- paste0("TabSequence/Sequence/Active/", loci_id)

  # retrieve raw data
  df <- get_endpoint(endpoint)

  endpoint <- paste0("LociById/", loci_id)

  # retrieve raw data
  df <- get_endpoint(endpoint)

  if (return_raw_data){
    return(df)
  }
  else{
    assembly <- paste0("GRCh", df$relLociAssemblyList$assembly.buildingNum,
                       ".p", df$relLociAssemblyList$assembly.patchNum)

    chromosome <- df$relLociAssemblyList$loci.chromosome.label

    CE <- df$relLociAssemblyList$refCE

    bracketSequence <- df$relLociAssemblyList$refBracketSeq

    start <- df$relLociAssemblyList$locusStart
    end <- df$relLociAssemblyList$locusEnd

    web_df <- data.frame(locus = locus,
                         assembly = assembly,
                         chromosome = chromosome,
                         start = start,
                         end = end,
                         CE = CE,
                         bracketSequence)

    return(web_df)
  }
}
