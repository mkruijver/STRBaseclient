get_STRbase_url <- function(filename){
  ifelse(is.na(filename),
         yes = NA,
         no = paste0(STRBASE_URL, filename))
}
