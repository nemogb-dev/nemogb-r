# Process Policy File

This function processes the policy file in order to compute grades and
flattens the nested structure of the file.

## Usage

``` r
process_policy(policy, verbose = FALSE)
```

## Arguments

- policy:

  R list of a valid policy file

- verbose:

  Whether or not to print messages and warnings

## Value

a (un-nested) flattened policy R list

## Examples

``` r
process_policy(policy_demo, verbose = TRUE)
#> $coursewide
#> $coursewide$course_name
#> [1] "Stat 101"
#> 
#> $coursewide$description
#> [1] "syllabus for gs_demo"
#> 
#> 
#> $categories
#> $categories[[1]]
#> $categories[[1]]$category
#> [1] "Labs"
#> 
#> $categories[[1]]$aggregation
#> [1] "weighted_by_points"
#> 
#> $categories[[1]]$assignments
#> [1] "Lab 1" "Lab 2" "Lab 3" "Lab 4" "Lab 5" "Lab 6"
#> 
#> 
#> $categories[[2]]
#> $categories[[2]]$category
#> [1] "Discussion"
#> 
#> $categories[[2]]$aggregation
#> [1] "equally_weighted"
#> 
#> $categories[[2]]$assignments
#> [1] "Discussion 1" "Discussion 2"
#> 
#> 
#> $categories[[3]]
#> $categories[[3]]$category
#> [1] "Midterm Exam"
#> 
#> $categories[[3]]$aggregation
#> [1] "none"
#> 
#> $categories[[3]]$assignments
#> [1] "Midterm"
#> 
#> 
#> $categories[[4]]
#> $categories[[4]]$category
#> [1] "Final Exam"
#> 
#> $categories[[4]]$aggregation
#> [1] "none"
#> 
#> $categories[[4]]$assignments
#> [1] "Final"
#> 
#> 
#> $categories[[5]]
#> $categories[[5]]$category
#> [1] "Overall Grade"
#> 
#> $categories[[5]]$aggregation
#> [1] "weighted_mean"
#> 
#> $categories[[5]]$weights
#> [1] 0.3 0.1 0.3 0.3
#> 
#> $categories[[5]]$assignments
#> [1] "Labs"       "Discussion" "Midterm"    "Final"     
#> 
#> 
#> 
```
