#' Read Gradescope .csv
#'
#' This functions reads the Gradescope .csv, checks for correct format.
#'  
#'
#' @param path Path to Gradescope CSV
#' @param verbose whether or not to print messages
#'
#' @return dataframe
#' @importFrom readr read_csv
#' @importFrom dplyr mutate across cur_column mutate_at vars all_of ends_with
#' @export
read_gs <- function(path, verbose = FALSE){
  # read in csv
  gs <- read_csv(path, trim_ws = FALSE) |>
    #check format
    check_data_format()
}









#' This function takes in gradebook csv and lateness csv from Canvas
#' and aggregates them into identical format as those from Gradescope. 
#' Note that Canvas defaults assignment due time to beginning of day in lateness csv
#' regardless of true time of lateness. 
#'
#'Data is then checked for correct format.
#'
#'@param path_to_grades The path to Canvas gradebook csv
#'@param path_to_lateness The path to Canvas csv for assignment Lateness
#'
#'@return A tibble in correct format a la Gradescope
#'
#'
#'@importFrom readr read_csv
#'@importFrom  dplyr rename rename_with select left_join slice
#'@importFrom purrr discard
#'@importFrom stringr str_extract str_remove str_match
#'@importFrom hms hms
#'@importFrom lubridate as_datetime
#'@importFrom tidyr pivot_wider
read_canvas <- function(path_to_grades, path_to_lateness, verbose = FALSE){
  
  #read in grade data
  
  grades <- read_csv(path_to_grades, 
                     trim_ws = FALSE)
  
  #read in lateness data
  
  lateness_data <- read_csv(path_to_lateness, 
                            trim_ws = FALSE) 
  
  
  
  #first exrtract assignment names from grades csv
  
  #assignments are columns that end in (xxxx) with xxx being some number
  
  assignments <- stringr::str_extract(names(grades),
                                          ".+\\s*\\(\\d+\\)") 
  assignments <- purrr::discard(assignments, is.na)
  
  #remove assignment identifiers
  assignments_short <- stringr::str_remove(assignments, "\\s\\(\\d+\\)")
  
  if (any(duplicated(assignments_short))){
   stop("Duplicated Assignment Names")
  }
  
  #rename to shorter name for clarity and consistency with gradescope
  grades <- grades |>
    dplyr::rename_with(function(x) {
      stringr::str_remove(x, "\\s\\(\\d+\\)")
    },  
      assignments) |>
    dplyr::select(any_of(c(assignments_short, "Student", "ID", 
                    "SIS User ID", "SIS Login ID", "Section"))) |>
    dplyr::rename(Sections = Section)
  
  #then convert lateness into proper form
  
  #convert due dates from char to datetime
  #submitted date is already date time
  
  lateness_data$`Due Date` <- lubridate::as_datetime(lateness_data$`Due Date`, 
                                                     format = "%b %d, %Y")
  
  #find lateness in hms format to be consistent
  lateness_data$`Lateness (H:M:S)` <- lubridate::hms(hours = as.double(
    difftime(lateness_data$`Submitted Date` ,
             lateness_data$`Due Date`)
  ))
  
  #add suffix to assignment names in lateness table 
  
  
  
  
  lateness_data <- lateness_data |>
        dplyr::select(c(`Student ID`, `Assignment Name`,
                        `Submitted Date`, `Lateness (H:M:S)`)) |>
        dplyr::rename(`Submission Time` = `Submitted Date`) |>
        tidyr::pivot_wider(names_from = `Assignment Name`,
                           values_from = c(`Lateness (H:M:S)`, `Submission Time`),
                           names_glue = "{`Assignment Name`} - {.value}",
                           values_fill = list(`Lateness (H:M:S)` = lubridate::hms(hours = 0),
                                              `Submission Time` = lubridate::as_datetime(0))
                           
                                           )
  
  seen_late_assignments <- stringr::str_match(names(lateness_data), 
                                                 "(.+)\\s-\\sSubmission\\sTime")
  
  #find which assignments have no late submissions
  unseen_late_assignments <- assignments_short[!(assignments_short %in% seen_late_assignments)] 
  
  #add columns for them
  unseen_submission <- paste0(unseen_late_assignments , 
                              " - Submission Time")
  #add placeholder value of 1970 since real value is unknown
  lateness_data[unseen_submission] <- lubridate::as_datetime(0)
  
  unseen_lateness <- paste0(unseen_late_assignments , 
                            " - Lateness (H:M:S)")
  #not late at all
  lateness_data[unseen_lateness] <- lubridate::hms(hours = 0)
  
  
  #now merge tables
  
  grades <- grades |>
    dplyr::left_join(lateness_data, 
                     by = dplyr::join_by(ID == `Student ID`),
                     unmatched = "error",
                     relationship = "one-to-one")
  
  #now take care of whether any students have no late assignments
  
  sub_cols <- paste0(assignments_short, " - Submission Time")
  
  late_cols <- paste0(assignments_short, " - Lateness (H:M:S)")
  
  #check for NAs and replace with suitable values
  
  
  grades[sub_cols][is.na(grades[sub_cols])] <- lubridate::as_datetime(0)
  
  grades[late_cols][is.na(grades[late_cols])] <- lubridate::hms(hours = 0)
  
  #now we have handled lateness 
  #time to turn to dealing with other things
  
  
  #now handle max points
  
  max_points <- dplyr::filter(grades, Student == "    Points Possible") |>
    dplyr::select(all_of(assignments_short)) |>
    dplyr::slice(rep.int(1, nrow(grades) - 1)) |>
    dplyr::rename_with(function(x){
      paste0(x, " - Max Points")
    })
  
  
  grades <- dplyr::filter(grades, Student != "    Points Possible")
  
  #now add max points columns
  max_points$ID <- grades$ID
  grades <- dplyr::left_join(grades, max_points, 
                             by = dplyr::join_by(ID == ID))
  
  #now convert names to other style
  
  grades$`First Name` <- (stringr::str_match(grades$Student, 
                                            ".+,(.+)"))[, 2]
  grades$`Last Name` <- (stringr::str_match(grades$Student, 
                                            "(.+),.+"))[, 2]
  
  grades <- grades |>
    dplyr::select(-c("Student", "ID", "SIS Login ID")) |>
    dplyr::rename(SID = `SIS User ID`)
  
  check_data_format(grades)
  
  
  
  
}


