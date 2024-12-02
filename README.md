
<!-- README.md is generated from README.Rmd. Please edit that file -->

# STRbaseclient

<!-- badges: start -->
<!-- badges: end -->

STRbaseclient is an R-package for accessing
[NIST](https://www.nist.gov/)’s [STRbase](https://strbase.nist.gov/)
API. STRbase hosts information about Short Tandem Repeats (STRs)
relevant to the human identity community. Resources include STR general
information, observations of variant alleles by the forensic community,
STR typing kits, and population data among other topics. See
[Introduction to STRbase](https://strbase.nist.gov/Others/Intro) for
more information.

Note that the author of STRbaseclient is not affiliated with NIST.

## Installation

You can install the development version of STRbaseclient from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mkruijver/STRbaseclient")
```

## Usage

First we pull a list of loci, similar to the left-hand side of the
landing page of STRbase:

``` r
library(STRbaseclient)

locus_category_table <- get_locus_category_table()
head(locus_category_table)
#>   lociId   locusCategory    locus
#> 1      2 CODIS Core STRs   CSF1PO
#> 2      3 CODIS Core STRs D10S1248
#> 3      5 CODIS Core STRs  D12S391
#> 4      6 CODIS Core STRs  D13S317
#> 5      7 CODIS Core STRs  D16S539
#> 6      8 CODIS Core STRs   D18S51
```

Let’s pull the table of variant alleles observed at the first locus
(CSF1PO):

``` r
locus_variant_alleles <- get_locus_variant_alleles_table("CSF1PO")
head(locus_variant_alleles)
#>   alleleCall numberOfVariantAlleleRecords
#> 1          5                           10
#> 2        5.3                            1
#> 3          6                           14
#> 4        6.1                            1
#> 5        6.3                            2
#> 6          7                           14
```

A similar function retrieves the tri-alleles table:

``` r
tri_alleles <- get_locus_tri_alleles_table("CSF1PO")
head(tri_alleles)
#>    locus allele_calls            amplificationKit  instrument submittedDate
#> 1 CSF1PO     7, 8, 11 Identifiler (Direct) (Plus)    ABI 3130          <NA>
#> 2 CSF1PO    8, 12, 13                        <NA>        <NA>          <NA>
#> 3 CSF1PO    9, 11, 12                     Cofiler     ABI 377          <NA>
#> 4 CSF1PO    9, 12, 13                     Cofiler     ABI 310          <NA>
#> 5 CSF1PO    9, 12, 13 Identifiler (Direct) (Plus) ABI 3130 XL          <NA>
#> 6 CSF1PO   10, 11, 12                     Cofiler     ABI 377          <NA>
#>   imageURL
#> 1       NA
#> 2       NA
#> 3       NA
#> 4       NA
#> 5       NA
#> 6       NA
```

The *get_locus_chromosome_location_and_allele_reference_table* function
can be used to look up the location of a locus with respect to the
reference genomes:

``` r
get_locus_chromosome_location_and_allele_reference_table("CSF1PO")
#>    locus   assembly chromosome     start       end CE bracketSequence
#> 1 CSF1PO GRCh38.p12          5 150076324 150076375 13        [ATCT]13
#> 2 CSF1PO GRCh37.p13          5 149455887 149455938 13        [ATCT]13
```

## Advanced usage

The *get\_…* functions return DataFrames with roughly the same
information as the STRbase website. The API often returns a richer
dataset which can be inspected when calling a function with the
*return_raw_data* argument set to *TRUE*. For example:

``` r
locus_locations <- get_locus_chromosome_location_and_allele_reference_table("CSF1PO", return_raw_data = TRUE)
str(locus_locations)
#> List of 5
#>  $ selectedLoci       :List of 19
#>   ..$ lociId          : int 2
#>   ..$ machineName     : chr "CSF1PO"
#>   ..$ seqPattern      : chr "[ATCT]n"
#>   ..$ otherSeqPatterns: NULL
#>   ..$ strSeqId        : chr "PRJNA380561"
#>   ..$ cytoGericLoc    : chr "5q32"
#>   ..$ citation        : chr "Hammond HA, Jin L, Zhong Y, Caskey CT, Chakraborty R. Evaluation of 13 short tandem repeat loci for use in pers"| __truncated__
#>   ..$ pubMedId        : chr "7912887"
#>   ..$ nomendature     : chr "originally reverse sequence"
#>   ..$ archivedNames   : chr "CSF"
#>   ..$ notes           : NULL
#>   ..$ chromosomeId    : int 5
#>   ..$ chromosome      :List of 4
#>   .. ..$ id              : int 5
#>   .. ..$ label           : chr "5"
#>   .. ..$ urlNcBiQryString: chr "NC_000005"
#>   .. ..$ fullLabel       : chr "Chromosome 5"
#>   ..$ submitDate      : NULL
#>   ..$ submitWho       : NULL
#>   ..$ curateDate      : NULL
#>   ..$ curateWho       : NULL
#>   ..$ recordStatus    : int 1
#>   ..$ curateNotes     : NULL
#>  $ categoryList       :'data.frame': 2 obs. of  28 variables:
#>   ..$ loci.lociId                     : int [1:2] 2 2
#>   ..$ loci.machineName                : chr [1:2] "CSF1PO" "CSF1PO"
#>   ..$ loci.seqPattern                 : chr [1:2] "[ATCT]n" "[ATCT]n"
#>   ..$ loci.otherSeqPatterns           : logi [1:2] NA NA
#>   ..$ loci.strSeqId                   : chr [1:2] "PRJNA380561" "PRJNA380561"
#>   ..$ loci.cytoGericLoc               : chr [1:2] "5q32" "5q32"
#>   ..$ loci.citation                   : chr [1:2] "Hammond HA, Jin L, Zhong Y, Caskey CT, Chakraborty R. Evaluation of 13 short tandem repeat loci for use in pers"| __truncated__ "Hammond HA, Jin L, Zhong Y, Caskey CT, Chakraborty R. Evaluation of 13 short tandem repeat loci for use in pers"| __truncated__
#>   ..$ loci.pubMedId                   : chr [1:2] "7912887" "7912887"
#>   ..$ loci.nomendature                : chr [1:2] "originally reverse sequence" "originally reverse sequence"
#>   ..$ loci.archivedNames              : chr [1:2] "CSF" "CSF"
#>   ..$ loci.notes                      : logi [1:2] NA NA
#>   ..$ loci.chromosomeId               : int [1:2] 5 5
#>   ..$ loci.submitDate                 : logi [1:2] NA NA
#>   ..$ loci.submitWho                  : logi [1:2] NA NA
#>   ..$ loci.curateDate                 : logi [1:2] NA NA
#>   ..$ loci.curateWho                  : logi [1:2] NA NA
#>   ..$ loci.recordStatus               : int [1:2] 1 1
#>   ..$ loci.curateNotes                : logi [1:2] NA NA
#>   ..$ loci.chromosome.id              : int [1:2] 5 5
#>   ..$ loci.chromosome.label           : chr [1:2] "5" "5"
#>   ..$ loci.chromosome.urlNcBiQryString: chr [1:2] "NC_000005" "NC_000005"
#>   ..$ loci.chromosome.fullLabel       : chr [1:2] "Chromosome 5" "Chromosome 5"
#>   ..$ category.id                     : int [1:2] 5 6
#>   ..$ category.categoryLabel          : chr [1:2] "CODIS Loci" "US Core Loci"
#>   ..$ category.parentId               : int [1:2] 0 4
#>   ..$ category.statusFlag             : logi [1:2] TRUE TRUE
#>   ..$ category.categoryTypeId         : int [1:2] 1 1
#>   ..$ category.categoryType           : logi [1:2] NA NA
#>  $ mutationList       :List of 10
#>   ..$ id            : int 1
#>   ..$ ratePercentage: num 0.16
#>   ..$ rateUpBound   : NULL
#>   ..$ rateLowBound  : NULL
#>   ..$ literatureSrc : chr "Table 14.5 of Butler, 2017"
#>   ..$ dataSrc       : chr "AABB03"
#>   ..$ sortOrder     : int 1
#>   ..$ statusFlag    : logi TRUE
#>   ..$ locusId       : int 2
#>   ..$ loci          :List of 19
#>   .. ..$ lociId          : int 2
#>   .. ..$ machineName     : chr "CSF1PO"
#>   .. ..$ seqPattern      : chr "[ATCT]n"
#>   .. ..$ otherSeqPatterns: NULL
#>   .. ..$ strSeqId        : chr "PRJNA380561"
#>   .. ..$ cytoGericLoc    : chr "5q32"
#>   .. ..$ citation        : chr "Hammond HA, Jin L, Zhong Y, Caskey CT, Chakraborty R. Evaluation of 13 short tandem repeat loci for use in pers"| __truncated__
#>   .. ..$ pubMedId        : chr "7912887"
#>   .. ..$ nomendature     : chr "originally reverse sequence"
#>   .. ..$ archivedNames   : chr "CSF"
#>   .. ..$ notes           : NULL
#>   .. ..$ chromosomeId    : int 5
#>   .. ..$ chromosome      :List of 4
#>   .. .. ..$ id              : int 5
#>   .. .. ..$ label           : chr "5"
#>   .. .. ..$ urlNcBiQryString: chr "NC_000005"
#>   .. .. ..$ fullLabel       : chr "Chromosome 5"
#>   .. ..$ submitDate      : NULL
#>   .. ..$ submitWho       : NULL
#>   .. ..$ curateDate      : NULL
#>   .. ..$ curateWho       : NULL
#>   .. ..$ recordStatus    : int 1
#>   .. ..$ curateNotes     : NULL
#>  $ relLociAssemblyList:'data.frame': 2 obs. of  39 variables:
#>   ..$ pKey                            : int [1:2] 1 37
#>   ..$ lociId                          : int [1:2] 2 2
#>   ..$ subLocusName                    : logi [1:2] NA NA
#>   ..$ assemblyId                      : int [1:2] 32 19
#>   ..$ locusStart                      : int [1:2] 150076324 149455887
#>   ..$ locusEnd                        : int [1:2] 150076375 149455938
#>   ..$ refCE                           : int [1:2] 13 13
#>   ..$ refBracketSeq                   : chr [1:2] "[ATCT]13" "[ATCT]13"
#>   ..$ statusFlag                      : logi [1:2] TRUE TRUE
#>   ..$ loci.lociId                     : int [1:2] 2 2
#>   ..$ loci.machineName                : chr [1:2] "CSF1PO" "CSF1PO"
#>   ..$ loci.seqPattern                 : chr [1:2] "[ATCT]n" "[ATCT]n"
#>   ..$ loci.otherSeqPatterns           : logi [1:2] NA NA
#>   ..$ loci.strSeqId                   : chr [1:2] "PRJNA380561" "PRJNA380561"
#>   ..$ loci.cytoGericLoc               : chr [1:2] "5q32" "5q32"
#>   ..$ loci.citation                   : chr [1:2] "Hammond HA, Jin L, Zhong Y, Caskey CT, Chakraborty R. Evaluation of 13 short tandem repeat loci for use in pers"| __truncated__ "Hammond HA, Jin L, Zhong Y, Caskey CT, Chakraborty R. Evaluation of 13 short tandem repeat loci for use in pers"| __truncated__
#>   ..$ loci.pubMedId                   : chr [1:2] "7912887" "7912887"
#>   ..$ loci.nomendature                : chr [1:2] "originally reverse sequence" "originally reverse sequence"
#>   ..$ loci.archivedNames              : chr [1:2] "CSF" "CSF"
#>   ..$ loci.notes                      : logi [1:2] NA NA
#>   ..$ loci.chromosomeId               : int [1:2] 5 5
#>   ..$ loci.submitDate                 : logi [1:2] NA NA
#>   ..$ loci.submitWho                  : logi [1:2] NA NA
#>   ..$ loci.curateDate                 : logi [1:2] NA NA
#>   ..$ loci.curateWho                  : logi [1:2] NA NA
#>   ..$ loci.recordStatus               : int [1:2] 1 1
#>   ..$ loci.curateNotes                : logi [1:2] NA NA
#>   ..$ loci.chromosome.id              : int [1:2] 5 5
#>   ..$ loci.chromosome.label           : chr [1:2] "5" "5"
#>   ..$ loci.chromosome.urlNcBiQryString: chr [1:2] "NC_000005" "NC_000005"
#>   ..$ loci.chromosome.fullLabel       : chr [1:2] "Chromosome 5" "Chromosome 5"
#>   ..$ assembly.id                     : int [1:2] 32 19
#>   ..$ assembly.buildingNum            : int [1:2] 38 37
#>   ..$ assembly.patchNum               : int [1:2] 12 13
#>   ..$ assembly.urlQueryString         : chr [1:2] "GCF_000001405.38" "GCF_000001405.25"
#>   ..$ assembly.namePrefix             : chr [1:2] "GRCh" "GRCh"
#>   ..$ assembly.label                  : chr [1:2] "Genome Reference Consortium Human Build 38 patch release 12" "Genome Reference Consortium Human Build 37 patch release 13"
#>   ..$ assembly.statusFlag             : logi [1:2] TRUE TRUE
#>   ..$ assembly.effectiveDate          : chr [1:2] "2017-12-21T00:00:00" "2013-06-28T00:00:00"
#>  $ chromosomeSeqList  :'data.frame': 10 obs. of  19 variables:
#>   ..$ id                         : int [1:10] 48 49 50 51 52 53 54 55 56 57
#>   ..$ chromosomeId               : int [1:10] 5 5 5 5 5 5 5 5 5 5
#>   ..$ assemblyId                 : int [1:10] NA NA NA NA NA NA NA NA 19 32
#>   ..$ ncbiRefSeqId               : int [1:10] 1 2 3 4 5 6 7 8 9 10
#>   ..$ ncbiRefLabel               : logi [1:10] NA NA NA NA NA NA ...
#>   ..$ startDate                  : logi [1:10] NA NA NA NA NA NA ...
#>   ..$ endDate                    : logi [1:10] NA NA NA NA NA NA ...
#>   ..$ chromosome.id              : int [1:10] 5 5 5 5 5 5 5 5 5 5
#>   ..$ chromosome.label           : chr [1:10] "5" "5" "5" "5" ...
#>   ..$ chromosome.urlNcBiQryString: chr [1:10] "NC_000005" "NC_000005" "NC_000005" "NC_000005" ...
#>   ..$ chromosome.fullLabel       : chr [1:10] "Chromosome 5" "Chromosome 5" "Chromosome 5" "Chromosome 5" ...
#>   ..$ assembly.id                : int [1:10] NA NA NA NA NA NA NA NA 19 32
#>   ..$ assembly.buildingNum       : int [1:10] NA NA NA NA NA NA NA NA 37 38
#>   ..$ assembly.patchNum          : int [1:10] NA NA NA NA NA NA NA NA 13 12
#>   ..$ assembly.urlQueryString    : chr [1:10] NA NA NA NA ...
#>   ..$ assembly.namePrefix        : chr [1:10] NA NA NA NA ...
#>   ..$ assembly.label             : chr [1:10] NA NA NA NA ...
#>   ..$ assembly.statusFlag        : logi [1:10] NA NA NA NA NA NA ...
#>   ..$ assembly.effectiveDate     : chr [1:10] NA NA NA NA ...
```

It is also possible to query an arbitrary API endpoint using the
*get_endpoint* function:

``` r
locus <- "SE33"
  
endpoint <- paste0("LociByName/Loci/", locus)
response <- get_endpoint(endpoint)

response
#> $lociId
#> [1] 73
#> 
#> $machineName
#> [1] "SE33"
#> 
#> $seqPattern
#> [1] "[CTTT]n"
#> 
#> $otherSeqPatterns
#> [1] "[CTTT]n TT [CTTT]n, [CTTT]n CT [CTTT]n"
#> 
#> $strSeqId
#> [1] "PRJNA380562"
#> 
#> $cytoGericLoc
#> [1] "6q15"
#> 
#> $citation
#> [1] "Urquhart A, Kimpton CP, Gill P. Sequence variability of the tetranucleotide repeat of the human beta-actin related pseudogene H-beta-Ac-psi-2 (ACTBP2) locus. Hum Genet. 1993 Dec;92(6):637-8. PubMed PMID: 8262529."
#> 
#> $pubMedId
#> [1] "8262529"
#> 
#> $nomendature
#> [1] "originally reverse sequence"
#> 
#> $archivedNames
#> [1] "ACTBP2"
#> 
#> $notes
#> NULL
#> 
#> $chromosomeId
#> [1] 6
#> 
#> $chromosome
#> NULL
#> 
#> $submitDate
#> NULL
#> 
#> $submitWho
#> NULL
#> 
#> $curateDate
#> NULL
#> 
#> $curateWho
#> NULL
#> 
#> $recordStatus
#> [1] 1
#> 
#> $curateNotes
#> NULL
```

To retrieve the raw JSON response, use the *get_endpoint_JSON* function:

``` r
response_JSON <- get_endpoint_JSON(endpoint)

response_JSON
#> [1] "{\"lociId\":73,\"machineName\":\"SE33\",\"seqPattern\":\"[CTTT]n\",\"otherSeqPatterns\":\"[CTTT]n TT [CTTT]n, [CTTT]n CT [CTTT]n\",\"strSeqId\":\"PRJNA380562\",\"cytoGericLoc\":\"6q15\",\"citation\":\"Urquhart A, Kimpton CP, Gill P. Sequence variability of the tetranucleotide repeat of the human beta-actin related pseudogene H-beta-Ac-psi-2 (ACTBP2) locus. Hum Genet. 1993 Dec;92(6):637-8. PubMed PMID: 8262529.\",\"pubMedId\":\"8262529\",\"nomendature\":\"originally reverse sequence\",\"archivedNames\":\"ACTBP2\",\"notes\":null,\"chromosomeId\":6,\"chromosome\":null,\"submitDate\":null,\"submitWho\":null,\"curateDate\":null,\"curateWho\":null,\"recordStatus\":1,\"curateNotes\":null}"
```
