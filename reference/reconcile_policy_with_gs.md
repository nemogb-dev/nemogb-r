# Reconcile Policy File with Gradescope Data

This function drops any assignments present in the policy file that are
not in the Gradescope data, making sure that both the policy file and
Gradescope data are compatible. This function also sets any default
values not explicitly specified in the policy file but required for
grading.

## Usage

``` r
reconcile_policy_with_gs(policy, gs, verbose = FALSE)
```

## Arguments

- policy:

  R list of a valid policy file

- gs:

  Gradescope data

- verbose:

  Whether or not to print messages; if FALSE, still throws error if no
  assignments found in gs

## Value

A policy list

## Examples

``` r
reconcile_policy_with_gs(policy = policy_demo, gs = gs_demo, verbose = TRUE)
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
#> $categories[[1]]$score
#> [1] "raw_over_max"
#> 
#> $categories[[1]]$aggregation
#> [1] "weighted_by_points"
#> 
#> $categories[[1]]$assignments
#> [1] "Lab 1" "Lab 2" "Lab 3" "Lab 4" "Lab 5" "Lab 6"
#> 
#> $categories[[1]]$aggregation_max_pts
#> [1] "sum_max_pts"
#> 
#> $categories[[1]]$aggregation_lateness
#> [1] "max_lateness"
#> 
#> 
#> $categories[[2]]
#> $categories[[2]]$category
#> [1] "Discussion"
#> 
#> $categories[[2]]$score
#> [1] "raw_over_max"
#> 
#> $categories[[2]]$aggregation
#> [1] "equally_weighted"
#> 
#> $categories[[2]]$assignments
#> [1] "Discussion 1" "Discussion 2"
#> 
#> $categories[[2]]$aggregation_max_pts
#> [1] "sum_max_pts"
#> 
#> $categories[[2]]$aggregation_lateness
#> [1] "max_lateness"
#> 
#> 
#> $categories[[3]]
#> $categories[[3]]$category
#> [1] "Midterm Exam"
#> 
#> $categories[[3]]$score
#> [1] "raw_over_max"
#> 
#> $categories[[3]]$aggregation
#> [1] "none"
#> 
#> $categories[[3]]$assignments
#> [1] "Midterm"
#> 
#> $categories[[3]]$aggregation_max_pts
#> [1] "sum_max_pts"
#> 
#> $categories[[3]]$aggregation_lateness
#> [1] "max_lateness"
#> 
#> 
#> $categories[[4]]
#> $categories[[4]]$category
#> [1] "Final Exam"
#> 
#> $categories[[4]]$score
#> [1] "raw_over_max"
#> 
#> $categories[[4]]$aggregation
#> [1] "none"
#> 
#> $categories[[4]]$assignments
#> [1] "Final"
#> 
#> $categories[[4]]$aggregation_max_pts
#> [1] "sum_max_pts"
#> 
#> $categories[[4]]$aggregation_lateness
#> [1] "max_lateness"
#> 
#> 
#> $categories[[5]]
#> $categories[[5]]$category
#> [1] "Overall Grade"
#> 
#> $categories[[5]]$score
#> [1] "raw_over_max"
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
#> $categories[[5]]$aggregation_max_pts
#> [1] "sum_max_pts"
#> 
#> $categories[[5]]$aggregation_lateness
#> [1] "max_lateness"
#> 
#> 
#> 
```
