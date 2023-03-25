library(tibble)
library(ggplot2)
library(repoRter.nih)
library(ggrepel)
library(dplyr)
library(scales)
library(tufte)
library(data.table)
data("nih_fields")

#takes PI name as string
repoRter_data_PI <- function(PI_name){
  
  
  fields <- nih_fields %>%
    filter(response_name %in%
             c("appl_id", "fiscal_year", "award_amount", "project_title")) %>%
    pull(include_name)
  
  req <- make_req(criteria = 
                    list(
                      include_active_projects = TRUE,
                      pi_names = list(first_name = character(1),
                                      last_name = character(1),
                                      any_name = c(PI_name))
                    ),
                  include_fields = fields,
                  message = TRUE)
  
  res <- get_nih_data(req)
  
  colnames(res)
  print(res)
  
  return(res)
  
}


PI_list = list("Sean McSweeney")


for (name in PI_list){
  
  grant_info = repoRter_data_PI(name)
  print(grant_info)
  write.table(grant_info, file = "output.txt", sep = " ")

  }





