# Flatten Policy File ("Un-nest" the Nested Structure of Policy File)

This function reshapes the policy file from nested to flat structure by
cycling through the top-level categories of a policy file and un-nesting
all subcategories to create a single level list of all categories and
subcategories.

## Usage

``` r
flatten_policy(policy)
```

## Arguments

- policy:

  A valid policy file stored as a list.

## Value

A single level list of all categories and subcategories ordered where
all leaves will precede the parent category in the list order.

## Examples

``` r
flatten_policy(policy_demo)
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
