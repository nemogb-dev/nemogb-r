calculate_grades_with_exceptions <- function(gs = gs, policy = policy){
  # if no exceptions
  if (is.null(policy$exceptions) | length(policy$exceptions) == 0){
    calculate_grades(gs, policy)
  } else{
    policy |>
      separate_policies() |>
      calculate_grades_with_exceptions()
  }
}

separate_policies <- function(policy){
  policies <- list(policy = list(policy), gs = list(gs))
  for (exception in policy$exceptions){
    # find indices of exception category in full policy
    index <- find_indices(policy$categories, exception$category)
    # if exception applies to existing category
    if (length(index) > 0) {
      # add truncated gs
      policies$gs <- append(policies$gs, list(filter(gs, SID %in% exception$SID)))
      #remove exception students from initial gs
      policies[["gs"]][[1]] <-filter(gs, !(SID %in% exception$SID))
      #add policy with exception to policy
      exception$SID <- NULL
      index_cmd <- paste0("policy$categories[[", paste(index, collapse = "]]$assignments[["), "]] <- exception")
      eval(parse(text = index_cmd))
    } else {
      warning("Exception is creating a new category")
    }
  }
  return (policies)
}

calculate_grades_with_exceptions <- function(policies, gs){
  purrr::map2(policies$gs, policies$policy, calculate_grades)
}

find_indices <- function(lst, target, current_index = c()) {
  indices <- c()
  
  for (i in seq_along(lst)) {
    if (is.list(lst[[i]]) && !is.null(lst[[i]]$category) && identical(lst[[i]]$category, target)) {
      indices <- c(current_index, i)
      break
    } else if (is.list(lst[[i]]) && !is.null(lst[[i]]$assignments)) {
      indices <- find_indices(lst[[i]]$assignments, target, c(current_index, i))
    }
    
    if (length(indices) > 0) {
      break
    }
  }
  
  if (length(indices) == 0) {
    return(NULL)
  }
  
  return(indices)
}
