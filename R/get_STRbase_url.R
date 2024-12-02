get_STRBase_url <- function(filename){
  ifelse(is.na(filename),
         yes = NA,
         no = paste0(STRBASE_URL, filename))
}