#' Check Formatting of Gradescope Data
#'
#' This functions checks the column names throughout the Gradescope data.
#' There must be an SID column and at least one assignment.
#' It also gives an alert for what id cols and assignments are in the data.
#'
#' @param gs Gradescope data frame
#' @param verbose whether or not to print messages
#'
#' @return Same gs dataframe if no errors.
#' @export
check_data_format <- function(gs, verbose = FALSE){
  
  col_names <- colnames(gs)
  
  id_cols <- get_id_cols(gs, verbose = verbose)
  
  if ( !("SID" %in% id_cols) ){
    stop("There is no SID column")
  }
  
  assignment_names <- get_assignments(gs, verbose = verbose)
  
  if (is.null(assignment_names) | length(assignment_names) == 0){
    stop("There are no assignments in this dataframe")
  }
  
  #if correct format, return same dataframe
  return (gs)
}

#' Get the ID Columns for Gradescope Data
#'
#' This function identified the id columns from gradescope data
#'
#' @param gs  Gradescope dataframe
#' @param verbose whether or not to return an alert of assignments
#' 
#' @return a list of id columns 
#' @importFrom stringr str_replace_all regex
#' @importFrom cli cli_alert_info cli_div cli_text cli_end
#' @export

get_id_cols <- function(gs, verbose = FALSE) {
  #REGEX pattern: case INsensitive, then matches the extensions
  regex <- "(?i)( - max points| - submission time| - lateness \\(h:m:s\\))"
  
  # extract base names and excludes the extensions (max points, submission time and lateness)
  base_names <- stringr::str_replace_all(names(gs), regex, "")
  
  # Count occurrences of base names
  base_name_counts <- table(base_names)
  
  # identify base names that repeat exactly 4 times
  repeating <- names(base_name_counts[base_name_counts == 4])
  
  # identify columns to keep: those not repeating 4 times
  columns_to_keep <- names(gs)[!(base_names %in% repeating)]
  
  alert <- function() {
    cli::cli_div(theme = list(span.emph = list(color = "orange")))
    cli::cli_text("{.emph Important Message}")
    cli::cli_end()
    cli::cli_alert_info("The ID columns from Gradescope are {columns_to_keep}")
  }
  
  if (verbose){
    alert()
  }
  
  return(columns_to_keep)
}

#' Get the Assignment Names for Gradescope Data
#'
#' This function identified the assignments from Gradescope data
#'
#' @param gs unprocessed Gradescope dataframe
#' @param verbose whether or not to print assignment names
#' 
#' @return vector 
#' @importFrom stringr str_replace_all regex
#' @importFrom cli cli_alert_info cli_div cli_text cli_end
#' @export

get_assignments <- function(gs, verbose = FALSE){
  #REGEX pattern: case INsensitive, then matches the extensions
  #works with untouched GS dataframe so we can match the pattern
  regex = "(?i)( - max points| - submission time| - lateness \\(h:m:s\\))"
  
  # extract base names and excludes the extensions (max points, submission time and lateness)
  base_names <- stringr::str_replace_all(names(gs), regex, "")
  
  # Count occurrences of base names
  base_name_counts <- table(base_names)
  
  # identify base names that repeat exactly 4 times
  assignment_names <- names(base_name_counts[base_name_counts == 4])
  
  alert <- function() {
    cli::cli_div(theme = list(span.emph = list(color = "orange")))
    cli::cli_text("{.emph Important Message}")
    cli::cli_end()
    cli::cli_alert_info("The assignments from Gradescope are {assignment_names}")
  }
  
  if (verbose){
    alert()
  }
  
  return (assignment_names)
}