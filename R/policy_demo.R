#' Simple Policy Demo File
#'
#' A demo policy file that mimics a hypothetical class syllabus
#' 
#'
#' @format A list of three nested lists
#' \describe{
#'   \item{COURSEWIDE}{first nested list with general information about the class}
#'   \item{course_name}{name of the course}
#'   \item{description}{any relevant course description, purely for the user}
#'   \item{CATEGORIES}{second nested list where syllabus is broken down into categories with their respective grading criteria}
#'   \item{category}{category name}
#'   \item{aggregation}{how the assignment scores are aggregated into the category score}
#'   \item{weight}{how much this category is weighted in the overarching grade}
#'   \item{assignments}{list of assignment names that falls into this category}
#'   ...
#' }
#' @examples
#' policy_demo
#' 
#' # yaml:as_yaml(policy_demo)
#' 
"policy_demo"
