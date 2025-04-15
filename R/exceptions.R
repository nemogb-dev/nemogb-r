calculate_grades_with_exceptions <- function(gs = gs, policy = policy){
  # if no exceptions
  if (is.null(policy$exceptions) | length(policy$exceptions) == 0){
    calculate_grades(gs, policy)
  }
}